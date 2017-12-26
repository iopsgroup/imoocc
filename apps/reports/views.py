# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.shortcuts import render


def base(request):
    return render(request, 'base.html', {})


def report(request):
    context = {'title': '报表平台'}
    return render(request, 'reports/report.html', context)


def histogram(request):
    """柱状图"""
    context = {'title': '柱状图'}
    return render(request, 'reports/histogram.html', context)


def rack(request):
    """机柜布置图"""
    context = {'title': '机柜布置图'}
    return render(request, 'reports/rack.html', context)
