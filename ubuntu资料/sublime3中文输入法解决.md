安装GTK库 首先确保您的电脑已经安装了GTK库 执行和如下命令可以查看电脑上是否安装了GTK <br/>
#1、查看是否安装GTK
```
pkg-config --modversion gtk+ (查看1.2.x版本)
pkg-config --modversion gtk+-2.0 (查看 2.x 版本)
pkg-config --version (查看pkg-config的版本)
pkg-config --list-all grep gtk (查看是否安装了gtk)
```
2、如果没有安装，请安装GTK库 
或者执行如下命令安装GTK基本库就行<br/>
sudo apt-get install libgtk2.0-dev

3、编译动态库 
# cd ~ 
# vim sublime_imfix.c 内容如下： 
```
#include <gtk/gtkimcontext.h>

void 
gtk_im_context_set_client_window (
                                GtkIMContext *context,
                                GdkWindow    *window)
{
    GtkIMContextClass *klass;
    g_return_if_fail (GTK_IS_IM_CONTEXT (context));
    klass = GTK_IM_CONTEXT_GET_CLASS (context);

    if (klass->set_client_window)
    {
        klass->set_client_window (context, window);
    }
    g_object_set_data(G_OBJECT(context),"window",window);

    if(!GDK_IS_WINDOW (window))
    {
        return;
    }
    int width = gdk_window_get_width(window);
    int height = gdk_window_get_height(window);

    if(width != 0 && height !=0)
    {
        gtk_im_context_focus_in(context);
    }

    
}
```
:wq保存到～下

4、编译成共享库
```
gcc -shared -o libsublime-imfix.so sublime_imfix.c  `pkg-config --libs --cflags gtk+-2.0` -fPIC
```
拷贝到/opt/sublime_text目录下

sudo cp libsublime-imfix.so /opt/sublime_text/libsublime-imfix.so

注意：/opt/sublime_text/不同版本可能有所不同，请调整为自己安装版本的路径 
修改/usr/bin/subl文件，在第一行加入：

export LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so

5、修改sublime-text.desktop
sudo rm -rf /usr/share/applications/sublime-text.desktop #删除原有的桌面方式<br/>
建立软连接
sudo ln -s /opt/sublime_text/sublime_text.desktop /usr/share/applications/sublime-text.desktop
sudo vim /usr/share/applications/sublime_text.desktop
```
[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
#Exec=/opt/sublime_text/sublime_text %F 
Exec=/usr/bin/subl %F #需要修改的地方
Terminal=false
MimeType=text/plain;
Icon=sublime-text
Categories=TextEditor;Development;Utility;
StartupNotify=true
Actions=Window;Document;

X-Desktop-File-Install-Version=0.22

[Desktop Action Window]
Name=New Window
#Exec=/opt/sublime_text/sublime_text -n  #需要修改的地方
Exec=/usr/bin/subl -n
OnlyShowIn=Unity;

[Desktop Action Document]
Name=New File
#Exec=/opt/sublime_text/sublime_text --command new_file
Exec=/usr/bin/subl --command new_file #需要修改的地方
OnlyShowIn=Unity;

另外的方法：
为了使用鼠标右键打开文件时能够使用中文输入，还需要修改文件sublime_text.desktop的内容。
命令
sudo gedit /usr/share/applications/sublime_text.desktop
将[Desktop Entry]中的字符串
Exec=/opt/sublime_text/sublime_text %F
修改为
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text %F"
将[Desktop Action Window]中的字符串
Exec=/opt/sublime_text/sublime_text -n
修改为
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text -n"
将[Desktop Action Document]中的字符串
Exec=/opt/sublime_text/sublime_text --command new_file
修改为
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text --command new_file"
注意：
修改时请注意双引号"",否则会导致不能打开带有空格文件名的文件。
此处仅修改了/usr/share/applications/sublime-text.desktop，但可以正常使用了。
opt/sublime_text/目录下的sublime-text.desktop可以修改，也可不修改
```






