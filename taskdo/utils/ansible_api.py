#!/usr/bin/env python
# -*- coding=utf-8 -*-
__author__ = 'jeson'

# import os,sys
# PROJECT_ROOT = '/Users/renren/Work/imoocc/code/iops'
# sys.path.insert(0,PROJECT_ROOT)
# os.environ["DJANGO_SETTINGS_MODULE"] = 'admin.settings.settings'
# import django
# django.setup()

import json,sys,os
from ansible import constants
from collections import namedtuple
from ansible.parsing.dataloader import DataLoader
from ansible.playbook.play import Play
from ansible.executor.task_queue_manager import TaskQueueManager
from ansible.executor.playbook_executor import PlaybookExecutor
from ansible.plugins.callback import CallbackBase
from ansible.inventory.manager import InventoryManager
from ansible.vars.manager import VariableManager
from ansible.inventory.host import Host,Group
from admin.settings.settings import BASE_DIR


class MyInventory():
    """
    this is IOPS ansible inventory object.
    """

    def __init__(self,resource,loader,variable_manager):
        self.resource = resource
        self.loader = DataLoader()
        self.inventory = InventoryManager(loader=self.loader, sources=['%s/conf/hostslist'%BASE_DIR])
        # self.variable_manager.set_inventory(self.inventory)
        self.variable_manager = VariableManager(loader=self.loader, inventory=self.inventory)
        self.dynamic_inventory()


    def add_dynamic_group(self, hosts, groupname, groupvars=None):
        """
            add hosts to a group
        """
        self.inventory.add_group(groupname)
        my_group = Group(name=groupname)



        # if group variables exists, add them to group
        if groupvars:
            for key, value in groupvars.iteritems():
                my_group.set_variable(key, value)

        # add hosts to group
        for host in hosts:
            # set connection variables
            hostname = host.get("hostname")
            hostip = host.get('ip', hostname)
            hostport = host.get("port")
            username = host.get("username")
            password = host.get("password")
            ssh_key = host.get("ssh_key")
            my_host = Host(name=hostname, port=hostport)
            self.variable_manager.set_host_variable(host=my_host,varname='ansible_ssh_host',value=hostip)
            self.variable_manager.set_host_variable(host=my_host,varname='ansible_ssh_pass',value=password)
            self.variable_manager.set_host_variable(host=my_host,varname='ansible_ssh_port',value=hostport)
            self.variable_manager.set_host_variable(host=my_host,varname='ansible_ssh_user',value=username)
            self.variable_manager.set_host_variable(host=my_host,varname='ansible_ssh_private_key_file',value=ssh_key)
            # my_host.set_variable('ansible_ssh_pass', password)
            # my_host.set_variable('ansible_ssh_private_key_file', ssh_key)

            # set other variables
            for key, value in host.iteritems():
                if key not in ["hostname", "port", "username", "password"]:
                    self.variable_manager.set_host_variable(host=my_host,varname=key,value=value)

            # add to group

            self.inventory.add_host(host=hostname,group=groupname,port=hostport)
            ghost = Host(name="192.168.8.119")


    def dynamic_inventory(self):
        """
            add hosts to inventory.
        """
        if isinstance(self.resource, list):
            self.add_dynamic_group(self.resource, 'default_group')
        elif isinstance(self.resource, dict):
            for groupname, hosts_and_vars in self.resource.iteritems():
                self.add_dynamic_group(hosts_and_vars.get("hosts"), groupname, hosts_and_vars.get("vars"))

class ModelResultsCollector(CallbackBase):

    def __init__(self, *args, **kwargs):
        super(ModelResultsCollector, self).__init__(*args, **kwargs)
        self.host_ok = {}
        self.host_unreachable = {}
        self.host_failed = {}

    def v2_runner_on_unreachable(self, result):
        self.host_unreachable[result._host.get_name()] = result

    def v2_runner_on_ok(self, result,  *args, **kwargs):
        self.host_ok[result._host.get_name()] = result


    def v2_runner_on_failed(self, result,  *args, **kwargs):
        self.host_failed[result._host.get_name()] = result

class PlayBookResultsCollector(CallbackBase):
    CALLBACK_VERSION = 2.0
    def __init__(self, *args, **kwargs):
        super(PlayBookResultsCollector, self).__init__(*args, **kwargs)
        self.task_ok = {}
        self.task_skipped = {}
        self.task_failed = {}
        self.task_status = {}
        self.task_unreachable = {}

    def v2_runner_on_ok(self, result, *args, **kwargs):
        self.task_ok[result._host.get_name()]  = result

    def v2_runner_on_failed(self, result, *args, **kwargs):
        self.task_failed[result._host.get_name()] = result

    def v2_runner_on_unreachable(self, result):
        self.task_unreachable[result._host.get_name()] = result

    def v2_runner_on_skipped(self, result):
        self.task_ok[result._host.get_name()]  = result

    def v2_playbook_on_stats(self, stats):
        hosts = sorted(stats.processed.keys())
        for h in hosts:
            t = stats.summarize(h)
            self.task_status[h] = {
                                       "ok":t['ok'],
                                       "changed" : t['changed'],
                                       "unreachable":t['unreachable'],
                                       "skipped":t['skipped'],
                                       "failed":t['failures']
                                   }

class ANSRunner(object):
    """
    This is a General object for parallel execute modules.
    """
    def __init__(self,resource,redisKey=None,logId=None,*args, **kwargs):
        self.resource = resource
        self.inventory = None
        self.variable_manager = None
        self.loader = None
        self.options = None
        self.passwords = None
        self.callback = None
        self.__initializeData()
        self.results_raw = {}
        self.redisKey = redisKey
        self.logId = logId


    def __initializeData(self):
        """ 初始化ansible """
        Options = namedtuple('Options', ['connection','module_path', 'forks', 'timeout',  'remote_user',
                'ask_pass', 'private_key_file', 'ssh_common_args', 'ssh_extra_args', 'sftp_extra_args',
                'scp_extra_args', 'become', 'become_method', 'become_user', 'ask_value_pass', 'verbosity',
                'check', 'listhosts', 'listtasks', 'listtags', 'syntax','diff'])

        self.loader = DataLoader()
        self.options = Options(connection='smart', module_path=None, forks=100, timeout=10,
                remote_user='root', ask_pass=False, private_key_file=None, ssh_common_args=None, ssh_extra_args=None,
                sftp_extra_args=None, scp_extra_args=None, become=None, become_method=None,
                become_user='root', ask_value_pass=False, verbosity=None, check=False, listhosts=False,
                listtasks=False, listtags=False, syntax=False, diff=True)

        self.passwords = dict(sshpass=None, becomepass=None)
        myinvent = MyInventory(self.resource, self.loader, self.variable_manager)
        self.inventory = myinvent.inventory
        self.variable_manager = myinvent.variable_manager

        # self.variable_manager.set_inventory(self.inventory)
        # self.variable_manager = VariableManager(loader=self.loader, inventory=self.inventory)

    def run_model(self, host_list, module_name, module_args):
        """
        run module from andible ad-hoc.
        module_name: ansible module_name
        module_args: ansible module args
        """
        play_source = dict(
                name="Ansible Play",
                hosts=host_list,
                gather_facts='no',
                tasks=[dict(action=dict(module=module_name, args=module_args))]
        )

        play = Play().load(play_source, variable_manager=self.variable_manager, loader=self.loader)
        tqm = None
        # if self.redisKey:self.callback = ModelResultsCollectorToSave(self.redisKey,self.logId)
        # else:self.callback = ModelResultsCollector()
        self.callback = ModelResultsCollector()
        import traceback
        try:
            tqm = TaskQueueManager(
                    inventory=self.inventory,
                    variable_manager=self.variable_manager,
                    loader=self.loader,
                    options=self.options,
                    passwords=self.passwords,
                    stdout_callback = "minimal",
            )
            tqm._stdout_callback = self.callback
            constants.HOST_KEY_CHECKING = False #关闭第一次使用ansible连接客户端是输入命令
            tqm.run(play)
        except Exception as err:
            print traceback.print_exc()
            # DsRedis.OpsAnsibleModel.lpush(self.redisKey,data=err)
            # if self.logId:AnsibleSaveResult.Model.insert(self.logId, err)
        finally:
            if tqm is not None:
                tqm.cleanup()

    def run_playbook(self, playbook_path,extra_vars=None):
        """
        run ansible palybook
        """
        try:
            # if self.redisKey:self.callback = PlayBookResultsCollectorToSave(self.redisKey,self.logId)
            self.callback = PlayBookResultsCollector()
            if extra_vars:self.variable_manager.extra_vars = extra_vars
            executor = PlaybookExecutor(
                playbooks=[playbook_path], inventory=self.inventory, variable_manager=self.variable_manager, loader=self.loader,
                options=self.options, passwords=self.passwords,
            )
            executor._tqm._stdout_callback = self.callback
            constants.HOST_KEY_CHECKING = False #关闭第一次使用ansible连接客户端是输入命令
            executor.run()
        except Exception as err:
            return False

    def get_model_result(self):
        self.results_raw = {'success':{}, 'failed':{}, 'unreachable':{}}
        for host, result in self.callback.host_ok.items():
            hostvisiable = host.replace('.','_')
            self.results_raw['success'][hostvisiable] = result._result


        for host, result in self.callback.host_failed.items():
            hostvisiable = host.replace('.','_')
            self.results_raw['failed'][hostvisiable] = result._result


        for host, result in self.callback.host_unreachable.items():
            hostvisiable = host.replace('.','_')
            self.results_raw['unreachable'][hostvisiable]= result._result

        # return json.dumps(self.results_raw)
        return self.results_raw

    def get_playbook_result(self):
        self.results_raw = {'skipped':{}, 'failed':{}, 'ok':{},"status":{},'unreachable':{},"changed":{}}
        for host, result in self.callback.task_ok.items():
            self.results_raw['ok'][host] = result

        for host, result in self.callback.task_failed.items():
            self.results_raw['failed'][host] = result

        for host, result in self.callback.task_status.items():
            self.results_raw['status'][host] = result

        # for host, result in self.callback.task_changed.items():
        #     self.results_raw['changed'][host] = result

        for host, result in self.callback.task_skipped.items():
            self.results_raw['skipped'][host] = result

        for host, result in self.callback.task_unreachable.items():
            self.results_raw['unreachable'][host] = result
        return self.results_raw


if __name__ == '__main__':
    # resource = [
    #              {"hostname": "192.168.8.119"},
    #              # {"hostname": "192.168.6.43"},
    #              # {"hostname": "192.168.1.233"},
    #              ]
    resource =  {
                    "dynamic_host": {
                        "hosts": [
                                    {'username': u'root', 'password': '123456', 'ip': '192.168.1.108','hostname':'nginx01','port':'22'},
                                    {"hostname":"778da6afsdwf","ip": "192.168.1.109", "port": "22", "username": "root", "password":"123456"},
                                  ],
                        "vars": {
                                 "var1":"ansible",
                                 "var2":"saltstack"
                                 }
                    }
                }
    rbt = ANSRunner(resource,redisKey='1')
    # Ansible Adhoc
    rbt.run_model(host_list=['778da6a023b7','248dbc0fblj40e','testoae'],module_name='shell',module_args="ls /tmp")
    data = rbt.get_model_result()
    # Ansible playbook
    # rbt.run_playbook(playbook_path='/etc/ansible/playbook/OPUSE.yml')
    # print rbt.get_playbook_result()
    # rbt.run_model(host_list=[],module_name='yum',module_args="name=htop state=present")
