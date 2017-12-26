from django.conf.urls import include, url
from django.contrib import admin
from taskdo.views import *

urlpatterns = [
    url(r'^adhocdo/',adhoc_task),
    url(r'^adhoclog',adhoc_task_log)
]
