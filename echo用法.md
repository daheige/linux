```
echo -e "abc\ndef"输出：abcdef-e表示启用解释反斜杠转义
默认为-E：禁用转义
echo本身默认最后会输出一个换行，要禁用最后的换行，可使用
echo -n "abc"
-n do not output the trailing newline
echo具体语法如下： Linux echo命令不能显示文件中的内容。
功能说明：显示文字。
语法：echo [-ne][字符串]或 echo [--help][--version]
参数：-n 不要在最后自动换行
-e 若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出： \a 发出警告声；
\b 删除前一个字符；
\c 最后不加上换行符号；
\f 换行但光标仍旧停留在原来的位置；
\n 换行且光标移至行首；
\r 光标移至行首，但不换行；
\t 插入tab；
\v 与\f相同；
```
