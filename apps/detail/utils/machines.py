# -*- coding:utf-8 -*-
from django.db.models import Q
from detail.models import *
from operations.models import *


class Machines(object):
    """设备查询过滤"""
    def __init__(self):
        pass

    def all_machines(self, obj):
        return obj.objects.all()

    def filter_machines(self, obj, pk=None):
        return obj.objects.filter(id=pk)

    def filter_phy_servers(self, ID=None, SN=None, Vir_Type=None):
        return PhysicalServerInfo.objects.filter(Q(id=ID) | Q(sn=SN) | Q(vir_type=Vir_Type))

    def filter_vir_servers(self, ID=None, Vir_Phy_Id=None, Server_Type=None):
        return VirtualServerInfo.objects.filter(Q(id=ID) | Q(vir_phy_id=Vir_Phy_Id))

    def filter_vir_servers1(self, Server_Type):
        return VirtualServerInfo.objects.filter(server_type__istartswith=Server_Type)

    def filter_operations(self, SN=None):
        return MachineOperationsInfo.objects.filter(sn_key__icontains=SN)

    def get_all_count(self):
        res = {}
        res['pyh_c'] = self.all_machines(PhysicalServerInfo).count()
        res['net_c'] = self.all_machines(NetWorkInfo).count()
        res['other_c'] = self.all_machines(OtherMachineInfo).count()
        res['kvm_c'] = self.filter_vir_servers1('kvm').count()
        res['docker_c'] = self.filter_vir_servers1('docker').count()
        res['vmx_c'] = self.filter_vir_servers1('vmx').count()
        res['all_c'] = res['pyh_c'] + res['other_c'] + res['kvm_c'] + res['docker_c'] + res['vmx_c']
        return res


class SnStates(object):
    """设备运行状态"""

    def __init__(self):
        self.machines = Machines().all_machines(MachineOperationsInfo)
        self.sn_state = {}

    def sn_states(self):
        for machine in self.machines:
            dicts = machine.__dict__
            self.sn_state[dicts['sn_key']] = dicts['state']
        return self.sn_state
