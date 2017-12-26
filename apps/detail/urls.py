# coding=utf-8
from detail.utils import search
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index),
    url(r'^list/$', views.machine_list),
    url(r'^detail_(\w+)/$', views.detail),
    url(r'^classify/$', views.classify),
    url(r'^oth_detail/revalue/$', views.revalue),
    url(r'^search_(\w+)/$', search.search_list),
]

