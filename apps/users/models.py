# -*- coding:utf-8 -*-
from django.db import models


# 登录系统的用户信息
class UserInfo(models.Model):
    STATUS_CHIOCE = (
        ('0', u'普通用户'),
        ('1', u'后台管理员'),
        ('2', u'超级管理员'),
    )
    user_name = models.CharField(max_length=15, verbose_name=u"用户名")
    user_passwd = models.CharField(max_length=40, verbose_name=u'密码')
    # 0-普通用户, 1-后台管理员, 2-超级管理员
    user_level = models.CharField(default='0', max_length=2, choices=STATUS_CHIOCE,
                                  verbose_name=u'用户权限等级')

    class Meta:
        verbose_name = u'注册用户表'
        verbose_name_plural = verbose_name
        db_table = "userinfo"
