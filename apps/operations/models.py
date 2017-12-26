# coding=utf-8
from django.db import models


class MachineOperationsInfo(models.Model):
    number = models.IntegerField(default=0, verbose_name=u'操作序号')
    person = models.CharField(default='', max_length=20, verbose_name=u'操作人用户名')
    time = models.DateTimeField(auto_now=True, auto_now_add=False, verbose_name=u'操作时间')
    sn_key = models.CharField(max_length=250, verbose_name=u'设备的唯一标识',unique=True)
    machine_type = models.CharField(max_length=20, verbose_name=u'设备类型')
    operation = models.TextField(default='', choices=((0, '增加'), (1, '删除'), (2, '修改')), verbose_name=u'操作内容')
    state = models.IntegerField(default=2, choices=((0, '已报废'), (1, '测试使用'), (2, '线上运行'), (3, '下线')),
                                verbose_name=u'设备使用状态')
    remark = models.TextField(default='', verbose_name=u'备注')

    class Meta:
        verbose_name = u'设备操作记录表'
        verbose_name_plural = verbose_name
        db_table = 'machineoperationsinfo'
