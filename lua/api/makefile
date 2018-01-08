##########
####  wangwenbo@alibaba-inc.com
##########
include ../make.inc

WORKSPACE=.
TARGET=$(WORKSPACE)/build/api_module.lua
TMP=$(WORKSPACE)/build/tmp.lua
VERSION=1.0.0.1

$(TMP):clean
	@echo "==================design is build========================"
	@echo "-- verion=$(VERSION)} " > $(TMP)
	echo 'local cjson  =require "cjson";' >> $(TMP)
	echo 'local exports=require "sam";' >> $(TMP)
	echo "local App    =exports.App;" >> $(TMP)
	echo "local Module =exports.cls.Module;" >> $(TMP)
	echo "local Message=exports.Message;" >> $(TMP)
   
concat:$(TMP)
	$(call __definedir__,$(WORKSPACE)/source/project, $(TMP));
	$(call __definedir__,$(WORKSPACE)/source/template, $(TMP));
	$(call __definedir__,$(WORKSPACE)/source/auth, $(TMP));
	$(call __definedir__,$(WORKSPACE)/source/user, $(TMP));
	$(call __definedir__,$(WORKSPACE)/source/client, $(TMP));
clean:
	rm -f $(WORKSPACE)/build/*
	
link:$(TMP)
	mv $(TMP) $(TARGET)
	
    
all:concat link
	cp -f $(TARGET) ../
	echo "make api_module done"
