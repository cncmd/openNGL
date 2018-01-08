#!/usr/bin/env /home/tops/bin/python
# -*- coding: utf-8 -*-
# Author: Ke Jie <jinxi.kj@taobao.com>
# Copyright (C) taobao.com 2013

''' Buc SSO
'''

import sys
import json
import urlparse

import tornado.auth
import tornado.escape
import tornado.httpserver
import tornado.ioloop
import tornado.web
from tornado import gen

import bucsso

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r'/', MainHandler),
            (r'/profile.json', ProfileHandler),
            (r'/auth/login', AuthHandler),
            (r'/sendBucSSOToken.do', AuthHandler),
            (r'/auth/logout', LogoutHandler),
        ]
        settings = dict(
            cookie_secret='__TODO:_GENERATE_YOUR_OWN_RANDOM_VALUE_HERE__',
            login_url='/auth/login',
            debug=True,
        )
        tornado.web.Application.__init__(self, handlers, **settings)


class BaseHandler(tornado.web.RequestHandler):
    def get_current_user(self):
        user_json = self.get_secure_cookie('authdemo_user')
        if not user_json: return None
        return tornado.escape.json_decode(user_json)


class MainHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        name = tornado.escape.xhtml_escape(self.current_user['name'])
        self.write('Hello, ' + name)
        self.write('<br><br><a href="/profile.json" target="_blank">profile.json</a>')
        self.write('<br><br><a href="/auth/logout">Log out</a>')


class ProfileHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        user_json = json.dumps(self.current_user)
        self.set_header('Content-Type', 'application/json')
        self.write(user_json)


class AuthHandler(BaseHandler, bucsso.BucAuthHandler):
    APP_NAME = 'nessus'     # replace 'nessus' to your app_name
    @tornado.web.asynchronous
    @gen.coroutine
    def get(self):
        if self.request.uri.startswith('/sendBucSSOToken.do'):
            token = self.get_argument('SSO_TOKEN')
            next = self.get_argument('BACK_URL')
            user = yield self.get_authenticated_user(token)
            self.set_secure_cookie('authdemo_user',
                    tornado.escape.json_encode(user))
            self.redirect(next)
        else:
            back_url = urlparse.urljoin(self.request.full_url(), self.get_argument('next', '/'))
            self.authenticate_redirect(app_name=self.APP_NAME, next=back_url)


class LogoutHandler(BaseHandler):
    def get(self):
        # This logs the user out of this demo app, but does not log them
        # out of Google.  Since Google remembers previous authorizations,
        # returning to this app will log them back in immediately with no
        # interaction (unless they have separately logged out of Google in
        # the meantime).
        self.clear_cookie('authdemo_user')
        self.write('You are now logged out. '
                   'Click <a href="/">here</a> to log back in.')


def main():
    from tornado.options import define, options, parse_command_line
    define('port', default=8888, help='run on the given port', type=int)

    bucsso.BucAuthHandler.register(name='nessus')

    parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()


if __name__ == '__main__':
    main()
