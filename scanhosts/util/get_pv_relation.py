#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# Author:Jeson
# mail:iaskjob@163.com
# Created Time: 四  6/16 11:13:39 2016
# pip install paramiko python-nmap
#========================================================================
from detail.models import  PhysicalServerInfo
from scanhosts.lib.J_do import J_ssh_do
from scanhosts.models import HostLoginifo


class GetHostType():
    def __init__(self):
        self.p_relate_dic = {}
        self.p_docker_lst = []
        self.p_kvm_lst = []
        self.p_vmx_lst = []

    def get_host_type(self,pv_dict):
        h_type = {
                  'qemu-system-x86_64' : '0',
                  'docker-containerd' : '1',
                  'vmx' : '2',
                  }

        pv = J_ssh_do()
        for sn_key,ip in pv_dict.items():
            for item_name in h_type:
                if item_name == 'qemu-system-x86_64':
                    v_cmd = ["ps -ef|grep %s' '|grep -v grep"%item_name]
                    res = pv.run(ip,v_cmd)
                    if res['status'] == "success" and res[v_cmd[0]]:
                        HostLoginifo.objects.filter(ip=ip).update(host_type=h_type[item_name])
                        self.p_kvm_lst.append(ip)
                elif item_name == 'docker-containerd':
                    v_cmd = ["ps -ef|grep %s' '|grep -v grep"%item_name]
                    res = pv.run(ip,v_cmd)
                    if res['status'] == "success" and res[v_cmd[0]]:
                        HostLoginifo.objects.filter(ip=ip).update(host_type=h_type[item_name])
                        self.p_docker_lst.append(ip)
                elif item_name == 'vmx':
                    d_cmd = ["ps|grep %s|grep -v grep"%item_name]
                    res = pv.run(ip,d_cmd)
                    if res['status'] == "success" and res[d_cmd[0]]:
                        HostLoginifo.objects.filter(ip=ip).update(host_type=h_type[item_name])
                        #Esx宿主机无法通过dmicode命令获取
                        PhysicalServerInfo.objects.filter(server_ip__contains=ip).update(machine_brand=u"ESXI宿主机(未知型号)")
                        self.p_vmx_lst.append(ip)
        self.p_relate_dic['qemu-system-x86_64'] = self.p_kvm_lst
        self.p_relate_dic['docker-containerd'] = self.p_docker_lst
        self.p_relate_dic['vmx'] = self.p_vmx_lst
        return self.p_relate_dic