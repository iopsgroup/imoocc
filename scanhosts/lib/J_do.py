#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# File Name: nmap_all_server.py
# Program function:自动探测所有服务器，发现端口扫描、探测。
# Author:Jeson
# mail:iaskjob@163.com
# Created Time: 四  6/16 11:13:39 2016
# pip install paramiko python-nmap
#========================================================================
import nmap
import telnetlib,re
import getpass
from django.db import models
import os
# from scanhosts.modules import paramiko1_9 as paramiko
# from scanhosts.modules import paramiko2_1_2 as paramiko
import  paramiko
import traceback
from scanhosts.models import HostLoginifo
from scanhosts.lib.utils import prpcrypt
import pexpect,datetime


import logging
logger = logging.getLogger("django")

os.environ["DJANGO_SETTINGS_MODULE"] = 'optools.settings'

class J_ssh_do(object):
    def __init__(self,info=""):
        self.whitelist = ["192.168.1.254","192.168.1.2","192.168.1.1","192.168.1.252","192.168.8.22",'192.168.8.2','192.168.8.3','192.168.8.5','192.168.8.252','192.168.10.253','192.168.12.254', '192.168.12.9', '192.168.12.6', '192.168.12.7', '192.168.12.2', '192.168.12.1', '192.168.12.15', '192.168.12.17', '192.168.12.10', '192.168.12.18', '192.168.12.19','192.168.12.8','192.168.12.8','192.168.12.13','192.168.12.14','192.168.12.16','192.168.12.11','192.168.12.12']
        self.result = {"info":info}

    def pass_do(self,login_info,cmd_list=""):
        '''
        用户密码方式登录
        :param login_info:登录的信息，如：('192.168.6.11', 22, 'root', '123')
        :param cmd_list:登录机器后，需要执行的命令
        :return:
        '''
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(login_info[0],login_info[1],login_info[2],login_info[3],timeout=3)
            self.result["status"] = "success"
            for cmd in cmd_list:
                stdin,stdout,stderr = ssh.exec_command(cmd,timeout=10)
                std_res = stdout.read()
                self.result[cmd] = std_res
        except Exception,e:
            print traceback.print_exc(),login_info
            logger.exception("Use passwd ssh login exception:%s,%s"%(e,login_info))
            self.result["status"] = "failed"
            self.result["res"] = str(e)
        return self.result

    def rsa_do(self,login_info,cmd_list=""):
        '''
        id_rsa密钥登录
        :param login_info:('192.168.6.11', 22, 'root', '/key/id_rsa','123')
        :param cmd_list:
        :return:
        '''
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            key = paramiko.RSAKey.from_private_key_file(login_info[3])
            ssh.connect(login_info[0],login_info[1],login_info[2],pkey=key,timeout=2)
            self.result["status"] = "success"
            for cmd in cmd_list:
                stdin,stdout,stderr = ssh.exec_command(cmd,timeout=10)
            #           stdin.write("Y")   #简单交互，输入 ‘Y’
                std_res = stdout.read()
                self.result[cmd] = std_res
        except Exception as e:
            print traceback.print_exc()
            logger.exception("Use rsa key ssh login exception:%s,%s"%(e,login_info))
            self.result["status"] = "failed"
            self.result["res"] = e
        return self.result

    def dsa_do(self,login_info,cmd_list=""):
        '''
        dsa密钥登录
        :param login_info:login_info:('192.168.6.11', 22, 'root', '/key/id_dsa','123')
        :param cmd_list:
        :return:
        '''
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            key = paramiko.DSSKey.from_private_key_file(login_info[3])
            ssh.connect(login_info[0],login_info[1],login_info[2],pkey=key,timeout=2)
            self.result["status"] = "success"
            for cmd in cmd_list:
                stdin,stdout,stderr = ssh.exec_command(cmd,timeout=10)
                std_res = stdout.read()
                self.result[cmd] = std_res
        except Exception as e:
            print traceback.print_exc()
            logger.exception("Use dsa key ssh login exception:%s,%s"%(e,login_info))
            self.result["status"] = "failed"
        return self.result

    def imoocc_rsa_do(self,login_info,cmd_list=""):
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            key = paramiko.RSAKey.from_private_key_file(login_info[3], login_info[4])
            ssh.connect(login_info[0],int(login_info[1]),login_info[2],pkey=key,timeout=2)
            self.result["status"] = "success"
            for cmd in cmd_list:
                stdin,stdout,stderr = ssh.exec_command(cmd,timeout=10)
                std_res = stdout.read()
                self.result[cmd] = std_res
        except Exception as e:
            print traceback.print_exc()
            logger.exception("Use rsa key and Non-root user ssh login exception:%s,%s"%(e,login_info))
            self.result["status"] = "failed"
        return self.result
    
    def run(self,ip,cmd):
        if ip and cmd:
            print ".......................ip",ip
            ip_item = HostLoginifo.objects.get(ip=ip)
            cn = prpcrypt()
            if ip_item.ssh_type==0:
                ssh_passwd = cn.decrypt(ip_item.ssh_passwd)
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ssh_passwd)
                res = self.pass_do(login_info,cmd)
            if ip_item.ssh_type==1:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                res = self.rsa_do(login_info,cmd)
            if ip_item.ssh_type==2:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa)
                res = self.dsa_do(login_info,cmd)
            if ip_item.ssh_type==3:
                login_info = (ip_item.ip,int(ip_item.ssh_port),ip_item.ssh_user,ip_item.ssh_rsa,ip_item.rsa_pass)
                res = self.imoocc_rsa_do(login_info,cmd)
            return res
        else:
            return ""

class J_net_do():
    '''
    登录交换机(cisco)执行，验证登录，执行备份
    '''
    def __init__(self,ip,login_info):
        self.username,self.passwd,self.en_passwd = login_info
        self.ip = ip

    def getToday(self):
        return datetime.date.today()

    def cisco_backup(self,back_server="",sw_backup=False):
        result = {}
        try:
            np = pexpect.spawn('telnet %s'%(self.ip))

            re_index = np.expect(['Username:','Password:'])

            if re_index == 0:
                np.sendline(self.username)
                np.expect('Password:')
                np.sendline(self.passwd)
                result["level"] = 1
                result["login_info"] = (self.username,self.passwd,self.en_passwd)
            elif re_index == 1:
                np.sendline(self.passwd)
                result["level"] = 1
                result["login_info"] = ("",self.passwd,self.en_passwd)

            su_index = np.expect(['>','#'])
            if su_index == 0:
                np.sendline('enable')
                np.expect('Password:')
                np.sendline(self.en_passwd)
                np.expect('#')

            if sw_backup:
                np.sendline("copy running-config tftp")
                np.expect(".*remote.*")
                np.sendline("%s"%(back_server))
                np.expect(".*filename.*")
                np.sendline("%s"%((self.ip+'_'+str(self.getToday())+"_runningconfig.cfg")))
                np.expect('#')
                np.sendline("exit")
                result['level'] = 2
            else:
                np.sendline("exit")
                result['level'] = 2
            result['status'] = "success"
        except Exception as e:
            result['status'] = "failed"
            result["res"] = str(e)
            print "Net Device ip %s backup not ok, error:%s"%(self.ip,e)
            logger.error("Net Device ip %s backup not ok, error:%s"%(self.ip,e))
        return result

    def cisco_login(self):
        result = {}

        try:
            np = pexpect.spawn('telnet %s'%(self.ip))
            re_index = np.expect(['Username:','Password:'])

            if re_index == 0:
                np.sendline(self.username)
                np.expect('Password:')
                np.sendline(self.passwd)
                result["level"] = 1
                result["login_info"] = (self.username,self.passwd,self.en_passwd)
            elif re_index == 1:
                np.sendline(self.passwd)
                result["level"] = 1
                result["login_info"] = ("",self.passwd,self.en_passwd)


            su_index = np.expect(['>','#'])
            if su_index == 0:
                np.sendline('enable')
                np.expect('Password:')
                np.sendline(self.en_passwd)
                np.expect('#')
                np.sendline("exit")
                result['level'] = 2
            else:
                np.sendline("exit")
                result['level'] = 2
            result["status"] = "success"

        except Exception as e:
            result['status'] = "failed"
            result["res"] = str(e)
            print "Net Device ip %s login not ok, error:%s"%(self.ip,e)
            logger.error("Net Device ip %s login not ok, error:%s"%(self.ip,e))
        return result













