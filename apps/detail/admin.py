from django.contrib import admin
from .models import *
# import xadmin


class PhysicalServerInfoAdmin(admin.ModelAdmin):
    list_display = ['id', 'system_ver', 'machine_brand']

admin.site.register(PhysicalServerInfo, PhysicalServerInfoAdmin)