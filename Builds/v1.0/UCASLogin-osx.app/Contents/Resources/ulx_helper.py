#!/usr/bin/python
# -*- coding:utf-8 -*-
# Author: Void Main
# Email: voidmain1313113#gmail.com
#
# Edited from `https://github.com/zhujinliang/cas_login`
import sys
import time
import urllib
import urllib2
import cookielib

RET_NORMAL = 0
RET_ERR_ARG = 1
RET_ERR_LOGIN = 2

ERROR_IP_EXISTS = "ip_exist_error"
USE_NET_NOT_START = 0
USE_NET_SUCCES = 1
USE_NET_IP_EXISTS = 2
USE_NET_ERROR = 3

RETRY_INTERVAL = 5

user_data = {
    "username": "",
    "password": "",
    "drop": "3",
    "type": "1",
    "n": "100"
}


def login():
    host_url = "http://auth.ucas.ac.cn"

    # 设置一个cookie处理器，负责从服务器下载cookie到本地，并且发送请求时带上本地cookie
    cj = cookielib.LWPCookieJar()
    cookie = urllib2.HTTPCookieProcessor(cj)
    opener = urllib2.build_opener(cookie, urllib2.HTTPHandler)
    urllib2.install_opener(opener)

    # 打开一个登录主页面
    opener.open(host_url)
    return opener


def use_net(opener, post_data):
    login_url = "http://auth.ucas.ac.cn/cgi-bin/do_login"
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:17.0) Gecko/20100101 Firefox/17.0',
        'Accept': 'pplication/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate',
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Referer': 'http://auth.ucas.ac.cn/'
    }

    # 给post数据编码
    post_data = urllib.urlencode(post_data)

    # 发送POST请求
    request = urllib2.Request(login_url, post_data, headers)
    try:
        response = opener.open(request)
        if response.read() == ERROR_IP_EXISTS:
            return USE_NET_IP_EXISTS
        else:
            return USE_NET_SUCCES
    except urllib2.URLError:
        return USE_NET_ERROR


def logout(opener, user_data):
    logout_url = 'http://auth.ucas.ac.cn/cgi-bin/do_logout'
    opener.open(logout_url)
    print '成功登出'


mode = {
    "1": "1",
    "2": "3",
    "3": "0"
}


display_mode = {
    "1": "城域",
    "2": "国内",
    "3": "国际"
}


usage = """\
Usage:
    To login to the system, you can provide `-login` as the second parameter, and following parameters
    ulx_worker.py -login [Network Type] -u [Your Student ID] -p [Your Login Password]

    Otherwise, to logout from the system, simply put `-logout` as the second parameter.
    ulx_worker.py -logout

Network Type:
    1: 连接城域
    2: 连接国内
    3: 连接国际
"""

if __name__ == "__main__":
    opener = login()
    if len(sys.argv) == 2 and sys.argv[1] == '-logout':
        logout(opener, user_data)
        sys.exit(RET_NORMAL)
    elif len(sys.argv) == 7 and sys.argv[1] == '-login':
        network_type = sys.argv[2]
        for i in range(3, 7, 2):  # From the 4th argument to start, and ends at the last parameter, each is a pair
            key, value = sys.argv[i:i + 2]
            if key == '-u':
                user_data['username'] = value
            elif key == '-p':
                user_data['password'] = "{TEXT}" + value

        # Validates the input
        if network_type in mode and len(user_data['username']) > 0 and len(user_data['password']) > 0:
            user_data["drop"] = network_type

            ret = USE_NET_NOT_START
            while ret != USE_NET_SUCCES:
                ret = use_net(opener, user_data)
                if ret == USE_NET_ERROR:
                    print '登陆异常'
                    sys.exit(RET_ERR_LOGIN)
                elif ret == USE_NET_IP_EXISTS:
                    # Sleep a while and wait for the while to retry
                    print 'IP仍然在线，' + str(RETRY_INTERVAL) + '秒后重试'
                    time.sleep(RETRY_INTERVAL)
                else:
                    break

            print '登陆成功'
            sys.exit(RET_NORMAL)

    # When arguments gots error, get here
    print usage
    sys.exit(RET_ERR_ARG)
