# -*- coding:utf-8 -*-
from django.http import JsonResponse
from django.shortcuts import render
from users.utils.verify import *
from operations.models import *
from scanhosts.lib.utils import prpcrypt
from .utils.machines import *
from .models import *
from .utils.handdles import *


def index(request):
    """首页"""
    machines = Machines()
    cabinets = machines.all_machines(CabinetInfo)
    phy_servers = machines.all_machines(PhysicalServerInfo)
    vir_servers = machines.all_machines(VirtualServerInfo)
    networks = machines.all_machines(NetWorkInfo)
    othermachines = machines.all_machines(OtherMachineInfo)
    server_classify = ServersClassify()
    phy_classify = server_classify.phy_classify(phy_servers)
    vir_classify = server_classify.vir_classify(vir_servers)
    context = {'title': "首页", 'platform': '1', 'cabinets': cabinets, 'networks': networks,
               'othermachines': othermachines, 'phy_classify': phy_classify, 'vir_classify': vir_classify}
    return render(request, 'detail/index.html', context)


@login
def machine_list(request):
    """设备列表"""
    sn_states = SnStates().sn_states()
    types = request.GET.get("type")
    machines = Machines()
    if types == 'cb':
        paginator = Paginator(machines.all_machines(CabinetInfo), 10)
        template = "detail/cab_list.html"
    elif types == 'p':
        paginator = Paginator(machines.all_machines(PhysicalServerInfo), 10)
        template = "detail/list_phy.html"
    elif types == 'v':
        paginator = Paginator(machines.all_machines(VirtualServerInfo), 10)
        template = "detail/list_vir.html"
    elif types == 'n':
        paginator = Paginator(machines.all_machines(NetWorkInfo), 10)
        template = "detail/list_net.html"
    elif types == 'c':
        paginator = Paginator(machines.all_machines(ConnectionInfo), 10)
        template = "detail/list_conn.html"
    elif types == 'o':
        paginator = Paginator(machines.all_machines(OtherMachineInfo), 10)
        template = "detail/list_oth.html"
    elif types == 'nc':
        paginator = Paginator(machines.all_machines(NetConnectionInfo), 10)
        template = "detail/list_netconns.html"
    elif types == 'op':
        paginator = Paginator(machines.all_machines(MachineOperationsInfo), 10)
        template = "detail/list_opts.html"
    elif types[0:2] == 'ct':
        paginator = Paginator(machines.filter_vir_servers(Vir_Phy_Id=int(types[2:])), 10)
        template = "detail/phy_contains.html"
    page = PageDeal().pages_deal(int(request.GET.get('p')), paginator)
    context = {'title': "设备列表", 'page': page, 'types': types, 'sn_states': sn_states}
    return render(request, template_name=template, context=context)


@login
@level
def detail(request, types):
    """详情页"""
    did = int(request.GET.get('dID'))
    machine_obj = Machines()
    sn_states = SnStates().sn_states()
    if types == "p":
        phy_servers = machine_obj.filter_machines(PhysicalServerInfo, pk=did)[0]
        item = phy_servers.__dict__
        detail_name = "物理设备"
        template = 'detail/detail_p.html'
    elif types == "v":
        vir_servers = machine_obj.filter_machines(VirtualServerInfo, pk=did)[0]
        item = vir_servers.__dict__
        detail_name = "虚拟设备"
        template = 'detail/detail_v.html'
    elif types == "n":
        networks = machine_obj.filter_machines(NetWorkInfo, pk=did)[0]

        print "networks...................",networks
        item = networks.__dict__
        print "item.......................",item
        detail_name = "网络设备"
        template = 'detail/detail_n.html'
    elif types == "o":
        others = machine_obj.filter_machines(OtherMachineInfo, pk=did)[0]
        item = others.__dict__
        detail_name = "其它设备"
        template = "detail/detail_o.html"
    elif types == "c":
        conn = machine_obj.filter_machines(ConnectionInfo, pk=did)[0]
        conn.ssh_userpasswd = prpcrypt().decrypt(conn.ssh_userpasswd)
        item = conn.__dict__
        detail_name = "用户连接"
        template = 'detail/detail_c.html'
    elif types == "nc":
        item = machine_obj.filter_machines(NetConnectionInfo, pk=did)[0]
        item.tel_userpasswd = prpcrypt().decrypt(item.tel_userpasswd)
        item.tel_enpasswd = prpcrypt().decrypt(item.tel_enpasswd)
        detail_name = "用户连接的网络设备"
        template = 'detail/detail_nc.html'
    elif types == 'op':
        item = machine_obj.filter_machines(MachineOperationsInfo, pk=did)[0]
        detail_name = '设备操作记录'
        template = 'detail/detail_opts.html'
    context = {'title': "详情页", 'item': item, 'detail_name': detail_name, 'sn_states': sn_states}
    return render(request, template_name=template,  context=context)


@login
def classify(request):
    """分类列表"""
    types = request.GET.get("type")
    p = int(request.GET.get('p'))
    machines = Machines()
    paginator_deal = PaginatorDeal()
    if types == "kvm":
        page = paginator_deal.page_obj(machines.filter_phy_servers(Vir_Type='0'), p)
        title = "KVM"
        template = "detail/classify_phy.html"
    elif types == "doc":
        page = paginator_deal.page_obj(machines.filter_phy_servers(Vir_Type='1'), p)
        title = "DOCKER"
        template = "detail/classify_phy.html"
    elif types == "esx":
        page = paginator_deal.page_obj(machines.filter_phy_servers(Vir_Type='2'), p)
        title = "ESXI"
        template = "detail/classify_phy.html"
    elif types == "VM":
        page = paginator_deal.page_obj(machines.filter_vir_servers1(Server_Type='VM'), p)
        title = "VMWARE"
        template = "detail/classify_vir.html"
    elif types == "Do":
        page = paginator_deal.page_obj(machines.filter_vir_servers1(Server_Type='Do'), p)
        title = "DOCKER"
        template = "detail/classify_vir.html"
    elif types == "KV":
        page = paginator_deal.page_obj(machines.filter_vir_servers1(Server_Type='KV'), p)
        title = "KVM"
        template = "detail/classify_vir.html"
    else:
        page = paginator_deal.page_obj(machines.filter_phy_servers(Vir_Type=''), p)
        title = "其它类型"
        template = "detail/classify_phy.html"
    context = {'title': title, 'page': page, 'types': types}
    return render(request, template_name=template, context=context)


@login
@level
def revalue(request):
    """其它设备参数修改"""
    value = request.GET.get('value')
    name = request.GET.get('name')
    others = Machines().filter_machines(OtherMachineInfo, pk=request.GET.get('dID'))[0]
    if name == 'remark':
        others.remark = value
    elif name == 'machine_name':
        others.machine_name = value
    elif name == 'reson_str':
        others.reson_str = value
    elif name == 'oth_cab_id':
        return '再考虑考虑'
    others.save()
    return JsonResponse({'is_ok': 1})
