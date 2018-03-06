#!/bin/bash
#============================
export LUAJIT_LIB=/usr/local/openresty/luajit/lib/
export LUAJIT_INC=/usr/local/openresty/luajit/include/luajit-2.0/
export LUA_LIB=/usr/local/openresty/lualib/
export PATH=$PATH:/home/admin/groovy/groovy-2.6.0-alpha-2/bin
OPENNGL_INSTALL_PATH=`pwd`
OPENNGL_HOME=/home/admin/
OPENNGL_NGX_GR=$OPENNGL_HOME/nginx
OPENNGL_LUA_HOME=/usr/local/openresty/
OPENNGL_NGX_RESTY_LIB=$OPENNGL_LUA_HOME/lualib/resty/
#==========openresty==========
USER=`id | awk '{print(substr($2,5,1))}'`
if [ "$USER" == "0" ] ; then
	 echo  "please use root"
fi
OPEN_RESTY=`rpm -qa | grep openresty`
if [ $OPEN_RESTY == "" ] ; then
	rpm -i $OPENNGL_INSTALL_PATH/nginx/*.rpm
	echo "openresty install"
fi
#============mkdir ================
if [ ! -d  $OPENNGL_HOME ] ; then 
	mkdir -p $OPENNGL_HOME
	echo "work space install"
fi
mkdir -p $OPENNGL_HOME/{jars/build,groovy,lua,nginx,logs,bin}
mkdir -p /tmp/ngl/
#=============Groovy==================
TARGET=$OPENNGL_INSTALL_PATH/nginx/groovy.zip
cp -f $TARGET $OPENNGL_HOME/groovy
cd $OPENNGL_HOME/groovy && unzip *.zip
echo "groovy install"
LIB_DIR=$OPENNGL_HOME/groovy/groovy-2.6.0-alpha-2/lib/
cp -f $OPENNGL_INSTALL_PATH/jars/*  $LIB_DIR
cp -rf $OPENNGL_INSTALL_PATH/lua/*  $OPENNGL_HOME/lua
cp -rf $OPENNGL_INSTALL_PATH/lua/resty/* $OPENNGL_LUA_HOME/lualib/resty/
mv -f $OPENNGL_INSTALL_PATH/conf/nginx_lua.conf $OPENNGL_LUA_HOME/nginx/conf/nginx.conf
cp -f $OPENNGL_INSTALL_PATH/conf/nginx.conf $OPENNGL_HOME/nginx/nginx/conf/
cp -f $OPENNGL_INSTALL_PATH/oper/* $OPENNGL_HOME
echo "groovy lib install"
cp -f $OPENNGL_INSTALL_PATH/oper/ossutil64 $OPENNGL_HOME/bin
#=============Nginx===================
TARGET=$OPENNGL_INSTALL_PATH/nginx/nginx.tar.gz
cp -f $TARGET $OPENNGL_HOME/nginx/ 
cd $OPENNGL_HOME/nginx/ &&  tar zxf nginx.tar.gz 
mv -f $OPENNGL_HOME/nginx/nginx-* $OPENNGL_HOME/nginx/nginx 
cd $OPENNGL_HOME/nginx/nginx/
cp -f $OPENNGL_INSTALL_PATH/oper/*.jar $OPENNGL_HOME/jars/build
echo "nginx install"
cp -f $OPENNGL_INSTALL_PATH/oper/* $OPENNGL_HOME/  
#=============Start====================
#kill publish daemon
ps -ef |  grep -v grep| grep pubdaemon | awk '{system("kill -15 " $2 )}'
cd  $OPENNGL_HOME && nohup groovy pubdaemon.groovy &
cp $OPENNGL_HOME/com.agent.test.jar /tmp/com.agent.test.jar
OPENRESTY_DAEMON=`ps -ef | grep nginx | grep -v grep | grep sbin | awk '{print($2)}'`
if [ "$OPENRESTY_DAEMON" == "" ] ; then
	/usr/local/openresty/nginx/sbin/nginx 
else 
	/usr/local/openresty/nginx/sbin/nginx -s reload
fi
sh /home/admin/start.sh com.agent.test.jar
exit 0











