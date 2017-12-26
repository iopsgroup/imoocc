#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# Author:Jeson
# Email:jeson@imoocc.com

import datetime
import os
import re

import yaml

PROJECT_ROOT = os.path.realpath(os.path.dirname(__file__))
# import sys
os.environ["DJANGO_SETTINGS_MODULE"] = 'admin.settings.local_cj'
import django
import time
django.setup()
from scanhosts.models import HostLoginifo
from scanhosts.util.nmap_all_server import NmapNet
from scanhosts.util.nmap_all_server import NmapDocker
from scanhosts.util.nmap_all_server import NmapKVM
from scanhosts.util.nmap_all_server import NmapVMX
from scanhosts.util.nmap_all_server import snmp_begin
from scanhosts.util.j_filter import FilterRules
from scanhosts.util.get_pv_relation import GetHostType
from apps.detail.models import  PhysicalServerInfo,ConnectionInfo,OtherMachineInfo,StatisticsRecord
from apps.operations.models import  MachineOperationsInfo

from scanhosts.util.nmap_all_server import NetDevLogin
from admin.settings.local_cj import BASE_DIR
import logging
logger = logging.getLogger("django")
from apps.detail.utils.machines import Machines



# def net_begin():
#     '''
#     开始执行网络扫描
#     :return:
#     '''
#     nm = NmapNet(oid='1.3.6.1.2.1.1.5.0',Version=2)
#     nm_res = nm.query()
#     print "...................",nm_res



def main():
    '''
    读取扫描所需配置文件
    :return:
    '''
    s_conf = yaml.load(file('conf/scanhosts.yaml'))
    s_nets = s_conf['hostsinfo']['nets']
    s_ports = s_conf['hostsinfo']['ports']
    s_pass = s_conf['hostsinfo']['ssh_pass']
    s_cmds = s_conf['hostsinfo']['syscmd_list']
    s_keys = s_conf['hostsinfo']['ssh_key_file']
    s_blacks = s_conf['hostsinfo']['black_list']
    s_emails = s_conf['hostsinfo']['email_list']

    n_sysname_oid = s_conf['netinfo']['sysname_oid']
    n_sn_oid = s_conf['netinfo']['sn_oids']
    n_commu = s_conf['netinfo']['community']
    n_login_sw = s_conf['netinfo']['login_enable']
    n_backup_sw = s_conf['netinfo']['backup_enable']
    n_backup_sever = s_conf['netinfo']['tfp_server']

    d_pass = s_conf['dockerinfo']['ssh_pass']
    starttime = datetime.datetime.now()
    # '''
    # 扫描主机信息
    # '''
    # for nmap_type in s_nets:
    #     unkown_list,key_not_login_list = snmp_begin(nmap_type,s_ports,s_pass,s_keys,s_cmds,s_blacks,s_emails)
    #
    # '''
    # 扫描网络信息
    # '''
    # nm = NmapNet(n_sysname_oid,n_sn_oid,n_commu)
    # if key_not_login_list:
    #     for item in key_not_login_list:
    #         is_net = nm.query(item)
    #         if is_net[0] or is_net[1]:
    #             HostLoginifo.objects.update_or_create(ip=item,hostname=is_net[0],sn=is_net[1],mathine_type="Network device")
    #         else:
    #             HostLoginifo.objects.update_or_create(ip=item,ssh_port=key_not_login_list[item][0],ssh_status=0)
    #             other_sn = item.replace('.','')
    #             ob = OtherMachineInfo.objects.filter(sn_key=other_sn)
    #             if not ob:
    #                 print ".........................OtherMachineInfo",item,other_sn
    #                 OtherMachineInfo.objects.create(ip=item,sn_key=other_sn,reson_str=u"SSH端口存活，无法登录",oth_cab_id=1)
    #
    #
    # if unkown_list:
    #     for item in unkown_list:
    #         is_net = nm.query(item)
    #         if is_net[0] or is_net[1]:
    #             HostLoginifo.objects.update_or_create(ip=item,hostname=is_net,mathine_type="Network device")
    #         else:
    #             HostLoginifo.objects.update_or_create(ip=item,ssh_status=0)
    #             other_sn = item.replace('.','')
    #             ob = OtherMachineInfo.objects.filter(sn_key=other_sn)
    #             if not ob:
    #                 OtherMachineInfo.objects.create(ip=item,sn_key=other_sn,reson_str=u"IP存活，非Linux服务器",oth_cab_id=1)

    # '''
    # 网络设备备份或者登录功能
    # '''
    # net_login_dct = {}
    # with open("%s/conf/net_dev.pass"%BASE_DIR,'r') as f:
    #     for item in f.readlines():
    #         ip,username,passwd,en_passwd = re.split("\s+",item)[:4]
    #         net_login_dct[ip] = (username,passwd,en_passwd)
    #     if n_login_sw == "True":
    #         res = NetDevLogin(dev_ips=net_login_dct,backup_sw=n_backup_sw,back_server=n_backup_sever)




    '''
    规则：主机信息，去重、生成关系字典
    '''
    ft = FilterRules()
    key_ip_dic = ft.run()

    '''
    梳理虚拟服务器主机于服务器信息
    '''
    pv = GetHostType()
    p_relate_dic = pv.get_host_type(key_ip_dic)

    '''
    更新宿主机类型中表对应关系
    '''
    ip_key_dic = {v:k for k,v in key_ip_dic.items()}
    docker_p_list = p_relate_dic["docker-containerd"]
    kvm_p_list = p_relate_dic["qemu-system-x86_64"]
    vmware_p_list = p_relate_dic["vmx"]
    for item in docker_p_list:
        PhysicalServerInfo.objects.filter(conn_phy__sn_key=ip_key_dic[item]).update(vir_type="1")
    for item in kvm_p_list:
        PhysicalServerInfo.objects.filter(conn_phy__sn_key=ip_key_dic[item]).update(vir_type="0")
    for item in vmware_p_list:
        PhysicalServerInfo.objects.filter(conn_phy__sn_key=ip_key_dic[item]).update(vir_type="2")


    '''
    扫描docker的宿主机和虚拟服务的关系
    '''
    ds = NmapDocker(s_cmds,d_pass,ip_key_dic)
    ds.do_nmap(docker_p_list)
    #
    # '''
    # 扫描KVM的宿主机和虚拟服务的关系
    # '''
    ks = NmapKVM(ip_key_dic)
    ks.do_nmap(kvm_p_list)

    '''
    扫描ESXI虚拟机配置
    '''
    ne = NmapVMX(vmware_p_list,ip_key_dic)
    ne.dosnmp()
    #
    # '''
    # 更新状态表，用户信息表
    # '''
    # c_sn_lst = [item.sn_key for item in ConnectionInfo.objects.all()]
    # o_sn_lst = [item.sn_key for item in OtherMachineInfo.objects.all()]
    # old_sn_list = [item.sn_key for item in MachineOperationsInfo.objects.all()]
    # new_sn_lst = c_sn_lst + o_sn_lst
    # diff_sn_lst = set(new_sn_lst + old_sn_list)
    #
    # for item in diff_sn_lst:
    #     try:
    #         nsin = MachineOperationsInfo.objects.filter(sn_key=item)
    #         if not nsin:
    #             MachineOperationsInfo.objects.create(sn_key=item)
    #     except Exception as e:
    #         print "Error:SN:%s not insert into database,reason is:%s"%(item,e)
    #         logger.error("Error:SN:%s not insert into database,reason is:%s"%(item,e))
    #
    # '''
    # 统计总数
    # '''
    # info_dic = Machines().get_all_count()
    # StatisticsRecord.objects.create(all_count=info_dic['all_c'],pyh_count=info_dic['pyh_c'],net_count=info_dic['net_c'],
    #                                 other_count=info_dic['other_c'],vmx_count=info_dic['vmx_c'],kvm_count=info_dic['kvm_c'],docker_count=info_dic['docker_c'])
    #


    endtime = datetime.datetime.now()
    totaltime = (endtime - starttime).seconds

    logger.info("{Finish:Use time %s s}"%totaltime)
    print "{Finish:Use time %s s}"%totaltime

if __name__ == "__main__":
    main()