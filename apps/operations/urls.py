# -*- coding:utf-8 -*-
from django.conf.urls import url
from operations import views


urlpatterns = [
    url(r'^state_handdle/$', views.state_handdle),
]