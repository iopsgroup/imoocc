# coding=utf-8
import datetime
from hashlib import sha1
from django.shortcuts import render, redirect
from .models import UserInfo


def register(request):
    context = {'title': '注册'}
    return render(request, 'users/register.html', context=context)


def login(request):
    context = {'title': '登录'}
    return render(request, 'users/login.html', context=context)


def login_haddle(request):
    post = request.POST
    user_name = post.get('user_name')
    user_passwd = post.get('user_passwd')
    remember_uname = post.get('remember_uname', '0')
    passwd_sha1 = sha1()
    passwd_sha1.update(user_passwd)
    user_passwd_sha1 = passwd_sha1.hexdigest()
    user_names = UserInfo.objects.filter(user_name=user_name)
    context = {'title': '登录', 'user_name': user_name, 'user_passwd': user_passwd}
    if len(user_names) >= 1:
        if user_names[0].user_passwd == user_passwd_sha1:
            request.session['uid'] = user_names[0].id
            request.session['user_name'] = user_name
            request.session['user_level'] = user_names[0].user_level
            path = request.session.get('path', '/')
            response = redirect(path)
            if remember_uname == '1':
                response.set_cookie('user_name', user_name,
                                    expires=(datetime.datetime.now()+datetime.timedelta(days=7)))
            else:
                response.set_cookie('user_name', '', max_age=-1)
            return response
        else:
            context['error_passwd'] = '1'
            return render(request, 'users/login.html', context)
    else:
        context['error_name'] = '1'
        return render(request, 'users/login.html', context)


def logout(request):
    request.session.flush()
    return redirect('/user/login/')
