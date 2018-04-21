```
1 centos6下修改hostname
复制代码
[root@centos6 ~]$ hostname                                              # 查看当前的hostnmae
centos6.magedu.com
[root@centos6 ~]$ vim /etc/sysconfig/network                            # 编辑network文件修改hostname行（重启生效）
[root@centos6 ~]$ cat /etc/sysconfig/network                            # 检查修改
NETWORKING=yes
HOSTNAME=centos66.magedu.com
[root@centos6 ~]$ hostname centos66.magedu.com                          # 设置当前的hostname(立即生效）
[root@centos6 ~]$ vim /etc/hosts                                        # 编辑hosts文件，给127.0.0.1添加hostname
[root@centos6 ~]$ cat /etc/hosts                                        # 检查
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4 centos66.magedu.com
::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
复制代码
2 centos7修改hostname
复制代码
[root@centos7 ~]$ hostnamectl set-hostname centos77.magedu.com             # 使用这个命令会立即生效且重启也生效
[root@centos7 ~]$ hostname                                                 # 查看下
centos77.magedu.com
[root@centos7 ~]$ vim /etc/hosts                                           # 编辑下hosts文件， 给127.0.0.1添加hostname
[root@centos7 ~]$ cat /etc/hosts                                           # 检查
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 centos77.magedu.com
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

3 重启reboot
```
