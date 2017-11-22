```
smb服务器搭建和配置
1、安装服务器
[root@localhost ~]# yum -y install samba
2、配置工作区
配置vim /etc/samba/smb.conf
找到workgroup 修改为workgroup = WORKGROUP
配置工作组权限
[WORKGROUP]
;描述
comment=workgroup smb
;共享路径
path=/home/workgroup
;是否公开目录
public=yes
writeable=yes
;不许游客访问
guest ok=no
;允许的网段
hosts allow=127. 192.168.1.
;允许浏览器查看
browseable=yes
3、添加用户到smb服务组（一般是存在的用户）
[root@localhost ~]# smbpasswd -a heige
New SMB password:
Retype new SMB password:
Added user heige.
4、改变/home/workgroup目录权限
查看组heige
[root@localhost ~]# id heige
uid=500(heige) gid=500(heige) 组=500(heige)
[root@localhost ~]# chown -R heige. /home/workgroup
chown: 无法访问"/home/workgroup": 没有那个文件或目录
[root@localhost ~]# mkdir /home/workgroup
[root@localhost ~]# chown -R heige. /home/workgroup
设置权限
[root@localhost ~]# chmod 777 /home/workgroup/
5、设置防火墙端口
[root@localhost ~]# vim /etc/sysconfig/iptables
新增如下端口在22下面一行（一些常见的端口22,80,3306建议开启）
-A INPUT -m state --state NEW -m tcp -p tcp --dport 138 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 139 -j ACCEPT
6、重启服务器防火墙
[root@localhost ~]# service iptables restart
iptables：将链设置为政策 ACCEPT：filter                    [确定]
iptables：清除防火墙规则：                                 [确定]
iptables：正在卸载模块：                                   [确定]
iptables：应用防火墙规则：                                 [确定]
7、加入开机启动
[root@localhost ~]# chkconfig smb on

使用：
在window下资源管理下输入：\\192.168.1.103

输入我们设置好的heige用户就可以连接，实现共享。

centos7配置smb
[share]
        comment= web
        path=/web
        public=yes
        writeable=yes
        guest ok=yes
        browseable=yes

拓展配置：
配置smb的操作：
修改/etc/samba/smb.conf内容类似：
[global]
workgroup = LinuxSir
netbios name = LinuxSir05
server string = Linux Samba Server TestServer
security = share
[linuxsir]
        path = /opt/linuxsir
        writeable = yes
        browseable = yes
        guest ok = yes
完成后，为了保证有足够的权限访问，运行如下命令：
[root@localhost ~]# chown -R nobody:nobody your_smb_dir
查看smb服务是否启动：pgrep smbd
 
设置samba servie开机启动：
修改/etc/rc.loacl文件(增加红色部分)
[root@localhost ~]# cat /etc/rc.local 
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.
touch /var/lock/subsys/local
service smb restart
或者在/etc/profile的末尾加入也是可以的
补充：以下为转帖
在linux下如何把smb等服务加入开机启动：
方法一：
vi /etc/rc.d/rc.local
加入/usr/local/samba/sbin/smbd -D
/usr/local/samba/sbin/nmbd -D 
就可以了。
方法二：
chkconfig smb on
方法三：
ntsysv打开图形界面，找到samba选行确认即可
 
三种方法实现SAMBA服务随机启动
http://linux.chinaitlab.com/server/782125.html
     通过SAMBA服务器软件可以让Windows等非Linux客户端顺畅的访问Linux服务器上的共享资源。如果Linux服务器中设置了许多共享的资源(如Linux服务器是一台文件服务器)，为了让Windows客户端能够顺利访问这些共享资源，最好能够时时启动SAMBA服务，而不是在需要用到的时候才启用。要实现这个目的，最好的做法就是在Linux系统开机的时候自动启动SAMBA服务器，来节省每次手工启动的时间。而且，这也可以避免因为忘记启动而导致服务器停用这个服务而给其他客户端带来访问的故障。
　　在Linux系统中，要让SAMBA服务器随机启动有不少的实现方法。系统管理员可以根据自己的爱好以及专业背景来选择合适的实现方式。
　　方式一：利用ntsysv来配置。
　　在Windows操作系统中有一个MSCONFIG的小工具。利用这个工具可以对一些服务进行设置。如设置一些服务随机启动，让一些服务不随机启动等等。其实在Linux操作系统中也有类似的一个工具，即ntsysv。有关这个工具的说明大家可以利用man命令来查看。如下图所示：
   


    
     简单的说，ntsysv就是使用 newt 库的 SysV 风格的 runlevel 配置工具。它是Red Hat公司遵循GPL规则所开发的程序，它具有跟Msconfig类似的互动式操作界面。通过这个界面，系统管理员可以轻易地利用方向键和空格键等，开启、关闭操作系统在每个执行等级并设置系统的各种服务。不过可惜的是，到现在为止好像还不支持鼠标操作，需要通过键盘来实现相关的设置。ntsysv工具为激活或停运服务提供了简单的界面。系统管理员可以使用 ntsysv来启动或关闭由xinetd管理的服务，还可以使用 ntsysv 来配置运行级别。按照默认设置，只有当前运行级别会被配置。若要配置不同的运行级别，则需要使用 --level 选项来指定一个或多个运行级别。Ntsysv配置工具提供的交互式界面与文本模式下安装程序的工作方式类似。系统管理员可以使用上下箭头来上下查看列表，并使用空格键来选择或取消选择相关的服务;另外可以用来点击(回车键)确定和取消按钮来实现选择或者取消服务的目的。如果要在服务列表在确定、取消按钮中进行相互切换，则可以使用 Tab键。如果某项服务名字之前有*符号则表示这项服务被设置为启动。当系统管理员需要进一步了解这个服务的相关信息，则按F1帮助键会弹出每项服务的简短描述。
　　可见ntsysv因为其提供了一个图形化的配置工具，故是Linux系统管理员设置让SMB服务随机启动的一个首选。如果系统管理员需要利用这个工具来实现配置的话，操作也很简单。首先系统管理员需要在Linux的终端中输入“ntsysv”命令。然后系统会启动这个配置窗口。其次系统管理员要利用键盘上的上下键在列表中找到SMB这一个条目。找到后按空格键启用这项服务。注意按空格键后系统管理员要确保这服务的前面有一个*号。这个符号表示这个服务被设置为随机启动了。最后利用Tab键把光标移动到确定按钮，按回车键确定即可。虽然Ntsysv工具没有提供键盘支持，但是对于大部分Linux系统管理员来说，这可能已经司空见惯了，不会对他们造成多大的困扰。不过有些Linux系统的版本可能不支持这个工具，此时系统管理员可能就需要采取后续的几中方式来进行配置。
　　方式二：通过Chkconfig来设置SAMBA服务器随机启动。
　　Red Hat设计chkconfig的目的就是用来管理系统初始化的时候启动的服务。Chkconfig命令可以用来激活或者停用服务，也可以用来设置让某个服务随机启动。通常情况下，利用chkconfig --list命令后，系统管理员可以看到一个系统服务列表，还可以看到相关的运行级别。系统管理员还可以利用这个命令来查看每个运行级别是否自动运行SAMBA服务器。通常情况下，我们可以通过如下的命令来达到预计的目的。
　　Chkconfig –level 5 smb on
　　这个指令就表示入股哦系统运行Run level 5的级别时，就会自动启动SAMBA服务器。Chkconfig如果没有带参数运行时，则显示其用法。如果加上服务名，那么就检查这个服务是否在当前运行级启动。如果是则返回true，否则返回false。如果在服务名后面指定了on，off或者reset，那么chkconfi 会改变指定服务的启动信息。on和off分别指服务被启动和停止，reset指重置服务的启动信息。系统默认情况下on和off开关只对运行级3，4，5有效，但是reset可以对所有运行级有效。
     不过运行这个命令的时候，需要注意一个问题，即chkconfig指令并不是立即自动禁止或激活一个服务。它只是简单的改变了符号连接。另外这个命令的话到目前为止好像只有Red Hat的Linux系统具有。而像CentOS等了Linux操作系统则不支持这个命令。为此这个命令的应用也具有一定的局限性。像有些企业如果采用了CentOS版本的操作系统的话，则就需要后面笔者介绍的解决方式了。
　　方式三：通过服务配置设置SAMBA的自启动。
　　在Windows中，有一个“服务”配置窗口。在这个窗口中，系统管理员可以指定哪些服务自动启动，哪些服务手工启动，而那些服务又是被禁止启动的。Linux操作系统在设计的时候，也借鉴了这个图形化的管理工具。在Linux操作系统中，有“服务配置”窗口。系统管理员可以依次打开“主菜单”、“系统设置”、“服务器设置”、“服务”选项，然后系统就会打开一个服务配置窗口。在这个窗口的左面，系统管理员可以看到列出了相关的服务名字。如果系统管理员要让SAMBA服务自动启动的话，则知需要把这个服务前面的钩打上即可。配置完成之后，主要要保存相关的配置。在下次重新启动之后，这个服务就会被自动启动。
　　这个服务配置窗口基本上所有的Linux发行版本都具有。不过其适用方面也受到一定得限制。如只有在Linux服务器面前进行设置。而不能够通过SSH等远程方式进行维护。即使能够通过远程维护，也需要通过很多的设置才可以完成。
　　为此如果系统管理员采用的Linux系统支持以上三种方式的话，那么最好还是选择第二种方式。其虽然没有提供图形化的管理方式，但是毕竟只需要通过一个简单的命令就可以实现配置。系统管理员只要掌握chkconfig命令这个用户，那么配置起来应该不会遇到什么问题。而且最重要的是这个方式能够支持远程操作。也就是说系统管理员不用站到Linux服务器面前就可以操作了。如果系统管理员采用的Linux版本不支持这个Chkconfig命令的话，那么只要采用第一种与第三种设置方式了。第一种设置方式虽然不提供鼠标的支持，但是对于键盘等的支持非常好，而且设置起来的话也比较迅速。而第三种方式的话可以通过鼠标来操作，但是从打开到设置完成要比第一种方式要慢一点。另外第三种方式的话基本上所有Linux操作系统的发行版本都能够支持。
　　可见以上三种实现方式各有各的特点。Linux系统管理员需要根据自己所使用的Linux系统版本、所采取的管理方式(远程还是本地管理)、对命令的理解程度等等来选择合适的处理方式。若不考虑系统版本的话，我是建议大家采用第二种处理方式。如果第二种方式行不通的话，则使用第一种方式来设置。第三种处理方式是最后的选择。其实不仅是SAMBA服务，其他的应用服务也有类似的需求。如在Linux服务器上部署了Oracle数据库系统，也需要手工手工设定让其能够随机启动。为此Linux管理员掌握相关的配置是非常重要的。这个配置用处很大。


在配置Samba时,有时候碰到一些错误:
1. session setup failed: NT_STATUS_LOGON_FAILURE
原因: root账户没有添加到samba用户中
解决方法: smbpasswd -a root
```
