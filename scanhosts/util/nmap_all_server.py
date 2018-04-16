#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# Author:Jeson
# mail:iaskjob@163.com
# Created Time: 四  6/16 11:13:39 2016
# pip install paramiko python-nmap
#========================================================================
import os
import re
import telnetlib

PROJECT_ROOT = os.path.realpath(os.path.dirname(__file__))
from pysnmp.entity.rfc3413.oneliner import cmdgen

import nmap
import time
# import sys
from scanhosts.lib.J_do import J_ssh_do
from scanhosts.lib.utils import mac_trans,sn_trans,machine_type_trans
from scanhosts.lib.SnmpVMS import SnmpESXI
from scanhosts.models import HostLoginifo
from detail.models import ConnectionInfo,VirtualServerInfo,PhysicalServerInfo,NetConnectionInfo,NetWorkInfo
from scanhosts.lib.utils import prpcrypt
from scanhosts.util.tools import sendmail
from scanhosts.lib.utils import getsysversion
from scanhosts.lib.J_do import J_net_do



import logging
logger = logging.getLogger("django")


def snmp_begin(nmap_type,ports,password_list,imoocc_key_file,syscmd_list,black_list,s_emails):
    '''
    执行系统主机扫描
    :param nmap_type:
    :param ports:
    :param password_list:
    :param imoocc_key_file:
    :param imoocc_key_file:
    :param syscmd_list:
    :param black_list:
    :param s_emails:
    :return:
    '''
    if nmap_type is None: return False

    nmap_net = '%s.0/24'%nmap_type
    nm_item = NmapDev(black_list)
    sship_list,host_list,unkown_list = nm_item.nmap_sship(ports,nmap_net)

    canlogin_list,notlogin_list = nm_item.try_login(sship_list,password_list,syscmd_list)
    key_login_list,key_not_login_list = nm_item.try_key_login(notlogin_list,imoocc_key_file,syscmd_list)

    print "Password Login ...",canlogin_list,notlogin_list
    logger.info("Use password login:%s,%s"%(canlogin_list,notlogin_list))
    print "Key Login ...",key_login_list,key_not_login_list
    logger.info("Use key login:%s,%s"%(key_login_list,key_not_login_list))

    email_message = u"可以ssh 用户密码登录的服务器列表 \n %s \n 可以ssh 用户密钥登录的服务器列表 \n %s \n 无法ssh登录列表 \n %s \n 未知主机 \n %s"%(canlogin_list,\
                    key_login_list,notlogin_list,unkown_list)
    email_sub = u"系统扫描结果"
    receive_addr = s_emails
    email_s =  sendmail(receive_addr,email_sub,email_message)
    email_s.send()

    HostLoginifo.objects.filter(ip__contains=nmap_type).delete()
    crpt_do = prpcrypt()

    if canlogin_list:
        for item in canlogin_list:
            mathine_t = canlogin_list[item][7] if canlogin_list[item][7] else u"未知(需要安装dmidecode工具)"
            crpt_pass = crpt_do.encrypt(canlogin_list[item][1]) if canlogin_list[item][1] else crpt_do.encrypt('')
            HostLoginifo.objects.update_or_create(ip=item,
                                                  ssh_port=str(canlogin_list[item][0]),
                                                  ssh_passwd=crpt_pass,
                                                  ssh_user=canlogin_list[item][2],
                                                  ssh_status=1,
                                                  ssh_type=0,
                                                  system_ver=canlogin_list[item][3],
                                                  hostname=canlogin_list[item][4],
                                                  mac_address=canlogin_list[item][5],
                                                  sn=canlogin_list[item][6],
                                                  mathine_type=mathine_t)
    if key_login_list:
        for item in key_login_list:
            mathine_t = key_login_list[item][9] if key_login_list[item][9] else u"未知(需要安装dmidecode工具)"
            HostLoginifo.objects.update_or_create(ip=item,
                                                  ssh_port=key_login_list[item][0],
                                                  ssh_rsa=key_login_list[item][1],
                                                  ssh_user=key_login_list[item][2],
                                                  rsa_pass=key_login_list[item][3],
                                                  ssh_status=1,
                                                  ssh_type=key_login_list[item][4],
                                                  system_ver=key_login_list[item][5],
                                                  hostname=key_login_list[item][6],
                                                  mac_address=key_login_list[item][7],
                                                  sn=key_login_list[item][8],
                                                  mathine_type=mathine_t)
    return unkown_list,key_not_login_list


class NmapDev(object):
    '''
    扫描类：扫描获取指定网段主机等对象信息
    '''

    def __init__(self,black_list=[]):
        self.black_list = black_list
        self.can_login_lst = {}
        self.not_login_lst = {}
        self.can_key_login_lst = {}
        self.key_not_login_lst = {}

    def nmap_allip(self,nmap_net):
        '''
        扫描网段中存活主机
        '''
        nm = nmap.PortScanner()
        nm.scan(hosts=nmap_net,arguments = ' -n -sP -PE')
        # nm.scan(hosts=nmap_net,arguments = ' -n -PA -PS')
        hostlist = nm.all_hosts()
        return hostlist

    def nmap_sship(self,ports,nmap_net):
        '''
        扫描主机指定ssh端口是否开通ssh端口
        :param ports:
        :param port_list:
        :param unkown_list:
        :param nmap_net:
        :return:
        '''
        ports = ports
        port_list = ports.split(',')
        nm = nmap.PortScanner()  # 创建端口扫描对象
        ssh_info = {}
        unkown_list = []
        # 调用扫描方法，参数指定扫描主机hosts，nmap扫描命令行参数arguments
        nm.scan(hosts=nmap_net, arguments='-n -sP -PE')
        tcp_all_ip = nm.all_hosts()
        host_list = []
        for ip in tcp_all_ip:  # 遍历扫描主机
            if nm[ip]['status']['state'] == "up":
                 host_list.append(ip)
                 for port in port_list:
                     try:
                         print "Scan ip %s ..... Port %s"%(ip,port)
                         logger.info("Scan ip %s ..... Port %s"%(ip,port))
                         tm = telnetlib.Telnet(host=ip,port=port,timeout=4)
                         tm_res = tm.read_until("\n",timeout=4)
                         if tm_res:
                             if re.search("ssh",tm_res.lower()):
                                 print ip,port
                                 if ip not in self.black_list:
                                     ssh_info[ip]=port
                                     connet = "IP:%s Port:%s Server:%s"%(ip,port,tm_res.lower())
                                     logger.info("IP:%s Port:%s Server:%s"%(ip,port,tm_res.lower()))
                                     print "[?]IP:%s Port:%s Server:%s"%(ip,port,tm_res)
                             else:
                                 if ip not in unkown_list and ip not in ssh_info.keys():
                                    unkown_list.append(ip)
                                 logger.info("Telnet not ssh server:%s,%s,%s"%(ip,port,tm_res))
                                 print "Open Res.....",ip,port,tm_res
                         else:
                             if ip not in unkown_list and ip not in ssh_info.keys():
                                unkown_list.append(ip)
                                logger.info("Telnet no data:%s,%s"%(ip,port))
                             print "Open....",ip,port
                     except EOFError as e:
                         if ip not in unkown_list and ip not in ssh_info.keys():
                            unkown_list.append(ip)
                         unkown_list.append(ip)
                         logger.exception("Telnet port EOFError:%s,%s,%s"%(ip,port,e))
                         print "Open....",ip,port
                     except Exception as e:
                         if ip not in unkown_list and ip not in ssh_info.keys():
                            unkown_list.append(ip)
                         logger.exception("Telnet port Exception:%s,%s,%s"%(ip,port,e))
                         print "error...",ip,port,e
        return ssh_info,host_list,list(set(unkown_list))

    def try_login(self,sship_list,password_list,syscmd_list):
        '''
        尝试ssh用户密码登录，获取机器基本信息
        :param sship_list:
        :param password_list:
        :param syscmd_list:
        :return:
        '''
        password_list = password_list
        syscmd_list = syscmd_list
        if isinstance(sship_list, dict):
            ssh_tuple_list = [(ip,port) for ip,port in sship_list.items()]
        elif isinstance(sship_list,list):
            ssh_tuple_list = sship_list
        for ip,port in ssh_tuple_list:
            system_info = ""
            for password in password_list:
                if ip not in self.can_login_lst.keys():
                    login_info = (ip,int(port),'root', password)
                    doobj = J_ssh_do(login_info)
                    res = doobj.pass_do(login_info,syscmd_list)
                    if res["status"] == "success":
                        if self.not_login_lst.has_key(ip):
                            self.not_login_lst.pop(ip)
                        sys_hostname = res["hostname"]
                        sys_mac = mac_trans(res["cat /sys/class/net/[^vtlsb]*/address||esxcfg-vmknic -l|awk '{print $8}'|grep ':'"])
                        sys_sn = sn_trans(res["dmidecode -s system-serial-number"])
                        system_info = getsysversion([res["cat /etc/issue"],res["cat /etc/redhat-release"]])
                        machine_type = machine_type_trans(res["dmidecode -s system-manufacturer"] + res["dmidecode -s system-product-name"])
                        print "ssh login and exec command:%s",res
                        logger.info("ssh login and exec command:%s",res)
                        self.can_login_lst[ip] = (port,password,'root',system_info,sys_hostname,sys_mac,sys_sn,machine_type)
                    elif res["status"] == "failed" and re.search(r"reading SSH protocol banner",res["res"]):
                        # print "res res..........................",res['res']
                        print "IP:%s Connection closed by remote host,Sleep 60 (s).................. "%ip,res
                        time.sleep(60)
                    else:
                        if ip not in self.not_login_lst.keys() and ip not in self.can_login_lst.keys():
                            self.not_login_lst[ip] = port
                        # print ip,port,password,traceback.print_exc()
        return self.can_login_lst,self.not_login_lst

    def try_docker_login(self,sship_list,password_list,syscmd_list):
        '''
        尝试Docker ssh用户密码登录，获取机器基本信息
        :param sship_list:
        :param password_list:
        :param syscmd_list:
        :return:
        '''
        password_list = password_list
        syscmd_list = syscmd_list
        if isinstance(sship_list, dict):
            ssh_tuple_list = [(ip,port) for ip,port in sship_list.items()]
        elif isinstance(sship_list,list):
            ssh_tuple_list = sship_list
        for ip,port in ssh_tuple_list:
            system_info = ""
            for password in password_list:
                if port not in self.can_login_lst.keys():
                    login_info = (ip,int(port),'root', password)
                    doobj = J_ssh_do(login_info)
                    res = doobj.pass_do(login_info,syscmd_list)
                    if res["status"] == "success":
                        if self.not_login_lst.has_key(port):
                            self.not_login_lst.pop(port)
                        sys_hostname = res["hostname"]
                        sys_mac = mac_trans(res["cat /sys/class/net/[^vtlsb]*/address||esxcfg-vmknic -l|awk '{print $8}'|grep ':'"])
                        sys_sn = sn_trans(res["dmidecode -s system-serial-number"])
                        system_info = getsysversion([res["cat /etc/issue"],res["cat /etc/redhat-release"]])
                        machine_type = machine_type_trans(res["dmidecode -s system-manufacturer"] + res["dmidecode -s system-product-name"])
                        print "ssh login and exec command:%s",res
                        logger.info("ssh login and exec command:%s",res)
                        self.can_login_lst[port] = (ip,password,'root',system_info,sys_hostname,sys_mac,sys_sn,machine_type)
                    elif res["status"] == "failed" and re.search(r"reading SSH protocol banner",res["res"]):
                        # print "res res..........................",res['res']
                        print "IP:%s Connection closed by remote host,Sleep 60 (s).................. "%port,res
                        time.sleep(60)
                    else:
                        if port not in self.not_login_lst.keys() and port not in self.can_login_lst.keys():
                            self.not_login_lst[port] = ip
                        # print ip,port,password,traceback.print_exc()
        return self.can_login_lst,self.not_login_lst


    def try_key_login(self,sship_list,allkeyfile,syscmd_list):
        '''
        尝试ssh秘钥登录，获取机器基本信息
        :param sship_list:
        :param allkeyfile:
        :param syscmd_list:
        :return:
        '''

        # import traceback
        for ip,port in sship_list.items():
            print "try key login....",ip,port
            logger.info("Try ssh key login : %s,%s"%(ip,port))
            keyfile = allkeyfile[0]
            if ip not in self.can_key_login_lst.keys():
                logger.info("Try ssh idrsa key : %s,%s,%s"%(ip,port,keyfile))
                print 'try idrsakey....',ip,port,keyfile
                login_info = (ip,int(port),'root',keyfile)
                doobj = J_ssh_do(login_info)
                res = doobj.rsa_do(login_info,syscmd_list)
                if res["status"] == "success":
                    sys_hostname = res["hostname"]
                    system_info = getsysversion([res["cat /etc/issue"],res["cat /etc/redhat-release"]])
                    sys_mac = mac_trans(res["cat /sys/class/net/[^vtlsb]*/address||esxcfg-vmknic -l|awk '{print $8}'|grep ':'"])
                    sys_sn = sn_trans(res["dmidecode -s system-serial-number"])
                    machine_type = machine_type_trans(res["dmidecode -s system-manufacturer"] + res["dmidecode -s system-product-name"])
                    self.can_key_login_lst[ip] = (port,keyfile,"root","",1,system_info,sys_hostname,sys_mac,sys_sn,machine_type)
                if res["status"] == "failed":
                        keyfile = allkeyfile[1]
                        logger.info("try iddsa login...%s,%s,%s"%(ip,port,keyfile))
                        print "try iddsa login...",ip,port,keyfile
                        login_info = (ip,port,'root', keyfile)
                        doobj = J_ssh_do(login_info)
                        res = doobj.dsa_do(login_info,syscmd_list)
                        if res["status"] == "success":
                            sys_hostname = res["hostname"]
                            system_info = getsysversion([res["cat /etc/issue"],res["cat /etc/redhat-release"]])
                            sys_mac = mac_trans(res["cat /sys/class/net/[^vtlsb]*/address||esxcfg-vmknic -l|awk '{print $8}'|grep ':'"])
                            sys_sn = sn_trans(res["dmidecode -s system-serial-number"])
                            machine_type = machine_type_trans(res["dmidecode -s system-manufacturer"] + res["dmidecode -s system-product-name"])

                            if self.key_not_login_lst.has_key(ip):self.key_not_login_lst.pop(ip)
                            self.can_key_login_lst[ip] = (port,keyfile,"root","",2,system_info,sys_hostname,sys_mac,sys_sn,machine_type)
                        else:
                            keyfile = allkeyfile[2]
                            logger.info("try Non-root idrsa login:%s,%s"%(ip,port))
                            print "try Non-root idrsa login...",ip,port
                            password = '0koooAdmin'
                            login_info = (ip,port,'imoocc', keyfile,password)
                            doobj = J_ssh_do(login_info)
                            res = doobj.imoocc_rsa_do(login_info,syscmd_list)
                            if res["status"] == "success":
                                sys_hostname = res["hostname"]
                                sys_mac = mac_trans(res["cat /sys/class/net/[^vtlsb]*/address||esxcfg-vmknic -l|awk '{print $8}'|grep ':'"])
                                system_info = getsysversion([res["cat /etc/issue"],res["cat /etc/redhat-release"]])
                                sys_sn = sn_trans(res["dmidecode -s system-serial-number"])
                                machine_type = machine_type_trans(res["dmidecode -s system-manufacturer"] + res["dmidecode -s system-product-name"])
                                if self.key_not_login_lst.has_key(ip):self.key_not_login_lst.pop(ip)
                                self.can_key_login_lst[ip] = (port,keyfile,"root","",3,system_info,sys_hostname,sys_mac,sys_sn,machine_type)
                            else:
                                if ip not in self.key_not_login_lst.keys() and ip not in self.can_key_login_lst.keys():
                                    self.key_not_login_lst[ip] = (port,keyfile)
        return  self.can_key_login_lst,self.key_not_login_lst


class NmapNet:
    def __init__(self,sysname_oid="",sn_oid="",community=""):
        self.community = community
        self.sysname_oid = sysname_oid
        self.sn_oids = sn_oid

    def sn_query(self,ip,sn_oid):
        try:
            cg = cmdgen.CommandGenerator()
            errorIndication,errorStatus,errorIndex,varBinds = cg.getCmd(
                cmdgen.CommunityData('server',self.community,1),
                cmdgen.UdpTransportTarget((ip,161)),
                '%s'%sn_oid
            )
            result = str(varBinds[0][1]) if varBinds[0][1] else ""
            logger.info("try nmap net device:%s"%result)

        except Exception as e:
            # import traceback
            # print traceback.print_exc()
            logger.exception("try nmap net device exception:%s"%e)
            result = None
        return result

    def sysname_query(self,ip):
        try:
            cg = cmdgen.CommandGenerator()
            errorIndication,errorStatus,errorIndex,varBinds = cg.getCmd(
                cmdgen.CommunityData('server',self.community,1),
                cmdgen.UdpTransportTarget((ip,161)),
                '%s'%self.sysname_oid
            )
            result = str(varBinds[0][1]) if varBinds[0][1] else ""
            logger.info("try nmap net device:%s"%result)

        except Exception as e:
            # import traceback
            # print traceback.print_exc()
            logger.exception("try nmap net device exception:%s"%e)
            result = None
        return result


    def query(self,ip):
        '''
        查询交换机的snmp相关信息
        :return:'
        '''
        result = []
        result.append(self.sysname_query(ip))
        for sn_oid in self.sn_oids:
            res_sn = self.sn_query(ip,sn_oid)
            if res_sn:
                break
        result.append(res_sn)
        return result

class NmapDocker(NmapDev):

    def __init__(self,d_cmds,pass_lst,ip_key_dic):
        NmapDev.__init__(self)
        # super(NmapDocker,self).__init__()
        self.docker_cmd_list = ["docker ps |awk -F '->' '{print $1}'|grep -v 'CONTAINER'|awk 'BEGIN{FS~/s+/;}{print $NF\" \"$1\" \"$2;}'|sed s/0.0.0.0://"]
        # self.docker_cmd_list = ["docker ps |awk -F '->' '{print $1}'|grep -v 'CONTAINER'|awk -F ':' '{print $NF','$1}'"]
        # self.docker_cmd_list = ["docker ps |awk -F '->' '{print $1}'|grep -v 'CONTAINER'|awk -F ':' '{print $NF}'|grep '^[0-9]'"]
        self.docker_cmd = d_cmds
        self.password_list = pass_lst
        self.p_docker_relate = {}
        self.ip_key_dic = ip_key_dic


    def do_nmap(self,host_list):
        ip_items = HostLoginifo.objects.filter(ip__in=host_list)
        ns = prpcrypt()
        for ip_item in ip_items:
            docker_dct = {}
            tmp_sship_list = []
            doobj = J_ssh_do([ip_item.ip,ip_item.ssh_port,ip_item.ssh_user])
            if ip_item.ssh_type==0:
                ssh_passwd = ns.decrypt(ip_item.ssh_passwd)
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ssh_passwd)
                res = doobj.pass_do(login_info,self.docker_cmd_list)
            if ip_item.ssh_type==1:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                res = doobj.rsa_do(login_info,self.docker_cmd_list)
            if ip_item.ssh_type==2:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                res = doobj.dsa_do(login_info,self.docker_cmd_list)
            if ip_item.ssh_type==3:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa,ip_item.rsa_pass)
                res = doobj.imoocc_rsa_do(login_info,self.docker_cmd_list)

            # port_list = res["docker ps |awk -F '->' '{print $1}'|grep -v 'CONTAINER'|awk -F ':' '{print $NF}'|grep '^[0-9]'"].split("\n")
            port_list = res["docker ps |awk -F '->' '{print $1}'|grep -v 'CONTAINER'|awk 'BEGIN{FS~/s+/;}{print $NF\" \"$1\" \"$2;}'|sed s/0.0.0.0://"].split("\n")
            for d_item in port_list:
                if d_item:
                    print "...............d_item",d_item
                    d_port,d_id,d_dn = re.split('\s+',d_item)[:3]
                    d_cid = d_id + d_dn
                    docker_dct[d_port] = sn_trans(d_cid)

            sship_list = [(ip_item.ip,port) for port in docker_dct.keys() if port]

            nr = prpcrypt()
            canlogin_list,notlogin_list = self.try_docker_login(sship_list,self.password_list,self.docker_cmd)
            for ip,port in sship_list:
                # sship_obj = {}
                # sship_obj[ip] = port
                if canlogin_list.has_key(port):
                    id = ConnectionInfo.objects.all().count() + 1
                    item_val = canlogin_list[port]
                    ssh_passwd = nr.encrypt(item_val[1])
                    ConnectionInfo.objects.create(id = id,ssh_username=item_val[2],ssh_userpasswd=ssh_passwd,ssh_hostip=ip,ssh_host_port=port,
                                      ssh_status=1,ssh_type=4,sn_key=docker_dct[port])
                    py_id = PhysicalServerInfo.objects.get(conn_phy__sn_key=self.ip_key_dic[ip]).id
                    VirtualServerInfo.objects.create(server_ip=ip,server_type="Docker Contianer",system_ver=item_val[3],sys_hostname=item_val[4],mac=item_val[5],sn=docker_dct[port],vir_phy_id=py_id,conn_vir_id=id)

                if notlogin_list.has_key(port):
                    item_val = notlogin_list[ip]
                    ConnectionInfo.objects.create(id = id,ssh_username=item_val[2],ssh_hostip=ip,ssh_host_port=item_val[0],
                                      ssh_status=0,ssh_type=5,sn_key=docker_dct[port])
                    py_id = PhysicalServerInfo.objects.get(conn_phy__sn_key=self.ip_key_dic[ip]).id
                    VirtualServerInfo.objects.create(server_ip=ip,server_type="Docker Contianer",vir_phy_id=py_id,conn_vir_id=id)
class NmapKVM():
    def __init__(self,ip_key_dic):
        self.p_kvm_cmds = ['cat /sys/class/net/vnet*/address']
        self.ip_key_dic = ip_key_dic

    def do_nmap(self,p_kvm_list):
        for item in p_kvm_list:
            ip_items = HostLoginifo.objects.filter(ip=item)
            docker_dct = {}
            nr = prpcrypt()
            for ip_item in ip_items:
                doobj = J_ssh_do([ip_item.ip,ip_item.ssh_port,ip_item.ssh_user])
                if ip_item.ssh_type==0:
                    ssh_passwd = nr.decrypt(ip_item.ssh_passwd)
                    login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ssh_passwd)
                    res = doobj.pass_do(login_info,self.p_kvm_cmds)
                if ip_item.ssh_type==1:
                    login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                    res = doobj.rsa_do(login_info,self.p_kvm_cmds)
                if ip_item.ssh_type==2:
                    login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                    res = doobj.dsa_do(login_info,self.p_kvm_cmds)
                if ip_item.ssh_type==3:
                    login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa,ip_item.rsa_pass)
                    res = doobj.imoocc_rsa_do(login_info,self.p_kvm_cmds)
                kvm_mac_list = res[self.p_kvm_cmds[0]].split('\n')
                for kvm_item in kvm_mac_list:
                    if kvm_item:
                        kvm_mac_str = mac_trans(kvm_item)[-10:]
                        py_id = PhysicalServerInfo.objects.get(conn_phy__sn_key=self.ip_key_dic[item]).id
                        v_obj = VirtualServerInfo.objects.filter(mac__contains=kvm_mac_str)
                        if v_obj:
                            v_obj.update(vir_phy=py_id,server_type="KVM")
                        else:
                            p_ob = PhysicalServerInfo.objects.filter(mac__contains=kvm_mac_str)
                            if p_ob and len(p_ob) < 2:
                                p_ob.update(vir_phy=py_id,server_type="KVM")

class NmapVMX():
    def __init__(self,vmware_p_list,ip_key_dic):
        self.vmware_p_list = vmware_p_list
        self.ip_key_dic = ip_key_dic

    def dosnmp(self):
        nr = prpcrypt()
        for vm_item in self.vmware_p_list:
            vm_sn = self.ip_key_dic[vm_item]
            p_item = ConnectionInfo.objects.filter(sn_key=vm_sn)
            try:
                vmip = p_item[0].ssh_hostip.split(',')[0]
                ssh_passwd = nr.decrypt(p_item[0].ssh_userpasswd)
                ne = SnmpESXI(host=vmip,user=p_item[0].ssh_username,passwd=ssh_passwd)
                res  = ne.dosnmp()
                py_id = PhysicalServerInfo.objects.get(conn_phy__sn_key=vm_sn).id
                for v_item in res:
                    v_uuid = v_item['uuid']
                    v_vmname = v_item['name']
                    v_obj = VirtualServerInfo.objects.filter(sn__contains=v_uuid)
                    if v_obj:
                        v_obj.update(vir_phy=py_id,server_type=u"VMX:%s"%(v_vmname))
                    else:
                        logger.error("Error:no vmx matched! %s %s"%(v_uuid,v_vmname))
                        print "Error:no vmx matched! %s %s"%(v_uuid,v_vmname)
            except Exception as e:
                print "Vmware host sdk connect failed!%s"%(p_item[0].ssh_hostip)
                logger.error("Error:Vmware host sdk connect failed!%s"%(p_item[0].ssh_hostip))

def NetDevLogin(dev_ips={},backup_sw="False",back_server=""):
    crpt_do = prpcrypt()
    for ip,login_info in dev_ips.items():
        if backup_sw == "True":
            jn = J_net_do(ip,login_info)
            res = jn.cisco_backup(back_server=back_server,sw_backup=True)
        else:
            jn = J_net_do(ip,login_info)
            res = jn.cisco_login()

        if res["status"] == "success" and res["level"] == 2:
            dev_obj = NetWorkInfo.objects.filter(host_ip = ip)
            if dev_obj:
                dev_sn_key = dev_obj[0].sn
                dev_id = dev_obj[0].id

                con_obj = NetConnectionInfo.objects.filter(sn_key=dev_sn_key)
                con_user,con_passwd,con_en_passwd = res["login_info"]
                crpt_pass = crpt_do.encrypt(con_passwd) if con_passwd else crpt_do.encrypt('')
                en_crpt_pass = crpt_do.encrypt(con_en_passwd) if con_passwd else crpt_do.encrypt('')

                if not con_obj:
                    NetConnectionInfo.objects.create(tel_username=con_user,tel_userpasswd=crpt_pass,tel_enpasswd=en_crpt_pass,
                    tel_host_port='21',tel_hostip=ip,sn_key=dev_sn_key,dev_info_id=dev_id,tel_status=1,tel_type=int(res["level"]))