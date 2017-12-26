# -*- coding:utf-8 -*-
from .models import *
import xadmin
from xadmin import views


class UserInfoAdmin(object):
    list_display = ['user_name', 'user_passwd', 'user_level']
    search_fields = ['user_name', 'user_passwd', 'user_level']
    list_filter = ['user_name', 'user_passwd', 'user_level']


class BaseSettings(object):
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(object):
    site_title = '运维后台管理系统'
    site_bottom = 'IMOOCC'
    menu_style = 'accordion'


xadmin.site.register(UserInfo, UserInfoAdmin)
xadmin.site.register(views.BaseAdminView, BaseSettings)
xadmin.site.register(views.CommAdminView, GlobalSettings)
