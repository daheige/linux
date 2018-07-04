```
安装GTK库
首先确保您的电脑已经安装了GTK库 执行和如下命令可以查看电脑上是否安装了GTK <br/>
1、查看是否安装GTK
pkg-config --modversion gtk+ (查看1.2.x版本)
pkg-config --modversion gtk+-2.0 (查看 2.x 版本)
pkg-config --version (查看pkg-config的版本)
pkg-config --list-all grep gtk (查看是否安装了gtk)

2、如果没有安装，请安装GTK库 
或者执行如下命令安装GTK基本库就行<br/>
sudo apt-get install libgtk2.0-dev

3、编译动态库 
# cd ~ 
# vim sublime_imfix.c 内容如下： 
#include <gtk/gtkimcontext.h>

void gtk_im_context_set_client_window(GtkIMContext *context,

                                      GdkWindow *window)

{

    GtkIMContextClass *klass;

    g_return_if_fail(GTK_IS_IM_CONTEXT(context));

    klass = GTK_IM_CONTEXT_GET_CLASS(context);

    if (klass->set_client_window)

        klass->set_client_window(context, window);

    g_object_set_data(G_OBJECT(context), "window", window);

    if (!GDK_IS_WINDOW(window))

        return;

    int width = gdk_window_get_width(window);

    int height = gdk_window_get_height(window);

    if (width != 0 && height != 0)

        gtk_im_context_focus_in(context);
}

:wq保存到～下

4、编译成共享库
gcc -shared -o libsublime-imfix.so sublime_imfix.c  `pkg-config --libs --cflags gtk+-2.0` -fPIC
拷贝到/opt/sublime_text目录下

sudo cp libsublime-imfix.so /opt/sublime_text/libsublime-imfix.so

注意：/opt/sublime_text/不同版本可能有所不同，请调整为自己安装版本的路径 
修改/usr/bin/subl文件，在第一行加入：

export LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so

5、修改sublime-text.desktop
sudo rm -rf /usr/share/applications/sublime-text.desktop #删除原有的桌面方式
建立软连接
  sudo touch /opt/sublime_text/sublime-text.desktop
  sudo ln -s /opt/sublime_text/sublime-text.desktop /usr/share/applications/sublime-text.desktop
  sudo vim /opt/sublime_text/sublime-text.desktop

完整的sublime-text.desktop
[Desktop Entry]
Type=Application
Name=Sublime Text3
GenericName=Text Editor
Comment=SUblime Text3
#桌面快捷方式执行的命名
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text %F"
Terminal=false
MimeType=text/plain;
Icon=/opt/sublime_text/Icon/48x48/sublime-text.png
Categories=TextEditor;Development;
StartupNotify=true

[Desktop Action Window]
Name=New Window
Exec=/usr/bin/subl -n
OnlyShowIn=Unity;

[Desktop Action Document]
Name=New File
Exec=/usr/bin/subl --command new_file
OnlyShowIn=Unity;

进入/usr/share/applications/后，双击sublime-text.desktop就可以打开sublime,支持中文输入
对于个人的左边栏中需要出现sublime图标,只需要将上面双击后的sublime text3,右击固定到启动器就可以.
然后cd ~/.local/share/applications
修改sublime_text.desktop为如下内容:(注意Exec的内容)
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Name=Sublime Text3
Icon=sublime_text
Path=/
Exec=bash -c "LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so exec /opt/sublime_text/sublime_text %F"
StartupNotify=false
StartupWMClass=Sublime_text
OnlyShowIn=Unity;
X-UnityGenerated=true

这里我是建立了一个软连接sublime_text.desktop -> /opt/sublime_text/sublime-text.desktop
sudo ln -s /opt/sublime_text/sublime-text.desktop sublime_text.desktop

完成以上步骤之后,sublime text3就可以支持中文输入了.
```
