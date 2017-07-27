1、进入到users目录
cd /var/lib/AccountsService/users

2、建立需要隐藏的用户如：mysql
touch mysql
3、在mysql文件中添加两句 vim mysql
[User]
SystemAccount=true
4、保存并重启电脑，再次开机就不会有烦人的其他用户了。
