#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# Author:Jeson
# mail:iaskjob@163.com
# Created Time: 四  6/16 11:13:39 2016
# pip install paramiko python-nmap
#========================================================================
import logging

from detail.models import ConnectionInfo,VirtualServerInfo,NetWorkInfo,PhysicalServerInfo
from scanhosts.models import HostLoginifo

logger = logging.getLogger("django")
import re

class FilterRules():
    '''
    一系列的筛选过滤规则
    '''
    def __init__(self):
        self.key_dic_map = {}
        self.key_sn_relate = {}
        self.key_ip_relate = {}

    def run(self):
        self.all_lst = [item for item in HostLoginifo.objects.all()]

        self.after_all_key = self.init_uniq_key(self.all_lst)
        if self.insert_db_conn_info():
            self.filter_type()
        return self.key_ip_relate

    def return_key_mac(self,mac_address):
        '''
        返回一个可以用作唯一标示的mac地址字符串
        :param mac_address:
        :return:
        '''
        key_mac = mac_address.split("_")[0] if mac_address else ""
        return self.return_true_string(key_mac)

    def return_true_string(self,data):
        '''
        对字符串去空格、去除回车换行
        :param data:
        :return:
        '''
        n_data = data.strip().replace(' ', '').replace('\n', '').replace('\t', '').replace('\r', '').strip() if data else ""
        return n_data

    def init_uniq_key(self,key_obj_list):
        for key_obj in key_obj_list:
            mac_addr = self.return_key_mac(key_obj.mac_address)
            sn_key = self.return_true_string(key_obj.sn)
            if sn_key and sn_key != u'' and sn_key != 'NotSpecified':
                if sn_key not in self.key_dic_map.keys():
                    self.key_dic_map[sn_key] = [key_obj.ip,key_obj.ssh_port,key_obj.ssh_user,key_obj.ssh_passwd,key_obj.ssh_rsa,key_obj.rsa_pass,key_obj.system_ver,
                    key_obj.hostname,key_obj.ssh_status,key_obj.ssh_type,key_obj.mac_address,sn_key,key_obj.mathine_type]
                else:
                    self.key_dic_map[sn_key][0] = self.key_dic_map[sn_key][0] + "," + key_obj.ip
            elif mac_addr:
                if mac_addr not in self.key_dic_map.keys():
                    self.key_dic_map[mac_addr] = [key_obj.ip,key_obj.ssh_port,key_obj.ssh_user,key_obj.ssh_passwd,key_obj.ssh_rsa,key_obj.rsa_pass,key_obj.system_ver,
                key_obj.hostname,key_obj.ssh_status,key_obj.ssh_type,key_obj.mac_address,key_obj.sn,key_obj.mathine_type]
                else:
                    self.key_dic_map[mac_addr][0] = self.key_dic_map[mac_addr][0] + "," + key_obj.ip
            else:
                print u"error:no sn and no mac:%s"%key_obj.id
                logger.error("error:no sn and no mac,id is :%s"%key_obj.id)

    def insert_db_conn_info(self):
        '''
        向数据库插入连接信息
        :return:
        '''
        ConnectionInfo.objects.all().delete()
        id = 1
        for item,item_val in self.key_dic_map.items():
            ConnectionInfo.objects.create(id = id,ssh_username=item_val[2],ssh_userpasswd=item_val[3],ssh_hostip=item_val[0],ssh_host_port=item_val[1],ssh_rsa=item_val[4],rsa_pass=item_val[5],
                                      ssh_status=item_val[8],ssh_type=item_val[9],sn_key=item)
            self.key_sn_relate[item] = id
            id = id + 1
        logger.info("Inset data into table ConnectionInfo sucess!")
        return True

    def filter_type(self):
        VirtualServerInfo.objects.all().delete()
        NetWorkInfo.objects.all().delete()
        PhysicalServerInfo.objects.all().delete()
        for item,item_val in self.key_dic_map.items():
            mac_addr = self.return_key_mac(item_val[-3])
            sn_key = self.return_true_string(item_val[-2])
            if re.search("KVM",item_val[-1]) or re.search("QEMU",item_val[-1]):
                VirtualServerInfo.objects.create(server_ip=item_val[0],server_type=item_val[-1],system_ver=item_val[6],sys_hostname=item_val[7],mac=item_val[-3],sn=item_val[-2],vir_phy_id=1,conn_vir_id=int(self.key_sn_relate[mac_addr]))
            elif re.search("VMware",item_val[-1]):
                mac_addr = self.return_key_mac(item_val[-3])
                VirtualServerInfo.objects.create(server_ip=item_val[0],server_type=item_val[-1],system_ver=item_val[6],sys_hostname=item_val[7],mac=item_val[-3],sn=item_val[-2],vir_phy_id=1,conn_vir_id=int(self.key_sn_relate[sn_key]))
            elif re.search("Network",item_val[-1]):
                NetWorkInfo.objects.create(host_ip=item_val[0],host_name=item_val[7],net_cab_id=1,sn=item_val[-2])
                # print "Network...........",item_val[-1]
            else:
                self.key_ip_relate[item] = item_val[0].split(',')[0]
                if sn_key and sn_key != 'NotSpecified':
                    PhysicalServerInfo.objects.create(server_ip=item_val[0],machine_brand=item_val[-1],system_ver=item_val[6],sys_hostname=item_val[7],mac=item_val[-3],sn=item_val[-2],ser_cabin_id=1,conn_phy_id=int(self.key_sn_relate[sn_key]))
                else:
                    PhysicalServerInfo.objects.create(server_ip=item_val[0],machine_brand=item_val[-1],system_ver=item_val[6],sys_hostname=item_val[7],mac=item_val[-3],sn=item_val[-2],ser_cabin_id=1,conn_phy_id=int(self.key_sn_relate[mac_addr]))
                # print "Machine............",item_val[-1]
        return True