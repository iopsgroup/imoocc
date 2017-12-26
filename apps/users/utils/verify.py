# -*- coding:utf-8 -*-
from django.shortcuts import redirect
from django.http import HttpResponse


def login(func):
    def wrapped(request, *args, **kwargs):
        if request.session.get('uid'):
            return func(request, *args, **kwargs)
        else:
            return redirect('/user/login/')
    return wrapped


def level(func):
    def wrapped(request, *args, **kwargs):
        if request.session['user_level'] == '0':
            return HttpResponse('您无权访问此页面！')
        else:
            return func(request, *args, **kwargs)
    return wrapped
