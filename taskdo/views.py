# -*- coding: utf-8 -*-
import os
PROJECT_ROOT = os.path.realpath(os.path.dirname(__file__))
# import sys
# os.environ["DJANGO_SETTINGS_MODULE"] = 'admin.settings.settings'
# import django
# django.setup()
from django.shortcuts import render
import json
from django.http import HttpResponseRedirect,JsonResponse
from django.http import HttpResponseRedirect,JsonResponse
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import HttpResponse

from utils.ansible_api import ANSRunner
from scanhosts.lib.utils import prpcrypt

from taskdo.utils.base.MgCon import *
from taskdo.utils.base.RedisCon import *


from detail.models import ConnectionInfo
# from apps.test import test2
# from taskdo.utils.base.tools import CJsonEncoder


class DateEncoder(json.JSONEncoder ):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.__str__()
        return json.JSONEncoder.default(self, obj)

# Create your views here.
def adhoc_task(request):
    if request.method == "POST":
        result = {}
        jobs = request.body
        init_jobs = json.loads(jobs)

        mod_type = init_jobs["mod_type"] if not init_jobs["mod_type"] else "shell"
        sn_keys = init_jobs["sn_key"]
        exec_args = init_jobs[u"exec_args"]
        group_name = init_jobs[u"group_name"] if not init_jobs[u"group_name"] else "imoocc"
        taskid = init_jobs.get("taskid")
        if  not sn_keys or not exec_args or not taskid:
            result = {'status':"failed","code":002,"info":u"传入的参数mod_type不匹配！"}
            return HttpResponse(json.dumps(result), content_type="application/json")
        else:
            rlog = InsertAdhocLog(taskid=taskid)
        if mod_type not in ("shell","yum","copy"):
            result = {'status':"failed","code":003,"info":u"传入的参数不完整！"}
            rlog.record(id=10008)
        else:
            try:
                sn_keys = set(sn_keys)
                hosts_obj = ConnectionInfo.objects.filter(sn_key__in=sn_keys)
                rlog.record(id=10000)

                if len(sn_keys) != len(hosts_obj):
                    rlog.record(id=40004)
                else:
                    rlog.record(id=10002)
                    resource = {}
                    hosts_list = []
                    vars_dic = {}
                    cn = prpcrypt()
                    hosts_ip = []
                    for host in hosts_obj:
                        sshpasswd = cn.decrypt(host.ssh_userpasswd)
                        if host.ssh_type in (1,2):
                            """
                            resource =  {
                                "dynamic_host": {
                                    "hosts": [
                                                {"hostname": "192.168.1.108", "port": "22", "username": "root", "ssh_key": "/etc/ansible/ssh_keys/id_rsa"},
                                                {"hostname": "192.168.1.109", "port": "22", "username": "root","ssh_key": "/etc/ansible/ssh_keys/id_rsa"}
                                              ],
                                    "vars": {
                                             "var1":"ansible",
                                             "var2":"saltstack"
                                             }
                                }
                            }
                            """
                            hosts_list.append({"hostname":host.sn_key,"ip":host.ssh_hostip,"port":host.ssh_host_port,"username":host.ssh_username,"ssh_key":host.ssh_rsa})
                            hosts_ip.append(host.sn_key)
                        elif host.ssh_type in (0,4):
                            hosts_list.append({"hostname":host.sn_key,"ip":host.ssh_hostip,"port":host.ssh_host_port,"username":host.ssh_username,"password":sshpasswd})
                            hosts_ip.append(host.sn_key)
                        elif host.ssh_type == 3:
                            hosts_list.append({"hostname":host.sn_key,"ip":host.ssh_hostip,"port":host.ssh_host_port,"username":host.ssh_username,"ssh_key":host.ssh_rsa,"password":sshpasswd})
                            hosts_ip.append(host.sn_key)


                    resource[group_name]={"hosts":hosts_list,"vars":vars_dic}
                    rlog.record(id=10004)
                    #任务锁检查
                    lockstatus = DsRedis.get(rkey="tasklock")
                    if lockstatus is False or lockstatus == '1':
                        # 已经有任务在执行
                        rlog.record(id=40005)
                    else:
                        # 开始执行任务
                        DsRedis.setlock("tasklock",1)
                        jdo = ANSRunner(resource=resource,redisKey='1')
                        jdo.run_model(host_list=hosts_ip,module_name=mod_type,module_args=exec_args)
                        res = jdo.get_model_result()
                        rlog.record(id=19999,input_con=res)
                        rlog.record(id=20000)
                        DsRedis.setlock("tasklock",0)
                        result = {"status":"success","info":res}

            except Exception as e:
                import traceback
                print traceback.print_exc()
                DsRedis.setlock("tasklock",0)
                result = {"status":"failed","code":005,"info":e}
            finally:
                return HttpResponse(json.dumps(result), content_type="application/json")

# Create your views here.
def adhoc_task_log(request):
    if request.method == "GET":
        taskid = request.GET.get("taskid")
        result = {}
        if taskid :
            rlog = InsertAdhocLog(taskid=taskid)
            res = rlog.getrecord()
            result = {"status":"success",'taskid':taskid,"info":res}
        else:
            result = {"status":"failed","info":u"没有传入taskid值"}
        res = json.dumps(result,cls=DateEncoder)
        return HttpResponse(res,content_type="application/json")