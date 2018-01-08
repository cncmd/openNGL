 exports.oss_client =  {};
    
 exports.oss_client.set = function (oldFile, newFile)
        local  cmd = "chmod -R  777 /home/admin/ && /home/admin/cms_oper/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/cms_oper/bin/ossutil64  cp -f ".. oldFile .."  oss://apollox-hd/backup" .. newFile .. " -c /home/admin/.ossutilconfig"
        os.execute(cmd)
  end
  
--exports.CACHE_PATH
--fsave
 exports.oss_client.setKV = function (k, v)
        local file = exports.CACHE_PATH .. string.gsub(k, "/", "#") 
        local newFile = "backup" .. k;
        fsave(file , v);
        local  cmd = "chmod -R  777 /home/admin/ && /home/admin/cms_oper/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/cms_oper/bin/ossutil64  cp -f ".. file .."  oss://apollox-hd/" .. newFile .. " -c /home/admin/.ossutilconfig"
        os.execute(cmd)
  end
  --容灾
  exports.oss_client.getKV = function (k) 
     local newFile = "backup" .. k;
     local file = exports.CACHE_PATH .. string.gsub(k, "/", "#") 
     local  cmd = "chmod -R  777 /home/admin/ && /home/admin/cms_oper/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/cms_oper/bin/ossutil64  cp -f  oss://apollox-hd/".. newFile .." " ..file .. " -c /home/admin/.ossutilconfig"
     os.execute(cmd)
     
     local exists = io.open(file,"rb");
     if exists == nil then
          return  nil;
     end
     exists.close();
     
     local f = io.input(file);
      if f == nil then
          return nil;
      end
       
       local data = io.read("*a");
       io.close();
       return data;
 end