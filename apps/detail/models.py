# -*- coding:utf-8 -*-
from django.db import models
import django.utils.timezone as timezone


# 用户登录信息表(服务器、虚拟机)
class ConnectionInfo(models.Model):
    # 用户连接相关信息
    ssh_username = models.CharField(max_length=10, default='', verbose_name=u'ssh用户名', null=True)
    ssh_userpasswd = models.CharField(max_length=40, default='', verbose_name=u'ssh用户密码', null=True)
    ssh_hostip = models.CharField(max_length=40, default='', verbose_name=u'ssh登录的ip', null=True)
    ssh_host_port = models.CharField(max_length=10, default='', verbose_name=u'ssh登录的端口', null=True)
    ssh_rsa = models.CharField(max_length=64, default='', verbose_name=u'ssh私钥')
    rsa_pass = models.CharField(max_length=64, default='', verbose_name=u'私钥的密钥')
    # 0-登录失败,1-登录成功
    ssh_status = models.IntegerField(default=0, verbose_name=u'用户连接状态,0-登录失败,1-登录成功')
    # 1-rsa登录,2-dsa登录,3-普通用户_rsa登录,4-docker成功,5-docker无法登录
    ssh_type = models.IntegerField(default=0, verbose_name=u'用户连接类型, 1-rsa登录,2-dsa登录,'
                                                           u'3-ssh_rsa登录,4-docker成功,5-docker无法登录')
    # 唯一对象标示
    sn_key = models.CharField(max_length=256, verbose_name=u"唯一设备ID", default="")

    class Meta:
        verbose_name = u'用户登录信息表'
        verbose_name_plural = verbose_name
        db_table = "connectioninfo"

#用户登录信息表(交换机、网络设备)
class NetConnectionInfo(models.Model):
    tel_username = models.CharField(max_length=10, default='', verbose_name=u'用户名', null=True)
    tel_userpasswd = models.CharField(max_length=40, default='', verbose_name=u'设备用户密码', null=True)
    tel_enpasswd = models.CharField(max_length=40, default='', verbose_name=u'设备超级用户密码', null=True)
    tel_host_port = models.CharField(max_length=10, default='', verbose_name=u'设备登录的端口', null=True)
    tel_hostip = models.CharField(max_length=40, default='', verbose_name=u'设备登录的ip', null=True)

    # 0-登录失败,1-登录成功
    tel_status = models.IntegerField(default=0, verbose_name=u'用户连接状态,0-登录失败,1-登录成功')
    tel_type = models.IntegerField(default=0, verbose_name=u'用户连接类型, 1-普通用户可登录,2-超级用户可登录')
    # 唯一对象标示
    sn_key = models.CharField(max_length=256, verbose_name=u"唯一设备ID", default="")

    dev_info = models.ForeignKey('NetWorkInfo')
    class Meta:
        verbose_name = u'网络设备用户登录信息'
        verbose_name_plural = verbose_name
        db_table = "netconnectioninfo"

# 机柜的信息
class CabinetInfo(models.Model):
    cab_name = models.CharField(max_length=10, verbose_name=u'机柜编号')
    # 1-10分别代表1~10层
    cab_lever = models.CharField(max_length=2, verbose_name=u'机器U数,1-10分别代表1~10层')

    class Meta:
        verbose_name = u'机柜信息表'
        verbose_name_plural = verbose_name
        db_table = "cabinetinfo"


# 物理服务器信息
class PhysicalServerInfo(models.Model):
    # server_name = models.CharField(max_length=15, verbose_name=u'服务器名')
    server_ip = models.CharField(max_length=40, verbose_name=u'服务器IP')
    # 机器的类型 dell or other?
    machine_brand = models.CharField(max_length=60, default='--', verbose_name=u'服务器品牌')
    # 机器的类型
    # machine_type = models.IntegerField(default=0, verbose_name=u'服务器,0-物理服务器，1-虚拟服务器，2-')
    system_ver = models.CharField(max_length=30, default='', verbose_name=u'操作系统版本')
    sys_hostname = models.CharField(max_length=15, verbose_name=u'操作系统主机名')
    mac = models.CharField(max_length=512, default='', verbose_name=u'MAC地址')
    sn = models.CharField(max_length=256, verbose_name=u'SN-主机的唯一标识', default='')
    vir_type = models.CharField(max_length=2, verbose_name=u'宿主机类型', default='')
    # 物理服务器关联的机柜
    ser_cabin = models.ForeignKey('CabinetInfo')
    # 用户登录系统信息
    conn_phy = models.ForeignKey('ConnectionInfo')

    class Meta:
        verbose_name = u'物理服务器信息表'
        verbose_name_plural = verbose_name
        db_table = "physicalserverinfo"


# 虚拟设备信息
class VirtualServerInfo(models.Model):
    # server_name = models.CharField(max_length=15, verbose_name=u'服务器名')
    server_ip = models.CharField(max_length=40, verbose_name=u'服务器IP')
    # 机器的类型 0=kvm,2=虚拟资产,3=网络设备 0=其他类型(未知)
    server_type = models.CharField(max_length=80, default='', verbose_name=u'服务器类型:kvm,Vmware,Docker,others')
    system_ver = models.CharField(max_length=30, default='', verbose_name=u'操作系统版本')
    sys_hostname = models.CharField(max_length=15, verbose_name=u'操作系统主机名')
    mac = models.CharField(max_length=512, default='', verbose_name=u'MAC地址')
    sn = models.CharField(max_length=256, verbose_name=u'SN-主机的唯一标识', default='')

    # 虚拟设备关联的物理服务器
    vir_phy = models.ForeignKey('PhysicalServerInfo')
    # 用户登录系统信息
    conn_vir = models.ForeignKey('ConnectionInfo')

    class Meta:
        verbose_name = u'虚拟设备表'
        verbose_name_plural = verbose_name
        db_table = "virtualserverinfo"


# 网络设备表
class NetWorkInfo(models.Model):
    host_ip = models.CharField(max_length=40, verbose_name=u'网络设备ip')
    host_name = models.CharField(max_length=10, verbose_name=u'网络设备名')
    sn = models.CharField(max_length=256, verbose_name=u"SN－设备的唯一标识", default="")

    # 网络设备所在的机柜
    net_cab = models.ForeignKey('CabinetInfo')


    class Meta:
        verbose_name = u'网络设备表'
        verbose_name_plural = verbose_name
        db_table = "networkinfo"


class OtherMachineInfo(models.Model):
    ip = models.CharField(max_length=40, verbose_name=u'设备ip')
    sn_key = models.CharField(max_length=256, verbose_name=u'设备的唯一标识')
    machine_name = models.CharField(max_length=20, verbose_name=u'设备名称')
    remark = models.TextField(default='', verbose_name=u'备注')
    reson_str = models.CharField(max_length=128,verbose_name=u"归纳原因",default='')
    # 关联的机柜
    oth_cab = models.ForeignKey('CabinetInfo')

    class Meta:
        verbose_name = u'其它设备表'
        verbose_name_plural = verbose_name
        db_table = 'othermachineinfo'


class StatisticsRecord(models.Model):
    datatime = models.DateTimeField(verbose_name=u"更新时间",default=timezone.now().strftime('%Y-%m-%d'))
    all_count = models.IntegerField(verbose_name=u"所有设备数量",default=0)
    pyh_count = models.IntegerField(verbose_name=u"物理设备数量",default=0)
    net_count = models.IntegerField(verbose_name=u"网络设备数量",default=0)
    other_count = models.IntegerField(verbose_name=u"其他设备数量",default=0)
    kvm_count = models.IntegerField(verbose_name=u"KVM设备数量",default=0)
    docker_count = models.IntegerField(verbose_name=u"Docker设备数量",default=0)
    vmx_count = models.IntegerField(verbose_name=u"VMX设备数量",default=0)

    class Meta:
        verbose_name = u'扫描后的汇总硬件统计信息'
        verbose_name_plural = verbose_name
        db_table = 'statisticsrecord'

