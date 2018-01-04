#!/bin/bash
OPENNGL_INSTALL_PATH=`pwd`
OPENNGL_HOME=/home/admin/
OPENNGL_NGX_GR=$OPENNGL_HOME/nginx

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
cd $OPENNGL_HOME/groovy && unzip $TARGET
echo "groovy install"
#=============Nginx===================
TARGET=$OPENNGL_INSTALL_PATH/nginx/nginx.tar.gz
cp -f $TARGET $OPENNGL_HOME 
cd $OPENNGL_HOME &&  tar zxf nginx.tar.gz 
mv $OPENNGL_HOME/nginx-* $OPENNGL_HOME/nginx
echo "nginx install"










