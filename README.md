# UCAS学校网络登陆助手 for OSX

*作者: VoidMain*

## 为什么要开发这个？
用一句话说明，现在的登陆方式弱爆了！每次登陆都要重新输入用户名和密码，提供的流量统计功能也形同虚设，用了一两次之后我就决定再也不用这东西了，后来我就一直使用网页版来帮助我上网。

但是网页版也有自己的缺陷，一不小心把页面关闭之后，我就得依靠“记忆”来摸索下线的那个页面了。所以我一直想做一个单独的Mac App，专门用来帮助UCAS的OSXer登陆校园网络。

为了做这个客户端需要做一些抓包之类的分析，上学期也没做，这学期开学第二天突然发现我班的[zhujinliang](https://github.com/zhujinliang)用python写了一个[登陆脚本](https://github.com/zhujinliang/cas_login)，试用之后发现非常好用，而且非常简洁，非常喜欢，所以突然心血来潮就做了这么一个项目。

## 设计理念
- 系统设计要简洁
- 该有的功能一定都要有，要可以登陆（并选择入口）、登出
- 同时不能影响用户体验，把所有的交互尽可能的隐蔽，不要干扰用户试用
- 多余的功能，如果简单可以加入，复杂的功能（比如抽取流量帐单之类的）直接把用户重定向到对应的网页

## 开发状态

- 2012.02.26，创建项目