# -*- coding:utf-8 -*-
from django.template import Library
from detail.utils.machines import Machines
from detail.models import *
register = Library()


@register.filter
def revalue(value):
    """物理机类型"""
    column = {
        '0': "KVM",
        '1': 'Docker',
        '2': 'ESXI',
        '': '其它类型'
    }
    for key in column:
        if value == key:
            return column[key] + "  (" + key + ")"


@register.filter
def get_state(state, key):
    """设备状态"""
    machines = Machines()
    # if key != '':
        # sn_key = machines.filter_machines(ConnectionInfo, pk=key)[0].sn_key
        # machine = machines.filter_operations(SN=sn_key)[0]
        # state = machine.state
    state = 2
    if state == 0:
        return '已报废'
    elif state == 1:
        return '测试使用'
    elif state == 2:
        return '线上运行'
    elif state == 3:
        return '下线'


@register.filter
def get_state_n(item, key):
    machine_state == 2
    # machine = Machines().filter_operations(SN=key)[0]
    if machine_state == 0:
        return '已报废'
    elif machine_state == 1:
        return '测试使用'
    elif machine_state == 2:
        return '线上运行'
    elif machine_state == 3:
        return '下线'


@register.filter
def cab_name(cab_id):
    cab_id_name = {1: 'J01', 2: 'J02', 3: 'J03', 4: 'J05'}
    return cab_id_name[cab_id]


@register.filter
def netconn_states(num):
    """用户连接网络设备状态"""
    if num == 0:
        netconn_state = '登录失败'
    else:
        netconn_state = '登录成功'
    return netconn_state


@register.filter
def netconn_types(num):
    """用户连接网络设备状态"""
    if num == 1:
        netconn_state = '普通用户可登录'
    else:
        netconn_state = '超级用户可登录'
    return netconn_state

"""
@register.filter
def rename(name):
    column ={
        "id": "id",
        "_state": "状态",
        "sys_hostname": "操作系统主机名",
        "mac": "MAC地址",
        "sn": "设备唯一标识",
        "server_ip": "服务器IP",
        "system_ver": "操作系统版本",
        "machine_brand": "服务器品牌",
        "server_type": "服务器类型",

        "host_ip": "网络设备ip",
        "host_name": "网络设备名",

        "sn_key": "唯一设备标识",
        "ssh_username": "ssh用户名",
        "ssh_userpasswd": "ssh用户密码",
        "ssh_host_port": "ssh登录的端口",
        "ssh_rsa": "ssh密钥",
        "ssh_type": "用户连接类型",
        "ssh_status": "用户连接状态",
        "ssh_hostip": "ssh登录的ip",
        "rsa_pass": "私钥的密钥",
        "vir_type": "宿主机类型",

        "vir_phy_id": "虚拟机所属的物理机ID",
        "net_cab_id": "网络设备所属机柜ID",
        "conn_vir_id": "连接的用户ID",
        "conn_phy_id": "连接的用户ID",
        "ser_cabin_id": "物理机所属机柜ID",

        "ip": "设备ip",
        "machine_name": "设备名称",
        "remark": "备注",
        "oth_cab_id": "设备所在机柜编号",
        "reson_str": "归类原因"
    }
    for key in column:
        if key == name:
            return column[key] + "  (" + key + ")"
"""
