import xadmin
from .models import *


class MachineOperationsInfoAdmin(object):
    list_display = ['id', 'person', 'sn_key', 'machine_type', 'state', 'time']
    search_field = ['person', 'sn_key', 'machine_type', 'state']
    list_filter = ['person', 'sn_key', 'machine_type', 'state', 'time']


xadmin.site.register(MachineOperationsInfo, MachineOperationsInfoAdmin)
