```
<?php
/**
 * [mbEncodeVal 编码自动转换为utf-8]
 * @param  [type]   $val      [val]
 * @return [string] [转换之后的字符串]
 */
function mbEncodeVal($val)
{
    if (empty($val)) {
        return '';
    }
    $enclist = [
        'Unicode', 'UTF-8', 'ASCII', 'GB2312', 'GBK', 'ISO-8859-1', 'ISO-8859-2', 'ISO-8859-3', 'ISO-8859-4', 'ISO-8859-5',
        'ISO-8859-6', 'ISO-8859-7', 'ISO-8859-8', 'ISO-8859-9', 'ISO-8859-10',
        'ISO-8859-13', 'ISO-8859-14', 'ISO-8859-15', 'ISO-8859-16',
        'Windows-1251', 'Windows-1252', 'Windows-1254',
    ];

    return mb_convert_encoding(trim($val), "UTF-8", $enclist);
};
//采用输入流的方式导出csv
function exportcsv(&$data = [], $header_data = [], $filename = '')
{
    $filename = ($filename ? $filename : 'export_' . date('YmdHis')) . ".csv";
    header("Content-Type: application/vnd.ms-excel");
    header("Content-Type: application/force-download");
    header("Content-Disposition: attachment; filename=" . $filename);
    header('Expires:0');
    header('Pragma:public');
    ob_start();
    $fp = fopen("php://output", 'w'); //写入流中
    fwrite($fp, chr(0xEF) . chr(0xBB) . chr(0xBF));
    if (!empty($header_data)) {
        $header_data = array_map('mbEncodeVal', $header_data);
        fputcsv($fp, $header_data);
    }

    //写入数据
    foreach ($data as $k => $v) {
        if (is_array($v)) {
            $v = array_map('mbEncodeVal', $v);
            fputcsv($fp, $v);
        } else if (is_string($v)) {
            fputcsv($fp, [mbEncodeVal($v)]);
        }
        unset($data[$k]);
    }
    fclose($fp);
    exit;
}
```
