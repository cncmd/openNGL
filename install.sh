#!/bin/bash
#============================
export LUAJIT_LIB=/usr/local/openresty/luajit/lib/
export LUAJIT_INC=/usr/local/openresty/luajit/include/luajit-2.0/
export LUA_LIB=/usr/local/openresty/lualib/
export PATH=$PATH:/home/admin/groovy/groovy-2.6.0-alpha-2/bin


OPENNGL_INSTALL_PATH=`pwd`
OPENNGL_HOME=/home/admin/
OPENNGL_NGX_GR=$OPENNGL_HOME/nginx
OPENNGL_NGX_RESTY_LIB=/usr/local/openresty/lualib/resty/

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

mkdir -p $OPENNGL_HOME/jars
mkdir -p $OPENNGL_HOME/groovy
mkdir -p $OPENNGL_HOME/lua
mkdir -p $OPENNGL_HOME/oper
mkdir -p $OPENNGL_HOME/nginx

#=============Groovy==================
TARGET=$OPENNGL_INSTALL_PATH/nginx/groovy.zip
cp -f $TARGET $OPENNGL_HOME/groovy
cd $OPENNGL_HOME/groovy && unzip *.zip
echo "groovy install"
LIB_DIR=$OPENNGL_HOME/groovy/groovy-2.6.0-alpha-2/lib/
cp -f $OPENNGL_INSTALL_PATH/jars/*  $LIB_DIR
cp -f $OPENNGL_INSTALL_PATH/lua/*  $OPENNGL_HOME/lua
cp -f $OPENNGL_INSTALL_PATH/oper/* $OPENNGL_HOME
echo "groovy lib install"

#=============Nginx===================
TARGET=$OPENNGL_INSTALL_PATH/nginx/nginx.tar.gz
cp -f $TARGET $OPENNGL_HOME/nginx/ 
cd $OPENNGL_HOME/nginx/ &&  tar zxf nginx.tar.gz 
mv $OPENNGL_HOME/nginx/nginx-* $OPENNGL_HOME/nginx/nginx -f 
echo "nginx install"
#=============Conf=====================
cp -f $OPENNGL_INSTALL_PATH/conf/nginx.conf $OPENNGL_HOME/nginx/nginx/conf/
#=============Start====================
cd  $OPENNGL_HOME && nohup groovy pubdaemon.groovy &












