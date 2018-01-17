#!/bin/bash
BASE_JAR_DIR=/home/admin/jars
TARGET_JAR=$1
NGINX_START_PATH=/home/admin/nginx/nginx
export LUAJIT_LIB=/usr/local/openresty/luajit/lib/
export LUAJIT_INC=/usr/local/openresty/luajit/include/luajit-2.0/
export LUA_LIB=/usr/local/openresty/lualib/
export PATH=$PATH:/home/admin/groovy/groovy-2.6.0-alpha-2/bin

#==================================================
if [ "" ==  "$TARGET_JAR" ] ; then 
  echo "params not enough"  
  exit 0
fi
if [ ! -d $BASE_JAR_DIR ] ; then
   mkdir -p "$BASE_JAR_DIR"
else
   rm -rf $BASE_JAR_DIR/*
fi
#====================================================
cp -f /tmp/$TARGET_JAR $BASE_JAR_DIR
cd $BASE_JAR_DIR && tar -zxf $TARGET_JAR
#重新启动服务
MASTER=`ps -ef | grep nginx | grep -v grep | grep nginx-linux-x64 | awk '{print($3)}'`    


[ ! "$MASTER" == "" ] && kill -15 $MASTER || echo "goto"

cd $NGINX_START_PATH && ./nginx-linux-x64	
exit 0
