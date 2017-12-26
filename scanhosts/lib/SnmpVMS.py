#!/usr/bin/env python
# VMware vSphere Python SDK
# Copyright (c) 2008-2015 VMware, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
 
"""
Python program for listing the vms on an ESX / vCenter host
"""
 
from __future__ import print_function
from pyVim.connect import SmartConnect,Disconnect

import argparse
import atexit
import getpass
import ssl

class SnmpESXI():

    def __init__(self,host,port="443",user="",passwd=""):
        self.v_host = host
        self.v_port = port
        self.v_user = user
        self.v_pass = passwd


    def ReturnVmInfo(self,vm, depth=1):
        """
        Print information for a particular virtual machine or recurse into a folder
        with depth protection
        """
        result = {}
        maxdepth = 10

        # if this is a group it will have children. if it does, recurse into them
        # and then return
        if hasattr(vm, 'childEntity'):
            if depth > maxdepth:
                return
            vmList = vm.childEntity
            for c in vmList:
                self.ReturnVmInfo(c, depth+1)
            return

        summary = vm.summary
        v_uuid = summary.config.uuid
        result["uuid"]=v_uuid.split('-')[-1]
        result["name"]=summary.config.name
        return result



       # print("...............summary.uuid",summary.config.uuid)
       # print("Name       : ", summary.config.name)
       # print("Path       : ", summary.config.vmPathName)
       # print("Guest      : ", summary.config.guestFullName)
       # annotation = summary.config.annotation
       # if annotation != None and annotation != "":
       #    print("Annotation : ", annotation)
       # print("State      : ", summary.runtime.powerState)
       # if summary.guest != None:
       #    ip = summary.guest.ipAddress
       #    if ip != None and ip != "":
       #       print("IP         : ", ip)
       # if summary.runtime.question != None:
       #    print("Question  : ", summary.runtime.question.text)
       # print("")

    def dosnmp(self):
        """
        Simple command-line program for listing the virtual machines on a system.
        """
        if not self.v_host or not self.v_pass or not self.v_user:
            return ""

        context = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
        context.verify_mode = ssl.CERT_NONE
        si = SmartConnect(host=self.v_host,
                         user=self.v_user,
                         pwd=self.v_pass,
                         port=int(self.v_port),
                         sslContext=context)
        if not si:
            return ""

        atexit.register(Disconnect, si)

        content = si.RetrieveContent()
        result = []
        for child in content.rootFolder.childEntity:
            if hasattr(child, 'vmFolder'):
             datacenter = child
             vmFolder = datacenter.vmFolder
             vmList = vmFolder.childEntity
             for vm in vmList:
                item_res = self.ReturnVmInfo(vm)
                result.append(item_res)
        return result

def main():
    se = SnmpESXI(host="192.168.8.108",user="root",passwd="qwe123!@#")
    res = se.dosnmp()
    print("res...........",res)

if __name__ == "__main__":
   main()