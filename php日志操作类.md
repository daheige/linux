```
<?php
/**
 * 日志处理类
 * author: heige
 * time: 2018-01-09 23:29
 */
class Log
{
                                      // 日志级别 从上到下，由低到高
    const EMERG            = 'EMERG'; // 严重错误: 导致系统崩溃无法使用
    const ALERT            = 'ALERT'; // 警戒性错误: 必须被立即修改的错误
    const CRIT             = 'CRIT';  // 临界值错误: 超过临界值的错误，例如一天24小时，而输入的是25小时这样
    const ERR              = 'ERR';   // 一般错误: 一般性错误
    const WARN             = 'WARN';  // 警告性错误: 需要发出警告的错误
    const NOTICE           = 'NOTIC'; // 通知: 程序可以运行但是还不够完美的错误
    const INFO             = 'INFO';  // 信息: 程序输出信息
    const DEBUG            = 'DEBUG'; // 调试: 调试信息
    const SQL              = 'SQL';   // SQL：SQL语句 注意只在调试模式开启时有效
    private static $config = [
        'time_format' => 'Y-m-d H:i:s',
        'file_size'   => 2097152, //每个日志大小为2MB
    ];

    public static function info($message, $filename = '')
    {
        self::write($message, self::INFO, $filename);
    }

    public static function notice($message, $filename = '')
    {
        self::write($message, self::NOTICE, $filename);
    }

    public static function warn($message, $filename = '')
    {
        self::write($message, self::WARN, $filename);
    }

    public static function error($message, $filename = '')
    {
        self::write($message, self::ERR, $filename);
    }

    /**
     * 写入日志到文件
     * @static
     * @access protected
     * @param  string $message     日志信息
     * @param  string $level       日志级别
     * @param  string $destination 写入目标
     * @return void
     */
    protected static function write($message, $level = self::ERR, $destination = '')
    {
        $destination = LOG_PATH . '/' . $level . '/' . date('y_m_d') . '/' . (empty($destination) ? 'common' : $destination) . '.log';
        self::save(is_string($message) ? $message : json_encode($message, JSON_UNESCAPED_UNICODE), $destination);
    }

    /**
     * 日志写入接口
     * @access public
     * @param  string $log         日志信息
     * @param  string $destination 写入目标
     * @return void
     */
    public static function save($log, $destination = '')
    {
        date_default_timezone_set('Asia/Shanghai');
        $now = date(self::$config['time_format']);
        if (empty($destination)) {
            $destination = LOG_PATH . '/' . date('y_m_d') . '.log';
        }

        // 自动创建日志目录
        $log_dir = dirname($destination);
        if (!is_dir($log_dir)) {
            mkdir($log_dir, 0755, true);
        }
        //检测日志文件大小，超过配置大小则备份日志文件重新生成
        if (is_file($destination) && floor(self::$config['file_size']) <= filesize($destination)) {
            rename($destination, dirname($destination) . '/' . time() . '-' . basename($destination));
        }

        if (isset($_SERVER['REQUEST_URI'])) {
            $str = "[{$now}] " . $_SERVER['REMOTE_ADDR'] . ' ' . $_SERVER['REQUEST_URI'] . PHP_EOL . $log . PHP_EOL;
        } else {
            $str = "[{$now}] " . PHP_EOL . $log . PHP_EOL;
        }

        error_log($str, 3, $destination);
    }

    //错误处理
    public static function errorHandler($errno, $errstr, $errfile, $errline)
    {

        $arr[] = 'errno: ' . $errno;
        $arr[] = 'errfile: ' . $errfile;
        $arr[] = 'errline: ' . $errline;
        $arr[] = 'errMessage: ' . $errstr;
        self::info(implode(PHP_EOL, $arr), 'common_error');
    }

    //获取 fatal error register_shutdown_function("Log::fatalHandler");
    public static function fatalHandler()
    {
        $error   = error_get_last();
        $errType = E_ERROR | E_USER_ERROR | E_CORE_ERROR | E_COMPILE_ERROR | E_RECOVERABLE_ERROR | E_PARSE;
        if ($error && ($error["type"] === ($error["type"] & $errType))) {
            $arr[] = 'errno: ' . $error["type"];
            $arr[] = 'errfile: ' . $error["file"];
            $arr[] = 'errline: ' . $error["line"];
            $arr[] = 'errMessage: ' . $error["message"];
            self::info(implode(PHP_EOL, $arr), 'fatal_error');
        }
    }
    
}

//请根据需要改变
define('LOG_PATH', __DIR__ . '/log');
register_shutdown_function("Log::fatalHandler");
set_error_handler("Log::errorHandler", E_ALL | E_STRICT);
Log::info($arr, 'test');
```
