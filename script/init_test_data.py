#!/usr/bin/env python
# -*-coding:utf-8-*-
import os,sys

PROJECT_ROOT = os.path.dirname(os.path.realpath(os.path.dirname(__file__)))
sys.path.insert(0,PROJECT_ROOT)
os.environ["DJANGO_SETTINGS_MODULE"] = 'admin.settings.local_cj'
import django
import random,string
django.setup()

from apps.detail.models import  PhysicalServerInfo,ConnectionInfo,OtherMachineInfo,StatisticsRecord,VirtualServerInfo
from apps.operations.models import  MachineOperationsInfo
from scanhosts.util.nmap_all_server import NetDevLogin

import random,string
from scanhosts.lib.utils import prpcrypt


map_port = {"22":"22222","9922":"2222","20022":"222"}
map_host = {'192.168':"10.16",'172.16':"10.17"}
ohostname = ['nginx','db','app','apache','api','3g','store','cache','redis']

def new_uniq_hostname(id_num):
    #生成新主机名
    new_hostname = ohostname[random.randint(0,len(ohostname))-1] + str(id_num)
    print "hostname.......",new_hostname
    return new_hostname


def new_host_type(old_type,new_hostname):
    #生成新主机类型
    new_type = old_type.split(":")[0]+new_hostname
    return new_type

def new_host_ip(old_ip):
    #生成新的IP列表
    ip_list = old_ip.split(",")
    newips = ""
    for ip_item in ip_list:
        (ip1,ip2,ip3,ip4) = ip_item.split(".")
        newip = map_host[str(ip1)+"."+str(ip2)] + "." + str(ip3) + "." + str(ip4)
        if newips:
            newips = newips + "," + newip
        else:
            newips = newip
    return newips

def gen_new_passwd():
    # 生成新用户名密码
    crpt_do = prpcrypt()
    crpt_new = crpt_do.encrypt(str(random.randint(0,600000)))
    return crpt_new

def gen_new_str(old_str):
    # 替换敏感信息
    init_new_str = old_str[:-6] + str(random.randint(111111,999999))
    new_str =init_new_str.replace(".okooo.","").replace("okooo","")

    return new_str

def get_new_type(old_type,hostname):
    return  old_type.split(":")[0]+":"+hostname

def replace_okooo_info(old_info):
    # 替换信息
    newinfo = old_info.replace(".okooo.","").replace("okooo","")
    return newinfo

def gen_random_mac():
    # 生成随机字符串
    src_digits = string.digits              #string_数字
    src_uppercase = string.ascii_uppercase  #string_大写字母
    src_lowercase = string.ascii_lowercase  #string_小写字母
    #随机生成数字、大写字母、小写字母的组成个数（可根据实际需要进行更改）
    digits_num = random.randint(1,6)
    uppercase_num = random.randint(1,8-digits_num-1)
    lowercase_num = 8 - (digits_num + uppercase_num)
    #生成字符串
    password = random.sample(src_digits,digits_num) + random.sample(src_uppercase,uppercase_num)

    #打乱字符串
    random.shuffle(password)

    #列表转字符串
    new_password = ''.join(password)
    print "new_passwd ..................",new_password
    return new_password


def main():
     for item in ConnectionInfo.objects.all():
         new_passwd = gen_new_passwd()
         new_hostip = new_host_ip(item.ssh_hostip)
         new_hostname = new_uniq_hostname(item.id)
         new_rsa_pass = new_passwd if item.rsa_pass else item.rsa_pass
         new_sn_key = gen_new_str(item.sn_key)
         itemid=item.id

         item.ssh_userpasswd=new_passwd
         item.ssh_hostip=new_hostip
         item.rsa_pass=new_rsa_pass
         item.save()

         MachineOperationsInfo.objects.filter(sn_key=item.sn_key).update(sn_key=new_sn_key)

         py_items = PhysicalServerInfo.objects.filter(conn_phy_id=itemid)


         for pyitem in py_items:
             pyitem.server_ip=new_hostip
             pyitem.sys_hostname=new_hostname
             pyitem.sn = new_sn_key
             pyitem.save()

         vir_items = VirtualServerInfo.objects.filter(conn_vir_id=itemid)
         for viritem in vir_items:
             viritem.server_ip=new_hostip
             viritem.sys_hostname=new_hostname
             viritem.sn=new_sn_key
             new_type = get_new_type(viritem.server_type,new_hostname)
             viritem.server_type=new_type
             viritem.save()





if __name__ == "__main__":
    main()



