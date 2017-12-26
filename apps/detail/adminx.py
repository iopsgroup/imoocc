import xadmin
from .models import *


class StatisticsRecordAdmin(object):
    list_display = ['all_count', 'pyh_count', 'net_count', 'other_count', 'datatime']


class PhysicalServerInfoAdmin(object):
    list_display = ['server_ip', 'machine_brand', 'system_ver', 'sys_hostname', 'sn', 'vir_type']
    search_fields = ['server_ip', 'machine_brand', 'system_ver', 'sys_hostname', 'sn', 'vir_type']
    list_filter = ['server_ip', 'machine_brand', 'system_ver', 'sys_hostname', 'sn', 'vir_type']
    list_per_page = 10


class VirtualServerInfoAdmin(object):
    list_display = ['server_ip', 'server_type', 'system_ver', 'sys_hostname', 'sn']
    search_fields = ['server_ip', 'server_type', 'system_ver', 'sys_hostname', 'sn']
    list_filter = ['server_ip', 'server_type', 'system_ver', 'sys_hostname', 'sn']
    list_per_page = 10


class NetWorkInfoAdmin(object):
    list_display = ['host_ip', 'host_name', 'sn']
    search_fields = ['host_ip', 'host_name', 'sn']
    list_filter = ['host_ip', 'host_name', 'sn']


class OtherMachineInfoAdmin(object):
    list_display = ['ip', 'sn_key', 'machine_name', 'reson_str']
    search_field = ['ip', 'sn_key', 'machine_name']
    list_filter = ['ip', 'sn_key', 'machine_name', 'reson_str']
    list_per_page = 10


class ConnectionInfoAdmin(object):
    list_display = ['ssh_username', 'ssh_hostip', 'ssh_status', 'ssh_type', 'sn_key']
    search_field = ['ssh_username', 'ssh_hostip', 'ssh_status', 'ssh_type', 'sn_key']
    list_filter = ['ssh_username', 'ssh_hostip', 'ssh_status', 'ssh_type', 'sn_key']


class NetConnectionInfoAdmin(object):
    list_display = ['tel_username', 'tel_hostip', 'tel_status', 'tel_type', 'sn_key']
    search_field = ['tel_username', 'tel_hostip', 'tel_status', 'tel_type', 'sn_key']
    list_filter = ['tel_username', 'tel_hostip', 'tel_status', 'tel_type', 'sn_key']


class CabinetInfoAdmin(object):
    list_display = ['cab_name', 'cab_lever']
    search_fields = ['cab_name', 'cab_lever']
    list_filter = ['cab_name', 'cab_lever']

xadmin.site.register(StatisticsRecord, StatisticsRecordAdmin)
xadmin.site.register(PhysicalServerInfo, PhysicalServerInfoAdmin)
xadmin.site.register(VirtualServerInfo, VirtualServerInfoAdmin)
xadmin.site.register(NetWorkInfo, NetWorkInfoAdmin)
xadmin.site.register(OtherMachineInfo, OtherMachineInfoAdmin)
xadmin.site.register(ConnectionInfo, ConnectionInfoAdmin)
xadmin.site.register(NetConnectionInfo, NetConnectionInfoAdmin)
xadmin.site.register(CabinetInfo, CabinetInfoAdmin)
