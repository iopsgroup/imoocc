#!/usr/bin/env python
# -*- coding:utf-8 -*-
#########################################################################
# File Name:
# Program function:所有
# Author:Jeson
# mail:iaskjob@163.com
# Created Time: 四  6/16 11:13:39 2016
# pip install paramiko python-nmap
#========================================================================

from Crypto.Cipher import AES
from binascii import b2a_hex, a2b_hex
import re
def mac_trans(mac):
    '''
    转化mac地址，将传递到mac进行数据格式的转换
    :param mac:
    :return:
    '''
    if mac:
        mac_lst = mac.split("\n")
        mac_res = [item.replace(":",'').replace("000000000000",'').replace("00000000",'') for item in mac_lst]
        mac_string = "_".join(mac_res)
        return mac_string
    else:
        return ""

def sn_trans(sn):
    '''
    转化SN序列号，将传递到SN号进行数据格式的转换
    :param mac:
    :return:
    '''
    if sn:
        sn_res = sn.replace(" ",'')
        return sn_res
    else:
        return ""

def machine_type_trans(mt):
    '''
    转化类型，将传递到类型进行数据格式的转换
    :param mac:
    :return:
    '''
    if mt:
        mt_res = mt.replace("\n",'')
        return mt_res
    else:
        return ""


class prpcrypt():
    '''
    用于通过密钥进行重要数据的加密解密
    '''
    def __init__(self):
        self.key = "okeqwnk2987#$%ql"
        #这里密钥key 长度必须为16（AES-128）,
        #24（AES-192）,或者32 （AES-256）Bytes 长度
        #目前AES-128 足够目前使用
        self.mode = AES.MODE_CBC

    #加密函数，如果text不足18位就用空格补足为18位，
    #如果大于16当时不是18的倍数，那就补足为18的倍数。
    def encrypt(self,text):
        cryptor = AES.new(self.key,self.mode,b'0000000000000000')

        length = 16
        count = len(text)
        if count < length:
            add = (length-count)
            #\0 backspace
            text = text + ('\0' * add)
        elif count > length:
            add = (length-(count % length))
            text = text + ('\0' * add)
        self.ciphertext = cryptor.encrypt(text)
        #因为AES加密时候得到的字符串不一定是ascii字符集的，输出到终端或者保存时候可能存在问题
        #所以这里统一把加密后的字符串转化为16进制字符串
        return b2a_hex(self.ciphertext)

    #解密后，去掉补足的空格用strip() 去掉
    def decrypt(self,text):
        cryptor = AES.new(self.key,self.mode,b'0000000000000000')
        plain_text  = cryptor.decrypt(a2b_hex(text))
        return plain_text.rstrip('\0')

def getsysversion(version_list):
    '''
    提取系统版本
    :param version_list:
    :return:
    '''
    for version_data in version_list:
        v_data_lst = re.findall("vmware|centos|linux|ubuntu|redhat|\d{1,}\.\d{1,}",version_data,re.IGNORECASE)
        if v_data_lst:
            if len(v_data_lst) > 1:
                v_data = " ".join(v_data_lst)
                break
        else:
            v_data = ""
    return v_data