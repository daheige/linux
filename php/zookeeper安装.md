```
一、安装libzookeeper

cd /usr/local/src/
wget http://mirror.bit.edu.cn/apache//zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz
tar -xf zookeeper-3.4.11.tar.gz
cd zookeeper-3.4.11/src/c
./configure --prefix=/usr/local/libzookeeper
make && make install

二、安装php zookeeper扩展
cd /usr/local/src/
wget http://pecl.php.net/get/zookeeper-0.4.0.tgz
tar zxvf zookeeper-0.4.0.tgz
cd zookeeper-0.4.0
phpize
./configure --with-php-config=/usr/local/php7/bin/php-config  --with-libzookeeper-dir=/usr/local/libzookeeper
make && make install
vim /usr/local/php/etc/php.ini
查找：extension_dir=”/usr/local/php7/lib/php/extensions/no-debug-non-zts-20100525/”
添加：extension=zookeeper.so
注意：php-config libzookeeper-di路径一定要正确,根据自己系统的安装路径判断。

三、扩展的使用

    // 获取单条配置
     $path      = '/' . trim($path, '/');
     $zookeeper = new \Zookeeper('address:2181');
     if ($zookeeper->exists($path)) {
         $value = $zookeeper->get($path);
     }
    
     //创建节点
     if (!$zookeeper->exists($path)) {
         $zookeeper->create($path, $value, array(array(
             'perms' => 31, 
             'scheme' => 'world', 
             'id' => 'anyone'
         )));
     }
        
     //更新节点
     if ($zookeeper->exists($path)) {
          $zookeeper->set($path, $value);
     } 
    
     //删除一个节点
     if ($zookeeper->exists($path)) {
         $zookeeper->delete($path);
     }
   
     //获取所有子节点名称
     if ($zookeeper->exists($path)) {
         $value = $zookeeper->getChildren($path);
     } 
     
     //获取acl
     if ($zookeeper->exists($path)) {
         $zookeeper->getAcl($path);
     }
    
     //设置acl
     if ($zookeeper->exists($path)) {
         $acl     = $zookeeper->getAcl($path);
         $version = isset($acl['0']['aversion']) ? $acl['0']['aversion'] : 0;
         $zookeeper->setAcl($path, $version, array(array(
             'perms' => 31, 
             'scheme' => 'world', 
             'id' => 'anyone'
         )));
     } 
```
