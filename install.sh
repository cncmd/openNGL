#!/bin/bash
OPENNGL_INSTALL_PATH=`pwd`
echo $OPENNGL_INSTALL_PATH
#==========openresty==========
USER=`id | awk '{print(substr($2,5,1))}'`

if [ "$USER" == "0" ] ; then
	 echo  "please use root"
	 exit 0
fi

rpm -i $OPENNGL_INSTALL_PATH/nginx/*.rpm


