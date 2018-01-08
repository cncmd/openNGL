#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: Ke Jie <jinxi.kj@taobao.com>
# Copyright (C) taobao.com 2013

''' Buc SSO
http://docs.alibaba-inc.com/pages/viewpage.action?pageId=98078830
'''

import os
import sys
import urllib
import urllib2
import json

import tornado.concurrent
import tornado.httpclient


class AuthError(Exception):
    pass


class BucAuthHandler(object):
    '''
    1) register
       BucAuthHandler.register(name='xxx')  # replace 'xxx' to real app_name
    2) login
       a) login redirect
          use authenticate_redirect(app_name='xxx', next='http://sample.com/some/path')
       b) login callback (return of authenticate_redirect)
          get_authenticated_user(token)
    '''
    REGISTER_URL = 'https://login-test.alibaba-inc.com/updateAppVersion.do'
    LOGIN_URL = 'https://login-test.alibaba-inc.com/ssoLogin.htm'
    COMMUNICATE_URL = 'https://login-test.alibaba-inc.com/rpc/sso/communicate.json'
    CLIENT_VERSION = '0.3.6'
    @classmethod
    def register(self, name='demo', timeout=10):
        args = {
                'APP_NAME': name,
                'CLIENT_VERSION': BucAuthHandler.CLIENT_VERSION
                }
        fp = urllib2.urlopen(BucAuthHandler.REGISTER_URL,
                data=urllib.urlencode(args),
                timeout=timeout)
        response = fp.read()
        fp.close()
        return True

    def authenticate_redirect(self, app_name, next, callback=None):
        args = {
                'APP_NAME': app_name,
                'BACK_URL': next,
                }
        self.redirect(self.LOGIN_URL + '?' + urllib.urlencode(args))

    @tornado.concurrent.return_future
    def get_authenticated_user(self, token, callback):
        http = self.get_auth_http_client()
        args = {
                'SSO_TOKEN': token,
                'RETURN_USER': 'true',
                }

        def on_auth(callback, response):
            user = {}
            result = json.loads(response.body)
            if not result[u'hasError']:
                user = json.loads(result['content'])
                user = self.normalize_user(user)
            else:
                raise AuthError(result.get('content'))
            callback(user)

        http.fetch(self.COMMUNICATE_URL,
                self.async_callback(on_auth, callback),
                method='POST',
                body=urllib.urlencode(args))

    def normalize_user(self, user):
        result = {}
        for key in ('nickNameCn', 'tbWW'):
            if result.get('name'):
                break
            result['name'] = user.get(key)

        for key in ('emailAddr', 'account'):
            if result.get('email'):
                break
            result['email'] = user.get(key)

        result['realname'] = user.get('lastName')
        result['token'] = user.get('token')
        result['id'] = int(user.get('empId'))
        result['department'] = user.get('depDesc')
        return result

    def get_auth_http_client(self):
        return tornado.httpclient.AsyncHTTPClient()

def main():
    ''' main function
    '''
    print 'Done'

if __name__ == '__main__':
    main()
