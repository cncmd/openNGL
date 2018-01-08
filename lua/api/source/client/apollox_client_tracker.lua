--@请求分布跟踪器
App(
   Module,
   "Tracker",
   function ( message ) 
       local __normal__ = exports.normalizeSavePath;
       ngx.header["Content-Type"] = "text/plain";
       local eax       = message.data;
       local cache   = exports.rdb_client;
       
       local pname = nil;
       local uid = ngx.ctx.uid;
       
       if message.msgId == "Get" then
              --获取所有资源状态表
             local cls = exports.createNamespace("build");
             local s   = cls.getAvaliableBuildRes();
             local data = cls.getAllBuildResState();
             ngx.say(data);
       end
       
       if message.msgId == "Reset" then
                 local cls = exports.createNamespace("build");
                 local s   = cls.ReleaseAllRes();
       end
       
       if message.msgId == "GetRes" then
              local cls = exports.createNamespace("build");
              ngx.say(cjson.encode(cls.getAvaliableBuildRes()))
       end
       
       if message.msgId == "TS" then
             exports.build.setBuildResState(0);
            local __normal__= exports.normalizeSavePath;
            local server = require "resty.websocket.server"
            
            local wb, err = server:new{
                timeout = 60000,  -- in milliseconds
                max_payload_len = 65535,
            }
            
            if not wb then
                ngx.log(ngx.ERR, "failed to new websocket: ", err)
                 exports.build.setBuildResState(1);
                return ngx.exit(444)
            end
        
            local data, typ, err = wb:recv_frame()
        
            if not data then
                ngx.log(ngx.ERR, "failed to receive a frame: ", err)
                 exports.build.setBuildResState(1);
                return ngx.exit(444)
            end
        
            if typ == "close" then
                 exports.build.setBuildResState(1);
                local bytes, err = wb:send_close(1000, "enough, enough!")
                if not bytes then
                    ngx.log(ngx.ERR, "failed to send the close frame: ", err)
                    return
                end
                local code = err
                ngx.log(ngx.INFO, "closing with status code ", code, " and message ", data)
                return
            end
        
            if typ == "ping" then
                local bytes, err = wb:send_pong(data)
                if not bytes then
                    ngx.log(ngx.ERR, "failed to send frame: ", err)
                    return
                end
            elseif typ == "pong" then
            else
                ngx.log(ngx.INFO, "received a frame of type ", typ, " and payload ", data)
            end
            --@ content 
            local eax = cjson.decode(data);
            
             local uid = eax ["auth"];
             local pid = eax["name"];
            --@ 合并用户脚本
            bytes, err = wb:send_text("[info] 合并用户自定义脚本.")
--            wb:set_timeout(1000)  -- change the network timeout to 1 second
            if not bytes then
                wb:send_text("[error] failed to send a text frame")
                 exports.build.setBuildResState(1);
                return ngx.exit(444)
            end
           local cache   = exports.rdb_client;
           local pname = __normal__(uid, null, pid);
           local projectData     = cache.get(pname);
           if  projectData == nil then
                      wb:send_text("[info] 没有找到用户自定义脚本");
                      exports.build.setBuildResState(1);
                      wb:send_close(1000, "byte!")
                      return;
           end
           
           local p       = cjson.decode(projectData);
           local cls     = exports.createNamespace("client");
           local rdata = cjson.decode(p["value"]);
           local need  = nil;
           if rdata ~= nil then
                      need     = cls.getClientScriptsCollection (rdata);
                      
                      if need ~= nil then
                                             local dir =  __normal__(uid, message, 'client/'.. pid.. '/' );
                                              --@下载脚本
                                              local newFile = "backup" .. dir;
                                              local file         = "/tmp" 
                                              local distFile = file ..  "/" .. newFile
                                              
                                              local cmd       = "rm -rf  "..distFile.."/*.js &&chmod -R  777 /home/admin/ && /home/admin/cms_oper/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/cms_oper/bin/ossutil64  cp -rf  oss://apollox-hd/".. newFile .." " ..file .. " -c /home/admin/.ossutilconfig"
                                              os.execute(cmd)
                                             
                                            -- @合并替换
                                             local preview = distFile .. "/modu.client.js"
                                             local filePre    = io.open(preview, "a");
                                             
                                             for k,v  in pairs(need) do
                                                  local tmp   = distFile .. "/" .. k .. ".js"
                                                  local f = io.open(tmp,"r");
                                                  local tmpData = f:read("*a");
                                                  f:close();
                                                         
                                                 local result      =  exports.client.transScriptToModule(
                                                 {
                                                     ["name"] =  k,
                                                     ["scripts"] = tmpData
                                                 })
                                                  filePre:write(result);
                                             end
                                             filePre:close();
                                             wb:send_text("[info] 用户自定义脚本开始压缩.")
                                              --   @压缩文件
                                              exports.build.compressJSFile(distFile,preview, distFile .. "/userlib.min.js");
                                              wb:send_text("[info] 压缩用户自定义脚本完成.")
                      else
                       wb:send_text("[info] 未发现用户代理脚本");
                      end
              else 
                      wb:send_text("[info] 未发现用户代理脚本");
              end
                wb:send_text("[info] 构建完成。");
                exports.build.setBuildResState(1);
                local bytes, err = wb:send_close(1000, "byte!")
                if not bytes then
                    ngx.log(ngx.ERR, "failed to send the close frame: ", err)
                    return
                end
       end
   end
);

exports.BUILD_RES_BOOL="sys_build_mechines_22";

do 
    local cls = exports.createNamespace("build");
     --@ 获取可用构建资源 @return 资源
    cls.getAvaliableBuildRes = function () 
          local cache = exports.rdb_client;
          local p =cache.get(exports.BUILD_RES_BOOL)
          
           if  p == nil then
             return cls.setBuildResState(1) ; --设置状态可用
           end
           p = cjson.decode(p);
           for e,g  in pairs(p) do
              if g['idle'] == 1 then
                  g['time'] = ngx.now();
                  return g;
              else
                 if g['time'] ~= nil  then
                                  if ngx.now() -  g['time'] > 60 then
                                      cls.setBuildResStateA(g['ip'],1)  -- 释放
                                      return g;
                                 end 
                 end
             end
           end
           return nil -- no idle res
    end
    --@获取所有资源状态
    cls.getAllBuildResState = function () 
         local cache = exports.rdb_client;
         local p =cache.get(exports.BUILD_RES_BOOL);
         return p;
    end
    --@释放所有资源
     cls.ReleaseAllRes  = function ()
        local cache = exports.rdb_client;
        local data =  cjson.decode(exports.build.getAllBuildResState());
        for k, v  in pairs(data) do
             if v.idle == 0 then
                  v.idle = 1;
             end
        end
        local str = cjson.encode(data);
        cache.set(exports.BUILD_RES_BOOL, str);
        ngx.say(str)
     end
     --@压缩脚本文件
    cls.compressJSFile = function (dir,target,path) 
        local cmd ='/usr/bin/java -jar /home/admin/cms_oper/bin/compress.jar --compilation_level SIMPLE_OPTIMIZATIONS --js='..target..' --js_output_file=' .. path
        ngx.log(ngx.ERR, cmd)
        os.execute(cmd);
    end
    
    cls.setBuildResStateA = function (ip, state) 
         local cache = exports.rdb_client;
         local p =cache.get(exports.BUILD_RES_BOOL);
         if  p == nil then
              p = '{}';
         end
         p = cjson.decode(p);
         
         if p ~= nil then
           p[exports.ip] = {
             ["ip"]    = ip,
             ['time'] = ngx.now(),
             ["idle"] = state
           }
           end
           cache.set(exports.BUILD_RES_BOOL,  cjson.encode(p))
           return p[ip] ;
    end
    
    --@设置资源状态
    cls.setBuildResState = function (state) 
         local cache = exports.rdb_client;
         local p =cache.get(exports.BUILD_RES_BOOL);
         if  p == nil then
              p = '{}';
         end
         p = cjson.decode(p);
         
         if p ~= nil then
           p[exports.ip] = {
             ["ip"] = exports.ip,
             ['time'] = ngx.now(),
             ["idle"] = state;
           }
           cache.set(exports.BUILD_RES_BOOL,  cjson.encode(p))
           return p[exports.ip] ;
         end
         return nil;
    end
end