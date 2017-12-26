# -*- coding:utf-8 -*-
from django.db.models import Q
from django.shortcuts import render
from users.utils.verify import *
from detail.models import *
from operations.models import *


@login
def search_list(request, types):
    keywords = request.GET.get('keywords')
    keywords_dict = {u'报废': 0, u'已报废': 0, u'废': 0, u'坏': 0, u'测试': 1, u'测试使用': 1, u'使用': 1,
                     u'线上运行': 2, u'线上': 2, u'运行': 2, u'未使用': 3, u'下线': 3}
    if types == 'physicalserver':
        for key in keywords_dict.keys():
            if keywords == key:
                page = MachineOperationsInfo.objects.filter(state=keywords_dict[keywords])
                # page = PhysicalServerInfo.objects.filter()
                # print '-'*20, page, len(page)
            else:
                page = PhysicalServerInfo.objects.filter(
                    Q(server_ip__icontains=keywords) |
                    Q(machine_brand__icontains=keywords) |
                    Q(system_ver__icontains=keywords) |
                    Q(sys_hostname__icontains=keywords) |
                    Q(mac__icontains=keywords) |
                    Q(sn__icontains=keywords) |
                    Q(vir_type__icontains=keywords))
                template = "detail/list_phy.html"
    elif types == 'virtualserver':
        page = VirtualServerInfo.objects.filter(
            Q(server_ip__icontains=keywords) |
            Q(server_type__icontains=keywords) |
            Q(sys_hostname__icontains=keywords) |
            Q(system_ver__icontains=keywords) |
            Q(sn__icontains=keywords))
        template = "detail/list_vir.html"
    elif types == 'network':
        page = NetWorkInfo.objects.filter(
            Q(host_ip__icontains=keywords) |
            Q(sn__icontains=keywords) |
            Q(host_name__icontains=keywords))
        template = "detail/list_net.html"
    elif types == 'othermachine':
        page = OtherMachineInfo.objects.filter(
            Q(ip__icontains=keywords) |
            Q(sn_key__icontains=keywords) |
            Q(machine_name__icontains=keywords))
        template = "detail/list_oth.html"
    else:
        phy_servers = PhysicalServerInfo.objects.filter(
            Q(server_ip__icontains=keywords) |
            Q(machine_brand__icontains=keywords) |
            Q(system_ver__icontains=keywords) |
            Q(sys_hostname__icontains=keywords) |
            Q(mac__icontains=keywords) |
            Q(sn__icontains=keywords) |
            Q(vir_type__icontains=keywords))
        vir_servers = VirtualServerInfo.objects.filter(
            Q(server_ip__icontains=keywords) |
            Q(server_type__icontains=keywords) |
            Q(sys_hostname__icontains=keywords) |
            Q(system_ver__icontains=keywords) |
            Q(sn__icontains=keywords))
        networks = NetWorkInfo.objects.filter(
            Q(host_ip__icontains=keywords) |
            Q(sn__icontains=keywords) |
            Q(host_name__icontains=keywords))
        others = OtherMachineInfo.objects.filter(
            Q(ip__icontains=keywords) |
            Q(sn_key__icontains=keywords) |
            Q(machine_name__icontains=keywords))
        return render(request, "detail/list_search.html",
                      {"title": "搜索结果", "keywords": keywords,
                       "phy_servers": phy_servers, "vir_servers": vir_servers, "networks": networks, "others": others})
    context = {"title": "搜索结果", "keywords": keywords, "page": page}
    return render(request, template_name=template, context=context)

