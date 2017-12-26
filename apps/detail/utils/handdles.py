# -*- coding:utf-8 -*-
from django.core.paginator import Paginator


class ServersClassify(object):

    def __init__(self):
        self.phy = {'phy_num': 0, 'kvm': 0, 'docker': 0, 'esxi': 0, 'other': 0}
        self.vir = {'vir_num': 0, 'kvm': 0, 'docker': 0, 'vmware': 0}

    def phy_classify(self, phy_servers):
        self.phy['phy_num'] = len(phy_servers)
        for phy_server in phy_servers:
            if phy_server.vir_type == "0":
                self.phy['kvm'] += 1
            elif phy_server.vir_type == "1":
                self.phy['docker'] += 1
            elif phy_server.vir_type == "2":
                self.phy['esxi'] += 1
            else:
                self.phy['other'] += 1
        return self.phy

    def vir_classify(self, vir_servers):
        self.vir['vir_num'] = len(vir_servers)
        for vir_server in vir_servers:
            if vir_server.server_type[0:2] == "VM":
                self.vir['vmware'] += 1
            elif vir_server.server_type[0:2] == "Do":
                self.vir['docker'] += 1
            elif vir_server.server_type[0:2] == "KV":
                self.vir['kvm'] += 1
        return self.vir


class PageDeal(object):
    """页码处理"""
    def __init__(self):
        pass

    def pages_deal(self, num, objects):
        if num < 1:
            num = 1
        elif num > objects.num_pages:
            num = objects.num_pages
        return objects.page(num)


class PaginatorDeal(object):

    def __init__(self):
        pass

    def paginator_obj(self, obj_list):
        return Paginator(obj_list, 10)

    def page_obj(self, obj_list, num):
        return self.paginator_obj(obj_list).page(num)

