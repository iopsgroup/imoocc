# -*- coding: utf-8 -*-
import pymongo
from datetime import datetime
from admin.settings.settings import MONGO_HOST,MONGO_PORT,BASE_DIR
import yaml


class Mongodb(object):
    """Mongobd的CURD"""

    def __init__(self, db='iops', collection='tasklog'):
        self.client = pymongo.MongoClient(MONGO_HOST, int(MONGO_PORT))
        self.db = self.client[db]
        self.col = self.db[collection]

    def insert(self, content):
        return self.col.insert_one(content)

    def find_all(self):
        return self.col.find().sort([('createtime', -1)])


    def filter(self, keywords):
        result = []
        if keywords:
            logs = self.col.find({
                'taskid': keywords
            },{"_id":0}).sort([('time', 1)])
            for res in logs:
                result.append(res)
            print "...........................mongo",result,keywords
            return result
        else:
            return False


class InsertAdhocLog():
    '''记录日志'''
    def __init__(self,taskid):
        s_conf = yaml.load(file('%s/conf/taskdo.yml'%BASE_DIR))
        self.task_id = ""
        if taskid:
            self.task_id = int(taskid)
        else:
            return False
        self.map_id_log = s_conf["ansible_log"]["adhoc_format"]

    def record(self,id,input_con={}):
        if id not in self.map_id_log.keys():
            return False
        mg = Mongodb(collection='taskadhoclog')
        time = datetime.now()
        record_info = self.map_id_log[id] if self.map_id_log[id] else input_con
        content = {"taskid":self.task_id,"time":time,"id":id,"desc":record_info}
        print "........................insert content",content
        mg.insert(content)

    def getrecord(self):
        mg = Mongodb(collection='taskadhoclog')
        result = mg.filter(self.task_id)
        print "........................get result",result
        if result:
            return  result