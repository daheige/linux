```
php非阻塞模式
非阻塞模式是指利用socket事件的消息机制，Server端与Client端之间的通信处于异步状态。
让PHP不再阻塞当PHP作为后端处理需要完成一些长时间处理，为了快速响应页面请求，不作结果返回判断的情况下，可以有如下措施：
一、若你使用的是FastCGI模式，使用fastcgi_finish_request()能马上结束会话，但PHP线程继续在跑。
    echo "program start.";
    file_put_contents('log.txt','start-time:'.date('Y-m-d H:i:s'), FILE_APPEND);
    fastcgi_finish_request();
    sleep(1);
    echo 'debug...';
    file_put_contents('log.txt', 'start-proceed:'.date('Y-m-d H:i:s'), FILE_APPEND);
    sleep(10);
    file_put_contents('log.txt', 'end-time:'.date('Y-m-d H:i:s'), FILE_APPEND);
    这个例子输出结果可看到输出program start.后会话就返回了，所以debug那个输出浏览器是接收不到的，而log.txt文件能完整接收到三个完成时间。
二、使用fsockopen、cUrl的非阻塞模式请求另外的网址
    $fp = fsockopen("www.example.com", 80, $errno, $errstr, 30);
    if (!$fp) die('error fsockopen');
    stream_set_blocking($fp,0);
    $http = "GET /save.php / HTTP/1.1\r\n"; 
    $http .= "Host: www.example.com\r\n"; 
    $http .= "Connection: Close\r\n\r\n";
    fwrite($fp,$http);
    fclose($fp);
    可以参考thinkphp3.2中的http工具类

    利用cURL中的curl_multi_*函数发送异步请求
        $cmh = curl_multi_init();
        $ch1 = curl_init();
        curl_setopt($ch1, CURLOPT_URL, "http://localhost:6666/child.php");
        curl_multi_add_handle($cmh, $ch1);
        curl_multi_exec($cmh, $active);
        echo "End\n";
三、使用Gearman、Swoole扩展
    Gearman是一个具有php扩展的分布式异步处理框架，能处理大批量异步任务；
    Swoole最近很火，有很多异步方法，使用简单。(尘缘注：号称重新定义PHP，把NodeJS喷得体无完肤。Swoole工具虽好，却感觉是扩展本身跟NodeJS没可比性)
四、使用redis等缓存、队列，将数据写入缓存，使用后台计划任务实现数据异步处理
    这个方法在常见的大流量架构中应该很常见
五、极端的情况下，可以调用系统命令，可以将数据传给后台任务执行，个人感觉不是很高效。
    $cmd = 'nohup php ./processd.php $someVar >/dev/null &';
    `$cmd`
六、采用yield控制异步流程的实现
    参考：http://nikic.github.io/2012/12/22/Cooperative-multitasking-using-coroutines-in-PHP.html
七、安装pcntl扩展，使用pcntl_fork生成子进程异步执行任务，个人觉得是最方便的，但也容易出现zombie process（僵死进程）
    if (($pid = pcntl_fork()) == 0) {
        child_func(); //子进程函数，主进程运行
    } else {
        father_func(); //主进程函数
    }
    echo "Process " . getmypid() . " get to the end.\n";
    
    function father_func() {
        echo "Father pid is " . getmypid() . "\n";
    }
    function child_func() {
        sleep(6);
        echo "Child process exit pid is " . getmypid() . "\n";
        exit(0);
    }
```
