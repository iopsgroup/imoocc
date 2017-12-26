# coding=utf-8
from detail.models import *
from django.shortcuts import redirect
from detail.utils.machines import *


def state_handdle(request):
    """状态修改"""
    detail_type = request.GET.get('detail_type')
    # 注：when detail_type='o' or 'n'时，下面conn_sn_key为设备序列号，并非用户连接的唯一设备标识或者id
    # 注：when detail_type='p' or 'v'时，下面conn_sn_key为与用户关联的id，并非唯一设备标识或者设备序列号
    conn_sn_key = request.POST.get('conn_id')
    state = request.POST.get('state')
    state_dict = {u'已报废': 0, u'测试使用': 1, u'线上运行': 2, u'下线': 3}
    if detail_type == ('p' or 'v'):
        conn_sn_key = Machines().filter_machines(ConnectionInfo, pk=conn_sn_key)[0].sn_key
    machine = Machines().filter_operations(SN=conn_sn_key)[0]
    machine.state = state_dict[state]
    machine.save()
    return redirect(request.session.get('path', '/'))

