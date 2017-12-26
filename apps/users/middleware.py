# -*- coding:utf-8 -*-


class UrlMiddelware:

    def process_view(self, request, *args, **kwargs):
        if request.path not in [
            "/user/register/",
            "/user/login/",
            "/user/login_haddle/",
            "/user/logout",
            "/record/state_handdle/",
        ]:
            request.session['path'] = request.get_full_path()
