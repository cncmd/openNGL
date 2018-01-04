#!/bin/bash
OPENNGL_INSTALL_PATH=`pwd`
OPENNGL_HOME=/home/admin/
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

if [ ! -d  $OPENNGL_HOME ] ; then 
	mkdir -p $OPENNGL_HOME/jars
	mkdir -p $OPENNGL_HOME/groovy
	mkdir -p $OPENNGL_HOME/lua
	mkdir -p $OPENNGL_HOME/oper
	
	echo "work space install"
fi



