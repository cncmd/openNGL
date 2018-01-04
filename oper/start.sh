#!/bin/bash
BASE_JAR_DIR=/home/admin/jars
TARGET_JAR=$1
NGINX_START_PATH=/home/admin/nginx-clojure-0.4.5/
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
#worker
RET=`ps -ef | grep nginx | grep -v grep | grep nobody | awk '{print($2)}'`

if [ "$RET" == "" ] ; then 
    cd $NGINX_START_PATH &&  ./nginx
else
    MASTER=`ps -ef | grep nginx | grep -v grep | grep nobody | awk '{print($3)}'`    
    if [ "$MASTER" == "" ] ; then 
      cd $NGINX_START_PATH &&  ./nginx
      exit 0
    fi
    cd $NGINX_START_PATH && ./nginx -s reload	
fi
exit 0
