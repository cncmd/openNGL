-- verion=1.0.0.1} 
local cjson  =require "cjson";
local exports=require "sam";
local App    =exports.App;
local Module =exports.cls.Module;
local Message=exports.Message;

App(
   Module,
   "Keygen",
   function ( message ) 
       if message.msgId == "GetKey"  then
          local src           =  ngx.ctx.uid;
          local encode1 =  ngx.encode_base64(src, true);
          local res = {};
          res.code = 0;
          res.key   = encode1;
          ngx.say(cjson.encode(res)); 
       end
   end
);
-- @ layout 
App(
   Module,
   "Layout",
   function ( message ) 
       if message.msgId == "Get" then
            -- 默认layout 是空白layout
          local layout = exports.createNamespace("layout");
          local eax     = message.data;
          
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          if eax["Layout"] == nil then
               local  tml  =  layout.out("none");
               ngx.say(tml);
               return 
          end
          
           local tml =   layout.out(eax["Layout"]);
           ngx.say(tml);
       end
   end
);-- @layout 默认是空布局， 适合画布类应用的布局
 --@update 2017-08-16

do 
        local layout = exports.createNamespace("layout");
        layout.bools= {};
        layout.Empty = "none";
        ---空布局
        layout.out = function (p,e) 
            if layout.bools[p] ~= nil then
                  return layout.bools[p].out(e);
            end
            return layout.bools[layout.Empty].out(e)
        end
end
--@ layout metro layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["metro"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                    '<script src="/js/metro.min.js" type="text/javascript"></script>',
                    };
                    
                    styles = {
                     '<link href="/css/metro.min.css" rel="stylesheet">',
                     '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                     '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                    }
                else 
                      libs = {
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='metro layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end


--@ layout metro layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["mission"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                    '<script src="/js/metro.min.js" type="text/javascript"></script>',
                    };
                    
                    styles = {
                     '<link href="/css/metro.min.css" rel="stylesheet">',
                     '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                     '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                    }
                else 
                      libs = {
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"]     ='mission layout',
                      ["dist"]      = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end


--@ layout poplayer layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["poplayer"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script data-mt-inline src="//g.alicdn.com/mtb/??lib-flexible/0.3.4/flexible.js,lib-promise/3.1.3/polyfillB.js,lib-env/1.9.9/env.js,lib-windvane/2.1.8/windvane.js,lib-httpurl/1.3.8/httpurl.js"></script>',
                    '<script data-mt-inline src="//g.alicdn.com/heyi_h5/swordrain/0.0.2/mtop.js"></script>'
                    };
                    
                    styles = {
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>'
                    }
                else 
                      libs = {
                       '<script data-mt-inline src="//g.alicdn.com/mtb/??lib-flexible/0.3.4/flexible.js,lib-promise/3.1.3/polyfillB.js,lib-env/1.9.9/env.js,lib-windvane/2.1.8/windvane.js,lib-httpurl/1.3.8/httpurl.js"></script>',
                     '<script data-mt-inline src="//g.alicdn.com/heyi_h5/swordrain/0.0.2/mtop.js"></script>',
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='aft layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end

--@ layout none layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools[layout.Empty] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local libs = {
                '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                [[<script> window.alert = function () {};</script>]]
                };
                
                
                local styles = {
                }
                
                local libsend = {
                      '<script src="/js/laya.core.min.js"    type="text/javascript" ></script>',
                      '<script src="/js/laya.webgl.min.js" type="text/javascript"  ></script>',
                      '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                      '<script src="/js/apollox.core.min.js" type="text/javascript"></script>',
                      '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      '<script type="text/javascript" src="/source/plugin/LogoMotion.js" ></script>',
                      '<script type="text/javascript" src="/source/plugin/Stat.js" ></script>'
                }
                local publish = nil;
                if e ~= nil then
                    publish = 1;
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='custom layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end exports.PROJECT_INDEXER="__indexer__";
 exports.PROJECT_INFO      ="__page__";
 --@update 2017-08-16
App(
   Module,
   "Project",
   function ( message )  
       local __normal__ = exports.normalizeSavePath;
       ngx.header["Content-Type"] = "text/plain";
       local eax       = message.data;
--       local cache   = ngx.shared.my_cache;
       local cache = exports.rdb_client;
       
       local pname = nil;
       
       if ngx.ctx.uid == nil then
                 ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not auth token"}));
                  return;
               end
       local uid = ngx.ctx.uid;
       
       if message.msgId == "Update" then  --@ Update 
           if(eax['name'] ~= nil) then
--                pname  = uid .. eax['name'];
                   pname = __normal__(uid, message, eax['name']);
          else
                ngx.say(cjson.encode(
                 {
                   ["res"]=-1,
                   ["error"]="param need."
                 }
             ));
             return;
          end
--          local p = cache:get(pname);
          local p =cache.get(pname)
          if  p == nil then
              ngx.say(cjson.encode({
              ["res"]=-1,
              ["error"]="project not exists."}));
              return;
          end
          p = cjson.decode(p);
          if p == nil then
             ngx.say(cjson.encode({
              ["res"]=-1,
              ["error"]="system error"}));
            return;
          end
          
          if eax["value"] ~= nil then
            p["value"] = eax["value"];
            local eaxdata = cjson.encode(p);
--            cache:set (pname,  eaxdata)
               cache.set(pname,eaxdata);
--            ngx.say(cjson.encode({["res"]=0,["data"]=cache:get(pname)}));
            ngx.say(cjson.encode({["res"]=0,["data"]=cache.get(pname)}));
          else
             ngx.say(cjson.encode({
              ["res"]=-1,
              ["error"]="value is empty"}));
          end
       end
       if message.msgId == "SetV" then
           local pname = nil;
           if(eax['alias'] ~= nil) then
--            pname  = eax['name'];
            pname  = __normal__(uid, message, eax['name']);
          else
             ngx.say(cjson.encode({
             ["res"]=-1,
             ["error"]="param need."}));
             return;
          end
          
--          pname     = uid  .. pname;
--          local p = cache:get(pname);
          local p = cache.get(pname);
          local pdata = cjson.decode(p);
          if pdata ~= nil then
                 for k,v in pairs(eax) do
                    pdata[k] = eax[k];
                end
          end
          cache.set(pname, cjson.encode(pdata));
          ngx.say(cjson.encode({["res"]=0}));
       end
       if message.msgId == "Set" then
           local pname = nil;
           if(eax['name'] ~= nil) then
--            pname  = eax['name'];
            pname = __normal__(uid, message, eax['name']);
          else
             ngx.say(cjson.encode({
             ["res"]=-1,
             ["error"]="param need."}));
             return;
          end
          
--          pname     = uid  .. pname;
--          local p = cache:get(pname);
          local p = cache.get(pname);
          if  p ~= nil then
              ngx.say(cjson.encode({
              ["res"]=-1,
              ["error"]="name already exists."}));
              return;
          end
          
--          local indexer = cache:get(uid ..  exports.PROJECT_INDEXER);
--          local indexer = cache.get(uid ..  exports.PROJECT_INDEXER);
          local path = __normal__(uid, message, exports.PROJECT_INDEXER);
          local indexer = cache.get(path);
           
          if indexer == nil then
              indexer = {};
          else
              indexer = cjson.decode(indexer);
          end
          
          table.insert(indexer,#indexer+1,pname);
          local indexdata = cjson.encode(indexer);
--          cache:set(uid ..  exports.PROJECT_INDEXER, indexdata);
--          cache.set(uid ..  exports.PROJECT_INDEXER, indexdata);
          cache.set(path, indexdata);
          local eaxdata = cjson.encode(eax)
--          cache:set(pname, eaxdata);
          cache.set(pname, eaxdata);
          ngx.say(cjson.encode({["res"]=0}));
     end
    if message.msgId == "Indexer" then
--               local p = cache:get(uid ..  exports.PROJECT_INDEXER);
               local indexer = __normal__(uid, message, exports.PROJECT_INDEXER);
--               local p = cache.get(uid ..  exports.PROJECT_INDEXER);
               local p = cache.get(indexer);
               ngx.say(cjson.encode({["res"]=0, ["data"]=p}));
    end
    if message.msgId == "All"  then
--               local p = cache:get(uid ..  exports.PROJECT_INDEXER);
               local indexer = __normal__(uid, message, exports.PROJECT_INDEXER);
--               local p = cache.get(uid ..  exports.PROJECT_INDEXER);
               local p = cache.get(indexer);
               if p == nil then
                    ngx.say(cjson.encode({["res"]=0, ["data"]={}}));
                    return;
               end
               local d = cjson.decode(p);
               local p = d;
               local res = {};
               local cindex = 1;
               if p ~= nil then
                   for i = 1, #p do  
--                      local d =  cache:get(p[i])
                      local d =  cache.get(p[i])
                      if d ~= nil then
                        d = cjson.decode(d);
                        if type(d) == 'string' then
                           d = {};
                           d.state = 0;
                        end
                        if d.state == nil  then
                            d.state = 1;
                        end
                        d.value = 0;
                        if d.state > 0 then
                            res[cindex]  = d ;
                            cindex = cindex+1;
                        end
                      end
                   end  
               end
               ngx.say(cjson.encode({["res"]=0, ["data"]=res}));
    end
    if message.msgId == "Del" then
                 local pname = nil;
                 if(eax['name'] ~= nil) then
--                   pname  = uid .. eax['name'];
                   pname = __normal__(uid, message, eax['name']);
                else
                   ngx.say(cjson.encode({["res"]=-1,["error"]="param need."}));
                   return;
                end
--                local p = cache:get(pname);
                 local p = cache.del(pname);
                 ngx.say(cjson.encode({["res"]=0}));
    end
    if message.msgId == "Get" then
                 local pname = nil;
                 if(eax['name'] ~= nil) then
--                   pname  = uid .. eax['name'];
                   pname = __normal__(uid, message, eax['name']);
                else
                   ngx.say(cjson.encode({["res"]=-1,["error"]="param need."}));
                   return;
                end
--                local p = cache:get(pname);
                 local p = cache.get(pname);
                
                if p == nil then
                    ngx.say(cjson.encode({["res"]=-1,["error"]="not find project"}));
                    return;
                end
                ngx.say(cjson.encode({["res"]=0, ["data"]=p}));
          end
   end
);
do 
        local cls = exports.createNamespace("modules");
        
        cls.mockNoneLayout = function ()
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="检测插件" ,
                        ["mod"]="StatViewPlugin"
            }
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="精灵动画测试模块" ,
                        ["mod"]="LogoModule"
            }
            
            return cjson.encode(test);
        end
        cls.mockPoplayerLayout = function () 
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="poplayer落地插件" ,
                        ["mod"]="PoplayerImage"
            }
            
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="测试插件" ,
                        ["mod"]="MetroTest"
            }
            
            return cjson.encode(test);
        end
        
        
        cls.mockMetroLayout = function () 
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="mobx协议落地插件" ,
                        ["mod"]="mobx"
            }
            
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="测试插件" ,
                        ["mod"]="MetroTest"
            }
            
            return cjson.encode(test);
        end
        
        cls.getModules = function (type) 
             --- mock
             if  type == 1  then
               return  cls.mockMetroLayout ();
             elseif type == 2 then
               return cls.mockPoplayerLayout();
             else 
               return cls.mockNoneLayout();
             end
        end
end exports.oss_client =  {};
    
 exports.oss_client.set = function (oldFile, newFile)
        local  cmd = "chmod -R  777 /home/admin/ && /home/admin/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/bin/ossutil64  cp -f ".. oldFile .."  oss://apollox-hd/backup" .. newFile .. " -c /home/admin/.ossutilconfig"
        os.execute(cmd)
  end
  
--exports.CACHE_PATH
--fsave
 exports.oss_client.setKV = function (k, v)
        local file = exports.CACHE_PATH .. string.gsub(k, "/", "#") 
        local newFile = "backup" .. k;
        fsave(file , v);
        local  cmd = "chmod -R  777 /home/admin/ && /home/admin/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/bin/ossutil64  cp -f ".. file .."  oss://apollox-hd/" .. newFile .. " -c /home/admin/.ossutilconfig"
        os.execute(cmd)
  end
  --容灾
  exports.oss_client.getKV = function (k) 
     local newFile = "backup" .. k;
     local file = exports.CACHE_PATH .. string.gsub(k, "/", "#") 
     local  cmd = "chmod -R  777 /home/admin/ && /home/admin/bin/ossutil64 config -e oss-cn-hangzhou.aliyuncs.com -i LTAIyXPfgbfqSBp9 -k VvUzCJFt2uvr9klJzryYSIKy2i5h4S -c /home/admin/.ossutilconfig && /home/admin/bin/ossutil64  cp -f  oss://apollox-hd/".. newFile .." " ..file .. " -c /home/admin/.ossutilconfig"
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
 end function  fsave (path, data) 
        local f = io.open(path , "w+")
        if f == nil then
          return;
        end
        f:write(data);
        f:close(); 
 end
exports.CACHE_PATH="/home/admin/cache/";
App(
   Module,
   "Package",
   function ( message ) 
      local eax = message.data;
      local __normal__= exports.normalizeSavePath;
      ngx.header["Content-Type"] = "text/plain";
      if ngx.ctx.uid == nil then
                 ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not auth token"}));
                  return;
      end
      local uid = ngx.ctx.uid;
      
      if message.msgId == "Build" then
          --@获取一个可用的构建资源
          local cls = exports.createNamespace("build");
          local ip  = cls.getAvaliableBuildRes();
          
          if ip ~= nil then
                 ngx.say(cjson.encode(ip));
                 return;
          end
          return ngx.say(cjson.encode({
              ["code"] = -1,
              ["error"] = "no idle here";
          }))
      end 
      
      if message.msgId == "PublishTask" then
            local cache = exports.rdb_client;
            local pdata    =  eax["value"]
            local appKey =  eax["appKey"]
            local normalPath =  appKey
            local locPath = exports.CACHE_PATH .. normalPath;
            
            fsave( locPath , pdata)
           ---添加到oss上
           exports.oss_client.set(locPath , "_" .. normalPath);
           ngx.say(cjson.encode({
              ["code"] = 0
           }))
           return
      end
      
      
      
      
      
      -----------------------代码已经废弃------------------------
      
      local clayout =  "none";   -- 默认layout 是空白layout
       
--      local cache   = ngx.shared.my_cache;
      local cache = exports.rdb_client;
--      local p = cjson.decode(cache:get(uid .. eax["name"]));
--      local p = cjson.decode(cache.get(uid .. eax["name"]));
      local pname = __normal__(uid, message, eax['name']);
      local data     = cache.get(pname);
      if  data == nil then
                ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not find data."}));
                  return;
      end
      local p = cjson.decode(data);
      if p ~= nil then
           local ctype =tonumber(p.type);
           if  ctype == 1 then
                  clayout = "metro";
           end
           if ctype == 2 then
                  clayout = "poplayer";
           end
      end
      local layout       = exports.createNamespace("layout");
--      local previewjs = ngx.ctx.uid .. eax["name"] .. ".js";
      local previewjs = __normal__(uid, message, eax['name'] .. ".js")
--      local ossFile      = ngx.ctx.uid .. "/" .. eax["name"] .. ".js";
      local tml =   layout.out(clayout,'<script src="/preview/backup' .. previewjs ..'"></script>');
      
      local template = require "template"
      local render = template.compile(exports.TML_JS_JUMP  );
      local pdata = render({code=p["value"]});
      
      local loc0 = exports.CACHE_PATH ..  string.gsub(previewjs, "/", "#");
       
      fsave( loc0 , pdata)
      
      ---添加到oss上
      exports.oss_client.set(loc0 , previewjs);
      
      local render = template.compile(tml);
      
      local fsdata = render({
       title = eax["name"] ,
      dist='<script src="/preview/backup' ..previewjs..'></script>',
      publish=1
      });
      
      local previewHtml =__normal__(uid, message, eax['name'] .. ".html")
      local loc1 = exports.CACHE_PATH ..  string.gsub(previewHtml, "/", "#");
      fsave(loc1 , fsdata)
      
--       local ossHFile = ngx.ctx.uid .. "/" .. eax["name"] .. ".html";
       exports.oss_client.set(loc1  , previewHtml);
      
      local res =  '/preview/backup'.. previewHtml ..'?showVertical=1';
      ngx.say(cjson.encode({data=res}))
     end
);  local rdb_client =  {};
    rdb_client.RDB_HOST="http://127.0.0.1:8090"
--  rdb_client.RDB_INSTANCE="5998477b-4f6b-441b-9b56-9e5ddf39deee";
    rdb_client.set = function (k, v) 
    local http      = require "resty.http"  
    local cjson    = require "cjson"
    local httpc     = http.new()  
    local url         =  exports.rdb_client.RDB_HOST;
    
--    local params = {
--      ["instance"] = exports.rdb_client.RDB_INSTANCE,
--      ["args"] = {k,v}
--    }
    
    local res, err = httpc:request_uri(url, {  
        path = "/SSDB/WeakGet.mxml?opt=set&data=${v}&key=${k}&n=1",
        method   = "GET",  
    })  
   
   ngx.log(ngx.ERR, err);
   ngx.log(ngx.ERR, cjson.encode(res.body))
   
   
   if res ~= nil and res.body ~= nil then
        local eax = res.body;
        if eax.code == 200 then
            exports.oss_client.setKV(k,v); 
            return 1;
        end
   end
   return 0;
  end
  
  
  rdb_client.del = function (k) 
      local  cc =  exports.rdb_client.get(k);
      if cc ~=nil then 
           local  obj = {}
           obj.state = -1;
           exports.rdb_client.set(k, cjson.encode(obj))
      end
  end
  
  rdb_client.get = function (k)
      local http      = require "resty.http"  
      local cjson    = require "cjson"
      local httpc    = http.new()  
      local url        =  exports.rdb_client.RDB_HOST .. "get.json";
      
      local params = {
        ["instance"] = exports.rdb_client.RDB_INSTANCE,
        ["args"] = {k}
      }
      
      local res, err = httpc:request_uri(url, {  
        path = "/SSDB/WeakGet.mxml?opt=get&key=${k}&n=1",
        method   = "GET",  
       })  
     
      if res ~= nil and res.body ~= nil then
          local eax = cjson.decode(res.body);
          if eax.code == 200 then
              if eax.data ~= nil then
                  return eax.data;
              end
          end
      end 
     local data = exports.oss_client.getKV (k);
    
     exports.rdb_client.set(k,data);
     return data;
  end
  
exports.rdb_client = rdb_client;

App(
   Module,
   "Test",
   function ( message ) 
       ngx.header["Content-Type"] = "text/html";
       if message.msgId == "Get" then
              ngx.say( exports.rdb_client.get("A"));
       end
       if message.msgId == "Set" then
               local result = exports.rdb_client.set("A","Hellow I am From RDB");
               ngx.say(result)
       end
       if message.msgId == "Key"  then
          local src           =  ngx.ctx.uid;
          local encode1 =  ngx.encode_base64(src, true);
          ngx.say("raw  ", src);
          ngx.say("encode ", encode1);
          ngx.say("decode ",ngx.decode_base64(encode1))
       end
   end
);
--http://one-voice-platform.alibaba-inc.com/onevoiceplatform/CommonPlatformService/response.do

exports.normalizeSavePath = function (uid, msg, name) 
    return string.format("/%s/%s",  uid ,name); 
end
-- @ design 页面

App(
   Module,
   "Design",
   function ( message ) 
       if message.msgId == "Get" then
         local __normal__ = exports.normalizeSavePath;
          local eax     = message.data;
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
         if ngx.ctx.uid == nil then
                 ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not auth token"}));
                  return;
               end
          local uid = ngx.ctx.uid;
          local layout=  "none";   -- 默认layout 是空白layout
          local modules = "[[],[]]"
          if eax["id"] ~= nil then
--                local cache   = ngx.shared.my_cache;
                local cache   = exports.rdb_client;
                local pname = __normal__(uid,message, eax["id"]);
                
                local datastr        = cache.get(pname);
                
                if datastr == nil then
                      datastr = '{"ctype":1}';
                end
                
--             local p = cjson.decode(cache:get(uid .. eax["id"]));
                local p = cjson.decode(datastr);
                if p ~= nil then
                     local ctype =tonumber(p.type);
                     if  ctype == 1 then
                            layout = "metro";
                     end
                     
                     if ctype == 2 then
                            layout = "poplayer";
                     end
                     
                     if ctype == 100  then
                           layout = "mission"
                     end
                     
                      if ctype == 0 then
                            layout = "none";
                     end
                     local cls = exports.createNamespace("modules");
                     modules = cls.getModules(ctype);
                end
          end
          
          local template = require "template"
          local render = template.compile(exports.TML_VIEW_DESIGN);
          
          if layout == "mission" then
              render= template.compile(exports.TML_VIEW_MISSION_DESIGN);
          end
          
          local menuRender =  template.compile(exports.TML_COMMON_HEADER);
          local libs = {
          '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
          '<script src="/js/metro.min.js"        type="text/javascript"></script>',
          '<script src="/js/laya.core.min.js"    type="text/javascript" ></script>',
          '<script src="/build/actrl.min.js" type="text/javascript"></script>',
          '<script src="/js/ace.js" type="text/javascript" ></script>',
          '<script  src="/js/mode-javascript.js" type="text/javascript"></script>',
          '<script  src="/js/ext-language_tools.js" type="text/javascript"></script>',
          '<script src="/js/theme-xcode.js" type="text/javascript"></script>',
          [[<script> window.alert = function () {};</script>]]
          };
          
          local styles = {
            '<link href="/css/metro.min.css"         rel="stylesheet">',
            '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
            '<link href="/css/metro-icons.min.css"   rel="stylesheet" />',
           '<link href="/css/hook.css" rel="stylesheet" />',
          }
   
          local menu  = menuRender ( {
          ["user"]=ngx.ctx.username,
          ["design"]=1,
          ["systemName"]=exports.SystemName
          });
          layout =  '<iframe  id="h5Content" src="/Layout/Get.mxml?Layout=' .. layout .. '&showVertical=1" ></iframe>' 
          local fsdata  = render({
                ["libs"]=libs ,
                ["styles"] = styles,
                ["modules"]=modules,
                ["title"] = "design" ,
                ["menu"] = menu,
                ["src"] = '<script src="/build/design.min.js"></script>',
                ["mLayout"] = layout ,
          });
          
        ngx.say(fsdata);
       end
   end
);App(
   Module,
   "Miss",
   function ( message ) 
       if message.msgId == "Get" then
          local eax     = message.data;
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          local template = require "template"
          local render    = template.compile(exports.TML_VIEW_ERROR);
          local menuRender =  template.compile(exports.TML_COMMON_HEADER);
          local libs = {
          '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
          '<script src="/js/metro.min.js"        type="text/javascript"></script>',
          [[<script> window.alert = function () {};</script>]]
          };
                  
          local styles = {
            '<link href="/css/metro.min.css"         rel="stylesheet">',
            '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
            '<link href="/css/metro-icons.min.css"   rel="stylesheet" />',
          }
          
          local menu  = menuRender ( {
          ["user"]=ngx.ctx.username,
          ["systemName"]=exports.SystemName
          });
          
          local fsdata  = render({
                ["libs"]=libs ,
                ["styles"] = styles,
                ["title"] = "profile" ,
                ["menu"] = menu
          });
          
        ngx.say(fsdata);
       end
   end
);

App(
   Module,
   "Help",
   function ( message ) 
       if message.msgId == "Get" then
          local eax     = message.data;
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          local template = require "template"
          local render    = template.compile(exports.TML_VIEW_HELP);
          local menuRender =  template.compile(exports.TML_COMMON_HEADER);
          local libs = {
          '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
          '<script src="/js/metro.min.js"        type="text/javascript"></script>',
          [[<script> window.alert = function () {};</script>]]
          };
                  
          local styles = {
            '<link href="/css/metro.min.css"         rel="stylesheet">',
            '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
            '<link href="/css/metro-icons.min.css"   rel="stylesheet" />',
          }
          
          local menu  = menuRender ( {
          ["user"]=ngx.ctx.username,
          ["systemName"]=exports.SystemName
          });
          
          local fsdata  = render({
                ["libs"]=libs ,
                ["styles"] = styles,
                ["title"] = "profile" ,
                ["menu"] = menu
          });
          
        ngx.say(fsdata);
       end
   end
);

-- @ Profile 
App(
   Module,
   "Profile",
   function ( message ) 
       if message.msgId == "Get" then
            -- 默认layout 是空白layout
          local eax     = message.data;
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          local template = require "template"
          local render = template.compile(exports.TML_VIEW_PROFILE);
          local menuRender =  template.compile(exports.TML_COMMON_HEADER);
          local libs = {
          '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
          '<script src="/js/metro.min.js"        type="text/javascript"></script>',
          '<script src="/build/actrl.min.js" type="text/javascript"></script>',
          '<script src="/build/profile.min.js"   type="text/javascript"></script>',
          [[<script> window.alert = function () {};</script>]]
          };
                  
          local styles = {
            '<link href="/css/metro.min.css"         rel="stylesheet">',
            '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
            '<link href="/css/metro-icons.min.css"   rel="stylesheet" />',
           '<link href="/css/hook.css" rel="stylesheet" />',
          }
          
          local menu  = menuRender ( {
          ["user"]=ngx.ctx.username,
          ["systemName"]=exports.SystemName
          });
          
          local fsdata  = render({
                ["libs"]=libs ,
                ["styles"] = styles,
                ["title"] = "profile" ,
                ["menu"] = menu
          });
          
        ngx.say(fsdata);
       end
   end
);exports.TML_COMMON_HEADER=[[
  {% if design ~= nil then %}
    <div class="app-bar">
  {% else %}
    <div class="app-bar fixed-top">
  {% end %}
            <link rel="shortcut icon" href="/favicon.ico" />
            <ul class="app-bar-menu place-left" data-flexdirection="reverse">
                    <li data-flexorderorigin="1" data-flexorder="2">&nbsp;&nbsp;&nbsp;<span class="mif-space-shuttle icon" style="width:38px;font-size:16px;"></span></li>
            </ul>
            <span class="app-bar-divider"></span>
            <ul class="app-bar-menu">
                <li><a href="/Profile/Get.mxml">{{systemName}}</a></li>
            {% if design ~= nil then %}
                            <li>
                                <a href="" class="dropdown-toggle">编辑</a>
                                <ul class="d-menu" data-role="dropdown" style="border:0">
                                    <li><a href="javascript:void(0)" onclick="exports.savehandle()"><span class="mif-drive icon" style="color: #1D1D1D;"></span>保存</a></li>
                                    <li><a href="javascript:void(0)" onclick="exports.buildhandle()"><span class="mif-drive icon" style="color: #1D1D1D;"></span>构建</a></li>
                                    <li class="divider"></li>
                                    <li><a href="javascript:void(0)" onclick="exports.addmodules(event)"><span class="mif-plus icon" style="color: #1D1D1D;"></span>添加模块</a></li>
                                    <li><a href="" class="dropdown-toggle"><span class="mif-tablet-landscape icon" style="color: #1D1D1D;"></span>添加多屏幕预览</a>
                                        <ul class="d-menu" data-role="dropdown">
                                            <li><a href=""><span class="mif-mobile icon" style="color: #1D1D1D;"></span>添加H5屏幕</a></li>
                                            <li><a href=""><span class="mif-display icon" style="color: #1D1D1D;"></span>添加PC屏幕</a></li>
                                        </ul>
                                    </li>
                                    <li class="divider"></li>
                                    <li><a href="" class="dropdown-toggle"><span class="mif-file-archive icon" style="color: #1D1D1D;"></span>发布</a>
                                        <ul class="d-menu" data-role="dropdown">
                                            <li><a href=""><span class="mif-github icon" style="color: #1D1D1D;"></span>发布到gitlab</a></li>
                                            <li><a href=""><span class="mif-jsfiddle icon" style="color: #1D1D1D;"></span>发布到cdn</a></li>
                                            <li><a href=""><span class="mif-file-download icon" style="color: #1D1D1D;"></span>下载到本地</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li> 
                            <span class="app-bar-divider"></span>
                            <li><a href="javascript:void(0)" onclick="exports.sharelink()" ><span class="mif-share icon" style="color: #FFFFFF;"></span> 分享</a></li>
                            <span class="app-bar-divider"></span>
              {% end %}
             <li><a href="/Help/Get.mxml">帮助</a></li>
            </ul>
            <ul class="app-bar-menu place-right" data-flexdirection="reverse">
                         <script src="/build/lua.vm.js"></script>
                        <script src="/build/navx.min.js"></script>
                        <li class="active-container" style="max-width:300px;min-width:100px;">
                            <a href="#" class="dropdown-toggle active-toggle" style="max-width:300px;min-width:100px;"><span class="mif-cog"></span>&nbsp;<span id="username">{{user}}</span></a>
                            <ul class="d-menu" data-role="dropdown" style="min-width:300px;max-width:100px;border:0;">
                                <li><a href="javascript:void(0)" onclick="exports.logout()" style="max-width:300px;min-width:100px;">退出</a></li>
                            </ul>
                        </li>
            </ul>
    </div>
    ]]
exports.TML_LAYOUT_NONE=[[
<!DOCTYPE html>
<html>
  <meta name='viewport' 
        content='width=device-width,initial-scale=1.0,
        minimum-scale=1.0,maximum-scale=1.0,user-scalable=no'/>
  <head>
        <!--{{type}}-->
        <meta charset="utf-8">
        <title></title>

        {% for _, style in ipairs(styles) do %}
          {*style*}
        {% end %}
       
        {% for _, lib in ipairs(libs) do %}
          {*lib*}
        {% end %}
       <style>
                body {
                   width:100%;
                   height:100%;
                   margin:0;
                }
       </style>
  </head>
  <body>
  </body>
    {% for _, lib in ipairs(libsend) do %}
          {*lib*}
    {% end %}
           <script>
              
;(function(window, lib) {
    lib.env = lib.env || {};

    var ua = window.navigator.userAgent;
    var matched;
    
    if ((matched = ua.match(/Windows\sPhone\s(?:OS\s)?([\d\.]+)/))) {
        lib.env.os = {
            name: 'Windows Phone',
            isWindowsPhone: true,
            version: matched[1]
        }
    } else if(!!ua.match(/Safari/) && (matched = ua.match(/Android[\s\/]([\d\.]+)/))) {
        lib.env.os = {
            version: matched[1]
        }

        if ((!!ua.match(/Mobile\s+Safari/))) {
            lib.env.os.name = 'Android';
            lib.env.os.isAndroid = true;
        } else {
            lib.env.os.name = 'AndroidPad';
            lib.env.os.isAndroidPad = true;
        }
    } else if((matched = ua.match(/(iPhone|iPad|iPod)/))) {
        var name = matched[1];

        matched = ua.match(/OS ([\d_\.]+) like Mac OS X/);

        lib.env.os = {
            name: name,
            isIPhone: (name === 'iPhone' || name === 'iPod'),
            isIPad: name === 'iPad',
            isIOS: true,
            version: matched[1].split('_').join('.')
        }
    } else {
        lib.env.os = {
            name:'unknown',
            version:'0.0.0'
        }
    }
    
    if (lib.version) {
        lib.env.os.version = lib.version(lib.env.os.version);
    }
    
})(window, window['lib'] || (window['lib'] = {}));

       ;(
    function () {
            var cls = exports.createNamespace("plugin");
    
            cls.mobx = function () {
                this.content = null;
                this.init = function (data) {
                    this.data    = data;
                }
                
                this.dealloc= function() {  ///销毁
                }
                
                this.getView= function () {
                     var p = document.createElement("span");
                     var att=document.createAttribute("class");
                     var style=document.createAttribute("style");
                     style.value="color:#FFFFFF;font-size:22px;width:50px;height:50px;";
                     att.value="mif-truck mif-ani-pass";
                     p.setAttributeNode(att);
                     p.setAttributeNode(style);
                     return p;
                }
                
                this.proto  = (function () {
                    return "format:string|精灵动画的描述json,interval:int|刷新频率" ;
                })();
                
                this.mockData = function () {
                    return {
                        "format":"//on9hafglw.bkt.clouddn.com/daily/test/0.0.1/fighter.json",
                        "interval":1
                    }
                }
            }
    }
)();

;(
    function () {
            var cls = exports.createNamespace("plugin");
    
            cls.PoplayerImage = function () {
                this.content = null;
                this.img       = null;
                
                this.init = function (data) {
                    this.data    = data;
                    this.content = document.createElement("div");
                    this.content.style.position="absolute";
                    this.img       = document.createElement("img");
                    var att  =document.createAttribute("src");
                    att.value=data.src;
                    this.img.setAttributeNode(att);
                    this.content.appendChild(this.img);
                    
                    test();
                    
                    clickHandle(this);
                    
                }
                 this.update = function () {
                      var data = this.data;
                      var style = this.img.style;
                  
                     if(data.width) {
                       style.width   = data.width + "px";
                     }
                     
                     if(data.height) {
                         style.height = data.height + "px"
                     }
                     
                     var style = this.content.style;
                     if(data.offsetX) {
                          // var offLeft = (window.screen.availWidth  - (Number(data.width) *  exports.dpih))  ;
                          // style.left = (offLeft - (data.offsetX * exports.dpih) )    + "px";
                          var offLeft = (window.screen.availWidth  -  Number(data.width)) 
                          style.left = (offLeft - data.offsetX  )    + "px";
                     }
                     
                     if(data.offsetY){
                            //var offRight  = (window.screen.availHeight - (Number(data.height) * exports.dpih));
                            //style.top =  (offRight-(data.offsetY * exports.dpih))  + "px";
                            
                            var offRight  = (window.screen.availHeight - Number(data.height));
                            style.top =  (offRight- data.offsetY)  + "px";
                     }
                     
                     if(data.closeButton == "显示") {
                        console.log("show close button");
                        var closeButton   = document.createElement("img");
                        var att  =document.createAttribute("src");
                        att.value= "http://apollox-hb.oss-cn-beijing.aliyuncs.com/8BKmqmcgavUu9e0b1N8zxwiEiE/%E6%8C%82%E8%A7%92_%E5%85%B3%E9%97%AD%E6%8C%89%E9%92%AE@2x.png";
                        closeButton.setAttributeNode(att);
                        closeButton.style.top = "2px";
                        closeButton.style.width ="17px";
                        closeButton.style.height="17px";
                        closeButton.style.position="absolute";
                        closeButton.style.left = 100 + "px";
                        closeButton.style.top =0 + "px";
                        
                        closeButton.addEventListener("click", function () {
                              window.WindVane.call('WVPopLayer', 'close', {}, function(s){
                                  // do something when success;
                                }, function(e) {
                               // do something when failed;
                                }); 
                                
                                console.log("close button click");
                        });
                        this.content.appendChild(closeButton);
                     }
                     console.log(offLeft, offRight, style.left, data.offsetY );
                 }
                 
                function  test() {
                  //查询播放器信息
                         if(  window.WindVane == null)  return;
                         window.WindVane.call('DJH5Player', 'videoinfo', {}, function(e) {
                            console.log('videoinfo success: ' + JSON.stringify(e.param));
                          }, function(e) {
                          });
                  
                       //开启监听，除了prepare其他监听默认关闭
                       var params = {
                              "play":1,
                              "pause":1,
                              "duration":1,
                              "hdchange":1,
                              "langchange":1,
                              "fullscreen":1,
                              "halfscreen":1,
                              "playend":1,
                              "playerror":1,
                              "start":1
                          };
                        window.WindVane.call('DJH5Player', 'openlistener', params, function(e) {
                          isopen = true;
                        }, function(e) {
                        });
                  
                     //监听正片开始
                      document.addEventListener('DJH5PlayerListener.start', function(e) {
                        console.log("start"+JSON.stringify(e.param));
                        exports.count = 10;
                        exports.hide   = false;
                      }, false);
                  
                      //监听进度
                      document.addEventListener('DJH5PlayerListener.duration', function(e) {
                        //param.second 毫秒
                        console.log("duration"+JSON.stringify(e.param));
                        
                        if(exports.count > 0) {
                            exports.count  --;
                        } else {
                            if(exports.hide) {
                                window.WindVane.call('WVPopLayer', 'close', {}, function(s){
                                  // do something when success;
                                }, function(e) {
                               // do something when failed;
                                }); 
                                console.log("close poplayer");
                                 return;
                            }
                            exports.hide = true;
                            window.WindVane.call('WVPopLayer', 'display', {});  
                            exports.count = 15;
                        }
                      }, false);
                } 
                function  clickHandle (ctx) {
                  var eax = ctx.getView(); ///获取视图 
                  var ebx = ctx.data;
                  
                  if(ebx.type == "PopLayer") {
                  }
                
                  var lib = window.lib;
                    
                    if(!lib) {
                        console.log("error::not find the lib-env");
                        return;
                    }
                    
                    var isIOS = false; 
                    
                    if(lib.env) {
                        isIOS = lib.env.os.isIOS;
                    } 
                      
                  eax.addEventListener("click",function () { 
                    switch(ebx.type) {
                         case "PopLayer":
                               if(isIOS) {
                                      window.WindVane.call('DYKBaseJSBridge', 'nativeOpen', {
                                        'url': "youku://openWVH5?url="+ebx.navigateToURL
                                        }, function (e) {
                                        }, function (e) {
                                            location.href="youku://jsbjump?weburl=" +
                                            encodeURIComponent(ebx.navigateToURL);
                                        });
                               } else {
                                    window.WindVane.call('WVPopLayer', 'navToUrl',
                                       { 'url':ebx.navigateToURL }, function(s){
                                         }, function(e) {
                                             location.href= ebx.navigateToURL;
                                         });
                               }
                             break;
                     }
                  });
                }


                this.dealloc= function() {  ///销毁
                }
                
                this.getView= function () {
                     return this.content;
                }
                
                this.proto  = (function () {
                    return "src:string|图片地址, "+
                    "closeButton:opt|显示关闭按钮#*隐藏*显示,"+
                    "navigateToURL:string|需要跳转的地址,"+
                    "width:string|图片的宽度,"+
                    "height:string|图片的高度,"+
                    "offsetX:string|据左边框的位移,"+
                    "offsetY:string|据下边框的位移,"+
                    "type:opt|跳转类型#*PopLayer*WebView*Other" ;
                })();
                
                this.mockData = function () {
                    return {
                        "src":"//on9hafglw.bkt.clouddn.com/daily/test/0.0.1/test.png"
                    }
                }
            }
    }
)();
</script>
  {% if publish ~= nil then %}
  {*dist*}
  {% end %}
</html>
 ]]
exports.TML_HTML_OWNER=[[
<!DOCTYPE html>
<html>
  <head>
        <meta charset="utf-8">
        <title>{{title}}</title>

        {% for _, style in ipairs(styles) do %}
          {*style*}
        {% end %}
       
        {% for _, lib in ipairs(libs) do %}
          {*lib*}
        {% end %}
       
       <style>
                body {
                   width:100%;
                   height:100%;
                   margin:0;
                }
       </style>
  </head>
  <body >
  </body>
    {% for _, lib in ipairs(libsend) do %}
          {*lib*}
    {% end %}
    
    
           <script>
       ;(
    function () {
            var cls = exports.createNamespace("plugin");
    
            cls.mobx = function () {
                this.content = null;
                this.init = function (data) {
                    this.data    = data;
                }
                
                this.dealloc= function() {  ///销毁
                }
                
                this.getView= function () {
                     var p = document.createElement("span");
                     var att=document.createAttribute("class");
                     var style=document.createAttribute("style");
                     style.value="color:#FFFFFF;font-size:22px;width:50px;height:50px;";
                     att.value="mif-truck mif-ani-pass";
                     p.setAttributeNode(att);
                     p.setAttributeNode(style);
                     return p;
                }
                
                this.proto  = (function () {
                    return "format:string|精灵动画的描述json,interval:int|刷新频率" ;
                })();
                
                this.mockData = function () {
                    return {
                        "format":"//on9hafglw.bkt.clouddn.com/daily/test/0.0.1/fighter.json",
                        "interval":1
                    }
                }
            }
    }
)();

 {*dist*}
       </script>
</html>
    ]]
exports.TML_JS_JUMP=  [[

;exports.moduleist = [];
;exports.codegen   = "";

;(
    function () {
        var cls = exports.createNamespace("client");
        
        
        ////底层移植数据结构
        cls.SceneVO  = function (e) {
            if(e) {
                  if(e.sceneId) {
                     this.sceneId =  e.sceneId;
                  }
                  
                  if(e.sceneIndex != null) {
                     this.sceneIndex = e.sceneIndex;
                  }
                  
                  if(e.frames) {
                      this.frames = frames;
                  }
            } else {
                  this.sceneId    = "场景1";
                  this.sceneIndex = 0;
                  this.frames     = [];
            }
        }
        
        /////帧结构
        cls.FrameVO  = function (e) {
             if(e) {
                 if(e.frameIndex){
                    this.frameIndex = e.frameIndex;
                 }
                 
                 if(e.pos) {  ////定位标识
                     this.pos = e.pos;
                 }
    
                 if(e.plugins) {
                     this.plugins = e.plugins;
                 }
             } else {
                 this.frameIndex = 0;
                 this.pos  = null;
                 this.plugins = [];
             }
        }

   cls.ProjectVO = function (v) {
            this.name = "";
            this.deamonPlugins= {};
            this.plugins=  [];
            this.res    =  [];
            this.scripts=  [];
            this.type   =  0;
            this.opt    =  [];
            this.backgroundColor="";
            this.layers = [];
            this.modulelist=[];
            this.scenes = [];
       }
        
       cls.PluginVO = function () {
           
           this.name   = "";
           this.params = [];
           this.mod    = ""; ///类
           this.x =  0;
           this.y =  0;
           this.layer = 0;
           
           this.scripts = "";
           this.schema  = "";
           
           this.description = function () {
               var w   = exports.AppWidth  || window.innerWidth;
               var h   = exports.AppHeight || window.innerHeight;
        
               return  {
                   "name":this.name,
                   "params": this.params,
                   "mod":this.mod,
                   "x":this.x,
                   "y":this.y,
                   "layer":this.layer,
                   "scripts":this.scripts,
                   "schema":this.schema,
                   "xpos":(this.x / w),
                   "ypos":(this.y / h)
               }
           }
           
           
       }
    }
)();


if(exports.layers == null) {
    if(exports.createLayer != null) {
        exports.createLayer(); ///针对其他没有分层的应用
    }
    
    if(!exports.currLayer) {
        var f = document.createDocumentFragment();
        var p = document.createElement("div");
        p.id  = "layer0";
        
        var w   = exports.AppWidth || document.body.clientWidth;
        var h   = exports.AppHeight|| document.body.clientHeight;
    
    
        p.style.width = w+ 'px';
        p.style.height= h+ 'px';
        p.style.background ="#232628";
        f.appendChild(p);
        document.body.appendChild(f);
        
        exports.currLayer = document.getElementById("layer0") ;
        exports.currLayer.addChild = function (node) {
                var c = document.createDocumentFragment();
                c.appendChild(node);
                exports.currLayer.appendChild(c);
        }
        exports.layers = [exports.currLayer];
    }
}
;exports.initProject  = function () {

     exports.AppWidth = window.innerWidth;
     exports.AppHeight= window.innerHeight;
     
     var cls = exports.createNamespace("client");
     if(exports.currProject == null) {
         exports.currProject = new cls.ProjectVO();
     }
     var eax = exports.currProject;
     
     if(eax.scenes.length == 0) {
         eax.scenes[0] = new cls.SceneVO();
     }
     
     exports.currScene =  eax.scenes[0];
     
     if(exports.currScene.frames.length == 0) {
         exports.currScene.frames[0] = new cls.FrameVO();
     }
     exports.currFrame =  exports.currScene.frames[0];
     exports.currFrameIndex =0;
     exports.currSceneIndex =0;
}

exports.invokeScript =  function(str, obj) {
    var tmp = [];
    tmp.push('\n;[App(exports.cls.Module, "'+obj.name+'", function(message){\n');
    tmp.push('\tswitch(message.msgId) {\n');
    tmp.push('\tcase "Init":\n');
    tmp.push('\t\t;(\n'+obj.scripts+'\n)(message.data);\n')
    tmp.push('\tbreak;\n')
    tmp.push('}})];\n')
    return tmp.join("");
}

exports.makeView = function (ebx) {
   return function () {
        var cls = exports.createNamespace("plugin");
        if(!ebx.mod) {
            return;
        }
        var w   = exports.AppWidth  || document.body.clientWidth;
        var h   = exports.AppHeight || document.body.clientHeight;
        console.log(w,h)
        mod = cls[ebx.mod];
        
        if(mod == null) {
            return;
        }
        var plug = new mod();
        if(ebx.params.length > 0) {
                var datac ={};
                for( var k in ebx.params) {
                    if(!ebx.params[k].key) {
                        continue;
                    }
                    datac[ebx.params[k].key] = ebx.params[k].value
                }
                plug.init(datac);
        }
        
        var view = plug.getView();
        
        if(view == null) {
              return;
        }
        if(view.pos == null) {
            view.style.position="absolute";
            view.style.top = h* ebx.ypos + "px";
            view.style.left= w* ebx.xpos + "px";
        } else {
            view.pos(w * ebx.xpos, h* ebx.ypos);
        }
        
        if(view.scale == null) {
            
        } else {
            view.scale(exports.dpiw ,exports.dpiw);
        }
        
        
        console.log(plug.update);
        if(plug.update != null) {
              plug.update();
        }
                        
        exports.currLayer.addChild(view);
        exports.moduleist.push(plug);
        plug.vo = ebx;
        if(ebx.scripts) {
            eval(exports.invokeScript(ebx.scripts, ebx));
            [Message("Init", ebx.name, plug)];
        }
        }(ebx);
}

;( function (e) {
    if(exports.currLayer == null) {
        exports.currLayer = exports.layers[0];
    }
    
    try{
       e = JSON.parse(e.value);
    }catch (e) {
       e = {}
    }
    
    exports.initProject();
    
    
    var eax = null;
    var mod = null;
    ///偏移量设置
    var w   = exports.AppWidth || document.body.clientWidth;
    var h   = exports.AppHeight|| document.body.clientHeight;
    exports.dpiw = w / e.dpiw ;
    exports.dpih = h / e.dpih ;
    ///创建layer
    ///创建daemon
   
     
    if(e.daemon) {
        for(var k in e.daemon) {
            eax = e.daemon[k];
            if(!eax.mod) {
                continue;
            }
            mod = cls[eax.mod];
            var plug = new mod();
            plug.init();
        }
    }
    
    ///0724 移植
    if(e.scenes) {
       var len = e.scenes.length;
       var edx = e.scenes;
       var cls = exports.createNamespace("client");
       for( var i=0;i<len; i++ ) {///scene
           var s= edx[i].frames;
           var sIns     = new cls.SceneVO();
           sIns.sceneId = edx[i].name ;
           sIns.frames  = [];
           exports.currProject.scenes[i] = sIns;
           
           for(var k=0,len=s.length; k < len; k++) { ///frame
               var p  = s[k];
               var esi= p.plugins;
               var ebp= esi.length;
               
               var fIns = new cls.FrameVO();
               sIns.frames[i] = fIns;
               exports.currFrame = fIns;
               for(var ecx =0; ecx < ebp; ecx ++) { ///plugin
                   exports.makeView(esi[ecx]);
               }
           }
       }
    }
    
    /////创建plugin
    if(e.plugins) {
        var len = e.plugins.length;
        var eax = e.plugins;
        var ebx = null;
        
        if(len > 0) {
            for(var i =0; i< len; i ++) {
                ebx = eax[i];
                (function (ebx) {
                        if(!ebx.mod) {
                            return;
                        }
                        var w   = exports.AppWidth  || document.body.clientWidth;
                        var h   = exports.AppHeight || document.body.clientHeight;
                        mod = cls[ebx.mod];
                        
                        if(mod == null) {
                            return;
                        }
                        var plug = new mod();
                        if(ebx.params.length > 0) {
                                var datac ={};
                                for( var k in ebx.params) {
                                    if(!ebx.params[k].key) {
                                        continue;
                                    }
                                    datac[ebx.params[k].key] = ebx.params[k].value
                                }
                                plug.init(datac);
                        }
                        
                        var view = plug.getView();
                        
                        if(view == null) {
                              console.log("view==null");
                              return;
                        }
                        if(view.pos == null) {
                            view.style.position="absolute";
                            view.style.top = h* ebx.ypos + "px";
                            view.style.left= w* ebx.xpos + "px";
                        } else {
                            view.pos(w * ebx.xpos, h* ebx.ypos);
                        }
                        
                        
                        if(view.scale != null) {
                          view.scale(exports.dpiw ,exports.dpiw);  
                        } 
                        console.log(plug.update);
                        if(plug.update != null) {
                            plug.update();
                        }
                        exports.currLayer.addChild(view);
                        exports.moduleist.push(plug);
                        plug.vo = ebx;
                        if(ebx.scripts) {
                            eval(exports.invokeScript(ebx.scripts, ebx));
                            [Message("Init", ebx.name, plug)];
                        }
                })(ebx);
            }
        }
    }
})({*code*})
]]exports.TML_VIEW_DESIGN=[[
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
        
    <title>搭建系统</title>
        
     {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
      
        <style>
              html, body {
              height: 100%;
          }
          body {
          }
          .page-content {
              padding-top: 3.125rem;
              min-height: 100%;
              height: 100%;
          }
      </style>
      <script>
      var module_list = {*modules*}
      </script>
  </head>
  <body>
         <div>
             <div class="progress small" id="loading" data-parts="true" data-role="progress" data-value="0" data-colors="{&quot;bg-red&quot;: 33, &quot;bg-yellow&quot;: 66, &quot;bg-cyan&quot;: 90, &quot;bg-green&quot;: 100}">
                 <div class="bar bg-green" style="width: 98%;"></div></div>
         </div>
        {*menu*}
        <!--
          content
        -->
        <div class="grid" id="container" style="opacity: 0;">
            <div >
                <div class="cell">
                    <ul class="sidebar no-responsive-future compact" id="sidebarLeft">
                            <li label-role="mymodule">
                                <a href="#">
                                   <span class="mif-apps icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="我的模块|"></span>
                                       <span class="title">我的模块</span>
                                </a>
                            </li>
                            
                             <li label-role="mycode">
                                <a href="#">
                                   <span class="mif-settings-ethernet icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="我的脚本|"></span>
                                   <span class="title">我的脚本</span>
                                </a>
                            </li>
                            
                            <!--
                            <li label-role="myres">
                                <a href="#" >
                                   <span class="mif-images icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="资源管理|"></span>
                                   <span class="title">资源管理</span>
                                </a>
                            </li>
                            
                        
                            
                            <li label-role="viewlayer">
                                <a href="#">
                                   <span class="mif-layers icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="图层管理|"></span>
                                   <span class="title">图层管理</span>
                                </a>
                            </li>
                            
                             <li label-role="viewsetting">
                                <a href="#">
                                   <span class="mif-wrench icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="页面设置|"></span>
                                   <span class="title">页面设置</span>
                                </a>
                            </li>
                            -->
                        </ul>
                        
                        <div id="leftCotnentCloseBtn">
                            <a href="javascript:void(0)"><span class="mif-chevron-thin-left icon"></span></a>
                        </div>
                           
                        <div class="grid" id="sidebarLeftContent"  >
                            <!--
                              modulelist sheet
                            -->
                            
                            <div class="row">
                                <div class="cell" id="leftModuleContent">
                                    <a class="shortcut-button" onclick="exports.addmodules(event)" style="margin-top: 250px; margin-left: 155px; font-size: 14px;">
                                        <span class="icon mif-plus icon"></span>
                                        <span class="title">添加模块</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                </div>
                <!--
                    content
                -->
                            <div class="h5-screen">
                                    <div class="mask">
                                        <span class="mif-plus icon"></span>
                                    </div>
                                    {*mLayout*}
                            </div>
                 
                            <div class="probs">
                                <div class="panel">
                                    <div class="heading">
                                        <span class="icon mif-chevron-thin-right" id="clostRight"></span>
                                        <span class="title">模块属性 </span>
                                        <span class="input-control text"  style="width: 100%; ">
                                                <input type="text" id="target3" value="暂无脚本,请添加脚本方式">
                                                 <button class="button dropdown-toggle"><span class="mif-file-code icon"></span></button>
                                                
                                                 <div data-role="dropdown" data-no-close="true" class="d-menu" style="right: 0px; top: 100%; display: none;">
                                                            <li><a href="javascript:void(0)" onclick="exports.embedcode()"><span class="mif-file-binary icon"></span>嵌入代码</a></li>
                                                            <li><a href="javascript:void(0)"><span class="mif-file-binary icon"></span>上传脚本</a></li>
                                                </div>
                                       </span>
                                    </div>
                                    <div class="content" style="margin-top: 28px;">
                                                <table class="table border bordered hovered cell-hovered" style=" overflow-y:auto;">
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                    </div>
                                </div>
                            </div>
                            
        </div>
        <div data-role="dialog" id="dialog" data-close-button="true">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-file-binary icon"></span></span>
                <span class="window-caption-title" id="embedCodeTitle"></span>
                <span class="btn-close"></span>
            </div>
            <pre id="editor" style="font-family:Monaco, Menlo,SimSun;">
            </pre>
        </div>


        <div data-role="charm" id="showResult" class="charm right-side" 
        style="opacity: 1; display: block; bottom: 0px; top: auto; left: 0px; right: 0px;">
            <span class="charm-closer"></span>
            <span id="linkAddr"></span>
        </div>
        <!--
          描述：模块抽屉-所有模块
        -->
        <div class="window" data-role='dialog' id="allmodules">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-plus icon"></span></span>
                <span class="window-caption-title">添加模块到本地</span>
                <span class="btn-close" id="closeBtn" onclick="exports.closeModuleList(event)"></span>
            </div>
            
            <div class="window-content" style="height: 500px;width: 550px;">
                        <div class="tabcontrol" data-role="tabcontrol">
                                <ul class="tabs">
                                    <li class="active"><a href="#frame_1_1">该layout下模块</a></li>
                                    <li class=""><a href="#frame_1_2">通用模块</a></li>
                                </ul>
                                <div class="frames">
                                    <div class="frame" id="frame_1_1" style="display: block;">
                                           <div class="listview padding10 list-type-icons" data-role="listview" 
                                           id="moduleListView" data-on-list-click="exports.addModuleToLocal(list)">
                                           </div>
                                    </div>
                                    <div class="frame" id="frame_1_2" style="display: none;"></div>
                                </div>
                         </div>
            </div>
        </div>
        {*src*}              
  </body>
</html>

]]exports.TML_VIEW_HELP=[[

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>搭建系统</title>
      {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
        <style>
            html, body {
            height: 100%;
        }
        body {
        }
        .page-content {
            padding-top: 3.125rem;
            min-height: 100%;
            height: 100%;
        }
      </style>
      
</head>
<body>
    {*menu*}
        

    <div class="page-content">
        <div class="grid">
                <div class="row ">
                    <div class="cell">
                        <ul class="step-list">
                            <li>
                                <h2 class="no-margin-top">搭建系统的目标</h2>
                                <hr class="bg-red">
                                <div>
                                    <p class="text-accent">
                                                                目前只是技术预研demo，我的目标是使这个搭建系统可以支持但不限于apollox引擎的搭建，所以
                                                                在系统的灵活度和复杂度上做了取舍，整个系统的生命周期都可以hook和进行切面编程来拓展。
                                                                我尽量保持这个系统的简单和简洁。另外这个阶段的目标我觉得需要聚焦在快速搭建和模块的复用能力上。
                                                            </br>    
                                                                感谢家人和同事对我工作的支持。
                                    </p>
                                           
                                    <address>
                                        <strong>钟元</strong><br>
                                                                                阿里大优酷-大剧技术团队<br>
                                        wangwenbo@alibaba-inc.com<br>
                                    </address>
                                    
                                    <br>
                                    <br>
                                </div>
                            </li>
                            <li>
                                <h2 class="no-margin-top">未来支持的目标</h2>
                                <hr class="bg-green">
                                <div>
                                     <div class="cell">
                                        <h4></h4>
                                        <ol class="numeric-list square-marker">
                                            <li>apollox 2d 引擎</li>
                                            <li>阿里的AFT动画引擎</li>
                                            <li>阿里的hilo游戏引擎</li>
                                            <li>sam.js隔离框架</li>
                                            <li>和更多的引擎和框架</li>
                                        </ol>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <h2 class="no-margin-top">贡献者</h2>
                                <hr class="bg-blue">
                                <div>
                                    子之,渚薰,钟元
                                    <br>
                                    <br>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
    </div>
</body>
</html>
]]exports.TML_VIEW_MISSION_DESIGN=[[
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
        
    <title>搭建系统</title>
        
     {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
      
        <style>
              html, body {
              height: 100%;
          }
          body {
          }
          .page-content {
              padding-top: 3.125rem;
              min-height: 100%;
              height: 100%;
          }
      </style>
      <script>
      var module_list = {*modules*}
      </script>
      <script src="//g.alicdn.com/mtb/lib-mtop/2.3.15/mtop.js"></script>
  </head>
  <body>
        
         <div>
             <div class="progress small" id="loading" data-parts="true" data-role="progress" data-value="0" data-colors="{&quot;bg-red&quot;: 33, &quot;bg-yellow&quot;: 66, &quot;bg-cyan&quot;: 90, &quot;bg-green&quot;: 100}">
                 <div class="bar bg-green" style="width: 98%;"></div></div>
         </div>
        {*menu*}
        <!--
          content
        -->
        <div class="grid" id="container" style="opacity: 0;margin-top:1px;">
            <div >
                <div class="cell">
                    <ul class="sidebar no-responsive-future compact" id="sidebarLeft">
                            <li label-role="myTool">
                                <a href="#" >
                                   <span class="mif-images icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="工具管理|"></span>
                                   <span class="title">工具管理</span>
                                </a>
                            </li>
                        </ul>
                        
                        <div id="leftCotnentCloseBtn">
                            <a href="javascript:void(0)"><span class="mif-chevron-thin-left icon"></span></a>
                        </div>
                           
                        <div class="grid" id="sidebarLeftContent"  >
                            <!--
                              modulelist sheet
                            -->
                            
                            <div class="row">
                                <div class="cell" id="leftModuleContent">
                                    <a class="shortcut-button" onclick="exports.addmodules(event)" style="margin-top: 250px; margin-left: 155px; font-size: 14px;">
                                        <span class="icon mif-plus icon"></span>
                                        <span class="title">添加模块</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                </div>
                <!--
                    content
                -->
                            <div class="h5-screen" style="display:none;margin-top: 5px;">
                            </div>
                            <div class="probs">
                                <div class="panel">
                                    <div class="heading">
                                        <span class="icon mif-chevron-thin-right" id="clostRight"></span>
                                        <span class="title">模块属性 </span>
                                        <span class="input-control text"  style="width: 100%; ">
                                                <input type="text" id="target3" value="暂无脚本,请添加脚本方式">
                                                 <button class="button dropdown-toggle"><span class="mif-file-code icon"></span></button>
                                                 <div data-role="dropdown" data-no-close="true" class="d-menu" style="right: 0px; top: 100%; display: none;">
                                                            <li><a href="javascript:void(0)" onclick="exports.embedcode()"><span class="mif-file-binary icon"></span>嵌入代码</a></li>
                                                            <li><a href="javascript:void(0)"><span class="mif-file-binary icon"></span>上传脚本</a></li>
                                                </div>
                                       </span>
                                    </div>
                                    <div class="content" style="margin-top: 28px;">
                                                <table class="table border bordered hovered cell-hovered" style=" overflow-y:auto;">
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                    </div>
                                </div>
                            </div>
        </div>
        <div data-role="dialog" id="dialog" data-close-button="true">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-file-binary icon"></span></span>
                <span class="window-caption-title" id="embedCodeTitle"></span>
                <span class="btn-close"></span>
            </div>
            <pre id="editor" style="font-family:Monaco, Menlo,SimSun;">
            </pre>
        </div>


        <div data-role="charm" id="showResult" class="charm right-side" 
        style="opacity: 1; display: block; bottom: 0px; top: auto; left: 0px; right: 0px;">
            <span class="charm-closer"></span>
            <span id="linkAddr"></span>
        </div>
        <!--
          描述：模块抽屉-所有模块
        -->
        <div class="window" data-role='dialog' id="allmodules">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-plus icon"></span></span>
                <span class="window-caption-title">添加模块到本地</span>
                <span class="btn-close" id="closeBtn" onclick="exports.closeModuleList(event)"></span>
            </div>
            
            <div class="window-content" style="height: 500px;width: 550px;">
                        <div class="tabcontrol" data-role="tabcontrol">
                                <ul class="tabs">
                                    <li class="active"><a href="#frame_1_1">该layout下模块</a></li>
                                    <li class=""><a href="#frame_1_2">通用模块</a></li>
                                </ul>
                                <div class="frames">
                                    <div class="frame" id="frame_1_1" style="display: block;">
                                           <div class="listview padding10 list-type-icons" data-role="listview" 
                                           id="moduleListView" data-on-list-click="exports.addModuleToLocal(list)">
                                           </div>
                                    </div>
                                    <div class="frame" id="frame_1_2" style="display: none;"></div>
                                </div>
                         </div>
            </div>
        </div>
        <script src="/build/task.design.min.js" type="text/javascript"></script>
        {*src*}              
  </body>
</html>

]]exports.TML_VIEW_PROFILE=[[

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>搭建系统</title>
     {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
      <style>
            html, body {
            height: 100%;
        }
        body {
        }
        .page-content {
            padding-top: 3.125rem;
            min-height: 100%;
            height: 100%;
        }
      </style>
</head>
<body>
    {*menu*}
    <div class="page-content">
        <div class="flex-grid no-responsive-future" style="height: 100%;">
            <div class="row" style="height: 100%">
                <div class="cell auto-size padding20 bg-white" id="cell-content">
                    <h1 class="text-light">我的搭建 </h1>
                    <hr class="thin bg-grayLighter">
                     <button class="button primary" onclick="metroDialog.open('#dialog')"><span class="mif-plus icon"></span> 创建搭建</button>
                     <button class="button primary" onclick="metroDialog.open('#dialog2')"><span class="mif-plus icon"></span> 创建任务</button>
                     <div class="listview  padding set-border list-type-icons" id="myProject" 
                          data-role="listview" id="lv1" data-on-list-click="exports.invokeBuildView(list.find('.list-title').text())">
                     </div>
                </div>
            </div>
        </div>
    
    
      <div class="window-caption" data-role='dialog' id="dialog">
        <div class="window-caption">
            <span class="window-caption-icon"><span class="mif-plus icon"></span></span>
            <span class="window-caption-title">创建项目</span>
            <span class="btn-close" id="closeBtn"></span>
        </div>
        
        <div class="window-content" style="height: 430px;width: 440px;">
            <div class="grid">
                <div class="cell">
                        <div class="input-control text full-size">
                            <input type="text" placeholder="填入名称" id="appName">
                        </div>
                        
                        <!--<div class="input-control text full-size" data-role="input">
                            <input type="text" placeholder="填入gitlab地址" id="gitlab" value="git@gitlab.alibaba-inc.com:apollox/apollox-mods.git">
                        </div>-->
                        
                        <div class="input-control text full-size" data-role="input">
                                   <input type="text" placeholder="类型"  id="appType" >
                                   <button class="button dropdown-toggle">类型</button>
                                   <ul class="split-content d-menu" data-role="dropdown">
                                        <li><a href="javascript:void(0);" data-config="poplayer 页面" onclick="exports.fselect2Input(event)">poplayer 页面</a></li>
                                        <li><a href="javascript:void(0);" data-config="apollox2d 引擎" onclick="exports.fselect2Input(event)">apollox2d 引擎</a></li>
                                        <li><a href="javascript:void(0);" data-config="metro 页面" onclick="exports.fselect2Input(event)">metro 页面</a></li>
                                    </ul>
                        </div>
                        
                        <div class="cell">
                                <div id="button-group-2" data-role="group" data-group-type="multi-state" data-button-style="class">
                                    <button class="button alert">模块部件</button>
                                    <button class="button warning">单页面应用</button>
                                </div>
                        </div>
                        
                        <div>
                            <button class="button" id="saveBtn"> 保存</button>
                            <button class="button" id="cancelBtn"> 取消</button>
                        </div>
                </div>
            </div>
        </div>
    </div>
    
    
        
      <div class="window-caption" data-role='dialog' id="dialog2">
        <div class="window-caption">
            <span class="window-caption-icon"><span class="mif-plus"></span></span>
            <span class="window-caption-title">创建任务</span>
            <span class="btn-close" id="closeTaskBtn"></span>
        </div>
        
        <div class="window-content" style="height: 500px;width: 500px;">
            <div class="grid">
                <div class="cell">
<table class="table striped" id="taskEditor" style="width: 490px;">
                <tbody>
                <tr>
                    <td style="width: 100px;">应用标识</td>
                    <td>
                        <div class="input-control text full-size">
                            <input type="text" id="appKey">
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 100px;">发布环境</td>
                    <td>
                         <div class="split-button active-container">
                            <button class="button" id="missionEnvBtn">线上环境</button>
                            <button class="split dropdown-toggle"></button>
                            <ul class="split-content d-menu" data-role="dropdown" style="display: none;">
                                <li><a href="javascript:void(0);" data-config="日常环境" onclick="exports.fselectEnvInput(event)">日常环境</a></li>
                                <li><a href="javascript:void(0);" data-config="预发环境" onclick="exports.fselectEnvInput(event)">预发环境</a></li>
                                <li><a href="javascript:void(0);" data-config="线上环境" onclick="exports.fselectEnvInput(event)">线上环境</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td>任务类型</td>
                    <td>
                        <div class="split-button active-container">
                            <button class="button" id="missionTypeBtn">类型A</button>
                            <button class="split dropdown-toggle"></button>
                            <ul class="split-content d-menu" data-role="dropdown" style="display: none;">
                                <li><a href="javascript:void(0);" data-config="类型A" onclick="exports.fselectTypeInput(event)">类型A</a></li>
                                <li><a href="javascript:void(0);" data-config="类型B" onclick="exports.fselectTypeInput(event)">类型B</a></li>
                                <li><a href="javascript:void(0);" data-config="类型C" onclick="exports.fselectTypeInput(event)">类型C</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
                 <tr>
                    <td>开始时间</td>
                    <td>
                        <div class="input-control text full-size" data-locale="zhCN" data-role="datepicker">
                            <input type="text" readonly="readonly" id="missionStartTime">
                            <button class="button" type="button"><span class="mif-calendar"></span></button>
                        <div class="calendar calendar-dropdown" style="position: absolute; max-width: 100%; z-index: 1000; top: 100%; left: 0px; display: none;"><div class="calendar-grid"><div class="calendar-row no-margin calendar-header"><div class="calendar-cell align-center"><a class="btn-previous-year" href="#">-</a></div><div class="calendar-cell align-center"><a class="btn-previous-month" href="#">〈</a></div><div class="calendar-cell sel-month align-center"><a class="btn-select-month" href="#">Nov 2017</a></div><div class="calendar-cell align-center"><a class="btn-next-month" href="#">〉</a></div><div class="calendar-cell align-center"><a class="btn-next-year" href="#">+</a></div></div><div class="calendar-row week-days calendar-subheader"><div class="calendar-cell align-center day-of-week"><div>Su</div></div><div class="calendar-cell align-center day-of-week"><div>Mo</div></div><div class="calendar-cell align-center day-of-week"><div>Tu</div></div><div class="calendar-cell align-center day-of-week"><div>We</div></div><div class="calendar-cell align-center day-of-week"><div>Th</div></div><div class="calendar-cell align-center day-of-week"><div>Fr</div></div><div class="calendar-cell align-center day-of-week"><div>Sa</div></div></div><div class="calendar-row"><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell align-center day"><div><a href="#">1</a></div></div><div class="calendar-cell align-center day"><div><a href="#">2</a></div></div><div class="calendar-cell align-center day"><div><a href="#">3</a></div></div><div class="calendar-cell align-center day"><div><a href="#">4</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">5</a></div></div><div class="calendar-cell align-center day"><div><a href="#">6</a></div></div><div class="calendar-cell align-center day"><div><a href="#">7</a></div></div><div class="calendar-cell align-center day"><div><a href="#">8</a></div></div><div class="calendar-cell align-center day selected"><div><a href="#">9</a></div></div><div class="calendar-cell align-center day"><div><a href="#">10</a></div></div><div class="calendar-cell align-center day"><div><a href="#">11</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">12</a></div></div><div class="calendar-cell align-center day"><div><a href="#">13</a></div></div><div class="calendar-cell align-center day"><div><a href="#">14</a></div></div><div class="calendar-cell align-center day"><div><a href="#">15</a></div></div><div class="calendar-cell align-center day"><div><a href="#">16</a></div></div><div class="calendar-cell align-center day"><div><a href="#">17</a></div></div><div class="calendar-cell align-center day"><div><a href="#">18</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">19</a></div></div><div class="calendar-cell align-center day"><div><a href="#">20</a></div></div><div class="calendar-cell align-center day"><div><a href="#">21</a></div></div><div class="calendar-cell align-center day"><div><a href="#">22</a></div></div><div class="calendar-cell align-center day today"><div><a href="#">23</a></div></div><div class="calendar-cell align-center day"><div><a href="#">24</a></div></div><div class="calendar-cell align-center day"><div><a href="#">25</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">26</a></div></div><div class="calendar-cell align-center day"><div><a href="#">27</a></div></div><div class="calendar-cell align-center day"><div><a href="#">28</a></div></div><div class="calendar-cell align-center day"><div><a href="#">29</a></div></div><div class="calendar-cell align-center day"><div><a href="#">30</a></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div></div></div></div></div>
                        <span>
                            <div class="input-control select full-size">
                                <select id="missionStartTime_h">
                                    <option>00.00</option>
                                    <option>01.00</option>
                                    <option>02.00</option>
                                    <option>03.00</option>
                                    <option>04.00</option>
                                    <option>05.00</option>
                                    <option>06.00</option>
                                    <option>07.00</option>
                                    <option>08.00</option>
                                    <option>09.00</option>
                                    <option>10.00</option>
                                    <option>11.00</option>
                                    <option>12.00</option>
                                    <option>13.00</option>
                                    <option>14.00</option>
                                    <option>15.00</option>
                                    <option>16.00</option>
                                    <option>17.00</option>
                                    <option>18.00</option>
                                    <option>19.00</option>
                                    <option>20.00</option>
                                    <option>21.00</option>
                                    <option>22.00</option>
                                    <option>23.00</option>
                                </select>
                            </div>
                        </span>
                    </td>
                </tr>
                 <tr>
                    <td>结束时间</td>
                     <td>
                        <div class="input-control text full-size" data-locale="zhCN" data-role="datepicker" data-on-select="console.log(d +'\n'+ d0)">
                            <input type="text" readonly="readonly" id="missionEndTime">
                            <button class="button" type="button"><span class="mif-calendar"></span></button>
                        <div class="calendar calendar-dropdown" style="position: absolute; max-width: 100%; z-index: 1000; top: 100%; left: 0px; display: none;"><div class="calendar-grid"><div class="calendar-row no-margin calendar-header"><div class="calendar-cell align-center"><a class="btn-previous-year" href="#">-</a></div><div class="calendar-cell align-center"><a class="btn-previous-month" href="#">〈</a></div><div class="calendar-cell sel-month align-center"><a class="btn-select-month" href="#">Nov 2017</a></div><div class="calendar-cell align-center"><a class="btn-next-month" href="#">〉</a></div><div class="calendar-cell align-center"><a class="btn-next-year" href="#">+</a></div></div><div class="calendar-row week-days calendar-subheader"><div class="calendar-cell align-center day-of-week"><div>Su</div></div><div class="calendar-cell align-center day-of-week"><div>Mo</div></div><div class="calendar-cell align-center day-of-week"><div>Tu</div></div><div class="calendar-cell align-center day-of-week"><div>We</div></div><div class="calendar-cell align-center day-of-week"><div>Th</div></div><div class="calendar-cell align-center day-of-week"><div>Fr</div></div><div class="calendar-cell align-center day-of-week"><div>Sa</div></div></div><div class="calendar-row"><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell align-center day"><div><a href="#">1</a></div></div><div class="calendar-cell align-center day"><div><a href="#">2</a></div></div><div class="calendar-cell align-center day"><div><a href="#">3</a></div></div><div class="calendar-cell align-center day"><div><a href="#">4</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">5</a></div></div><div class="calendar-cell align-center day"><div><a href="#">6</a></div></div><div class="calendar-cell align-center day"><div><a href="#">7</a></div></div><div class="calendar-cell align-center day"><div><a href="#">8</a></div></div><div class="calendar-cell align-center day selected"><div><a href="#">9</a></div></div><div class="calendar-cell align-center day"><div><a href="#">10</a></div></div><div class="calendar-cell align-center day"><div><a href="#">11</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">12</a></div></div><div class="calendar-cell align-center day"><div><a href="#">13</a></div></div><div class="calendar-cell align-center day"><div><a href="#">14</a></div></div><div class="calendar-cell align-center day"><div><a href="#">15</a></div></div><div class="calendar-cell align-center day"><div><a href="#">16</a></div></div><div class="calendar-cell align-center day"><div><a href="#">17</a></div></div><div class="calendar-cell align-center day"><div><a href="#">18</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">19</a></div></div><div class="calendar-cell align-center day"><div><a href="#">20</a></div></div><div class="calendar-cell align-center day"><div><a href="#">21</a></div></div><div class="calendar-cell align-center day"><div><a href="#">22</a></div></div><div class="calendar-cell align-center day today"><div><a href="#">23</a></div></div><div class="calendar-cell align-center day"><div><a href="#">24</a></div></div><div class="calendar-cell align-center day"><div><a href="#">25</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">26</a></div></div><div class="calendar-cell align-center day"><div><a href="#">27</a></div></div><div class="calendar-cell align-center day"><div><a href="#">28</a></div></div><div class="calendar-cell align-center day"><div><a href="#">29</a></div></div><div class="calendar-cell align-center day"><div><a href="#">30</a></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div></div></div></div></div>
                        <span>
                            <div class="input-control select full-size">
                                <select id="missionEndTime_h">
                                    <option>00.00</option>
                                    <option>01.00</option>
                                    <option>02.00</option>
                                    <option>03.00</option>
                                    <option>04.00</option>
                                    <option>05.00</option>
                                    <option>06.00</option>
                                    <option>07.00</option>
                                    <option>08.00</option>
                                    <option>09.00</option>
                                    <option>10.00</option>
                                    <option>11.00</option>
                                    <option>12.00</option>
                                    <option>13.00</option>
                                    <option>14.00</option>
                                    <option>15.00</option>
                                    <option>16.00</option>
                                    <option>17.00</option>
                                    <option>18.00</option>
                                    <option>19.00</option>
                                    <option>20.00</option>
                                    <option>21.00</option>
                                    <option>22.00</option>
                                    <option>23.00</option>
                                </select>
                            </div>
                        </span>
                    </td>
                    
                </tr>
                <tr>
                    <td></td>
                    <td><button class="button primary" onclick="exports.createMission()"><span class="mif-plus icon"></span> 保存任务项目</button></td>
                </tr>
                </tbody></table>                        
                </div>
            </div>
        </div>
    </div>
     <footer>
    <div class="bg-steel no-tablet-portrait no-phone">
        <div class="container padding20 fg-white">
            <div class="carousel bg-transparent" data-role="carousel" data-controls="false" data-markers="false" data-effect="fade" data-height="150" style="width: 100%; height: 200px;">
                <div class="slide fg-white">
                    <div class="place-left" style="margin-right: 20px">
                    <span class="mif-space-shuttle icon" style="width:44px;font-size:44px;"></span>
                    </div>
                    <h1>感谢使用apollox搭建平台</h1>
                    <p>如果你需要以开发者身份并且发布模块,贡献代码请加入&nbsp;</p>
                    <a class="button success" href="/Dev/Get.mxml">开发者</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
            <div class="listview  list-type-listing" data-on-list-click="navgateUrl(list)" data-role="listview" style="min-height: 30px;margin-top:15px;" id="lv1">
                    <div class="listview  list-type-listing" data-on-list-click="navgateUrl(list)" data-role="listview" style="min-height: 30px;margin-bottom:15px;" id="lv1">
                        <div class="list" item-key="//mt2.alibaba-inc.com">
                            <img src="//mt2.alibaba-inc.com/assets/img/logo.png" class="list-icon">
                            <span class="list-title">mt2平台</span>
                        </div>
                       
                        <div class="list" item-key="//aone.alibaba-inc.com">
                            <img src="//gtms03.alicdn.com/tps/i3/TB124nHGXXXXXXJXFXXSrT52pXX-190-170.png" class="list-icon">
                            <span class="list-title">阿里巴巴技术协会</span>
                        </div>
                        
                        <div class="list" item-key="//lark.alipay.com/">
                            <img src="//zos.alipayobjects.com/rmsportal/lQoPkzilBAnSDpn.svg" class="list-icon">
                            <span class="list-title">云雀</span>
                        </div>
                        
                        <div class="list" item-key="//aone.alibaba-inc.com">
                            <img src="//ata2-img.cn-hangzhou.img-pub.aliyun-inc.com/d8f598a517efcded5f9ac0a1c5f19b2e.png" class="list-icon">
                        <span class="list-title">aone</span>
            </div>
    </div>
    <div class="align-center padding0 text-small">
    </div>
</footer>
<script>function navgateUrl(url) {window.open($(url).attr("item-key"))} </script>
</body>
</html>

]]exports.TML_VIEW_ERROR=[[

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>搭建系统</title>
      {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
        <style>
            html, body {
            height: 100%;
        }
        body {
        }
        .page-content {
            padding-top: 3.125rem;
            min-height: 100%;
            height: 100%;
        }
      </style>
      
</head>
<body>
    {*menu*}
    <div class="bg-steel no-tablet-portrait no-phone">
        <div class="container padding20 fg-white">
            <div class="carousel bg-transparent" data-role="carousel" data-controls="false" data-markers="false"
             data-effect="fade" data-height="150" style="margin-Top:251px;width: 100%; height: 150px;">
                <div class="slide fg-white">
                    <h1>你所访问的页面在外太空，上车请联系司机。</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="padding10 bg-red fg-white text-accent">当你看到这页面的时候， 请不要惊讶，你需要的只是点击返回而已 <a class="button success" href="/">返回</a></div>
</body>
</html>
]]

do
        local cls = exports.createNamespace("auth");
        cls.get_cookies = function()
              local cookies = ngx.header["Set-Cookie"] or {}
              if type(cookies) == "string" then
                     cookies = {cookies}
              end
              return cookies
        end
    
        cls.add_cookie = function (cookie)
              local cookies = cls.get_cookies()
              table.insert(cookies, cookie)
              ngx.header['Set-Cookie'] = cookies
        end
     cls.AuthHandle = function () 
              local o = {};
              o.access_token = nil;
              o.openid  = nil;
              o.persistent_code=nil;
              o.sns_token = nil;
              o.register = function () 
                    local http = require "resty.http"  
                    local httpc = http.new() ;
                    local url     = "https://oapi.dingtalk.com/sns/gettoken?appid=dingoamr5ad1cbfuzpocez&appsecret=zIQ3YJDnqOsxzIrUdi5RIjg0ssaau9oI79-smtvZMnsBC0HdbK9E5Srr-hS2ZXaO"  
--                    local url     = "https://oapi.dingtalk.com/sns/gettoken?appid=dingoaqh6opuptwcq74kil&appsecret=lG2QzoubW1MiLi7aN2BfjHXvc0gQBPo38v65HgZkzcdQ05psG_G6jR-85Cr7_Kq5"  
                    local res, err = httpc:request_uri(url, {  
                        ssl_verify = false,
                        method   = "GET",  
                    })  
                    
                    if res == nil then
                      ngx.redirect("/Error/Get.mxml");
                      return;
                    end
                    if res.status == 200 then
                      local eax = cjson.decode(res.body);
                       o.access_token = eax["access_token"];
                    end
--                    ngx.say(res.body,1)
                 end
             
                o.getPersistentCode =  function (tmpcode) 
                      if  o.access_token  == nil then
                            return;
                      end
                      local url     = 'https://oapi.dingtalk.com/sns/get_persistent_code?access_token=' .. o.access_token ;
                      local http = require "resty.http"  
                      local httpc = http.new()  ;
                      local params = { };
                      params["tmp_auth_code"]=tmpcode;
                      
                      local res, err = httpc:request_uri(url, {  
                            ssl_verify = false,
                            method = "POST",  
                            body      = cjson.encode(params),  
                            headers = {
                                  ["Content-Type"] = "application/json",
                             }
                        }) ;
                       local eax = cjson.decode(res.body);
                       if res.status == 200 then
                            o.openid  = eax["openid"];
                            o.persistent_code = eax["persistent_code"];
                       end
--                       ngx.say(res.body,2)
                 end
        
                    o.get_sns_token = function () 
                            if  o.access_token  == nil then
                                  return;
                            end
                            
                            local url     = 'https://oapi.dingtalk.com/sns/get_sns_token?access_token=' .. o.access_token ;
                            local http = require "resty.http"  
                            local httpc = http.new()  ;
                            local params = { };
                            params["openid"]=o.openid;
                            params["persistent_code"]=o.persistent_code;
                            local res, err = httpc:request_uri(url, {  
                                  ssl_verify = false,
                                  method = "POST",  
                                  body      = cjson.encode(params),  
                                  headers = {
                                        ["Content-Type"] = "application/json",
                                   }
                              }) ;
                            local eax = cjson.decode(res.body);
                            
                            if res.status== 200 then
                              o.sns_token = eax["sns_token"];
                            end
--                            ngx.say(res.body,3)
                      end
       
                     o.getuserinfo = function () 
                             if  o.sns_token  == nil then
                                      local a = {}
                                      a["access_token"] =  o.access_token ;
                                      a["openid"]  = o.openid;
                                      a["persistent_code"] = o.persistent_code;
                                      a["sns_token"] = o.sns_token;
                                  ngx.say(cjson.encode(a));
                                  ngx.say("dingtalk auth failed")
                                  return;
                            end
                            local url     = 'https://oapi.dingtalk.com/sns/getuserinfo?sns_token=' .. o.sns_token ;
                            local http = require "resty.http"  
                            local httpc = http.new()  ;
                            local params = { };
                            params["sns_token"]=o.sns_token;
                            
                            local res, err = httpc:request_uri(url, {  
                                  ssl_verify = false,
                                  method = "GET",  
                                  headers = {
                                        ["Content-Type"] = "application/json",
                                   }
                              }) ;
                            local eax = cjson.decode(res.body);
--                            ngx.say(res.body);
                            if res.status== 200 then
                                   if eax['user_info'] then
                                              local userinfo = eax['user_info'];
                                              if userinfo["unionid"] then
                                                     cls.add_cookie("apollox_token="..userinfo["unionid"] .."; Path=/")
                                                     cls.add_cookie("apollox_user=" ..userinfo["nick"] .."; Path=/")
                                                     local cache  = exports.rdb_client;
                                                     local pname= exports.normalizeSavePath(userinfo["unionid"], null, "__user")
                                                     local ebx = cache.get(pname);
                                                     local user_info = {};
                                                     if  ebx == nil then
                                                         user_info['nick'] = userinfo["nick"];
                                                         user_info['gold'] = 0;  -- 金币
                                                         user_info['level'] = 0;  -- 等级 
                                                         user_info['licon'] = 0; -- 等级图标
                                                         user_info['isDev']= 0;-- 是否开发者
                                                         user_info['lastmodi'] = 0; --是否更新
                                                     else
                                                        user_info = cjson.decode(ebx);
                                                     end
                                       
                                                     local eax       = cjson.encode(user_info);
                                                     local eax       = cache.set(pname, eax) ;
--                                                  local cache   = ngx.shared.my_cache;
--                                                  local eax       = cache:set(userinfo["unionid"], userinfo["nick"]) ;
                                              end
                                              ngx.redirect("/Profile/Get.mxml");
                                   end
                            end
                     end
                    return o
                end
end


local AuthHandle_C = exports.auth.AuthHandle;
App(
   Module,
   "Auth",
   function ( message )
         local eax = message.data; 
         ngx.header["Content-Type"] = "text/plain";
         if message.msgId == "Get" then
            if  eax['code'] ~= nil then
                            local http = require "resty.http"  
                            local httpc = http.new()  ;
                            local cls = exports.createNamespace("auth");
                            local url     = 'http://127.0.0.1:8090' ;
                            local res, err = httpc:request_uri(url, {
                                  path = "/Auth/Get.mxml?code=" .. eax['code'],  
                                  method = "GET",  
                                  headers = {
                                        ["User-Agent"] = "apollox"
                                    }
                            }) ;
--                            ngx.log(ngx.ERR, url);
--                            ngx.log(ngx.ERR, res.body == nil);
                            local respStr = cjson.encode(res.body);
                            if res ~= nil and res.body then
                                local data = cjson.decode(res.body).data.user
                                local userinfo = cjson.decode(data)
                                if  not userinfo then
                                    ngx.redirect("/Error/Get.mxml");
                                    return
                                end
                                cls.add_cookie("apollox_token="..userinfo["uniq"] .."; Path=/")
                                cls.add_cookie("apollox_user=" ..userinfo["name"] .."; Path=/")
                                cls.add_cookie("apollox_avatar=" ..userinfo["img"] .."; Path=/")
                                
                                local cache  = exports.rdb_client;
                               local pname= exports.normalizeSavePath(userinfo["uniq"], null, "__user")
                               local ebx = cache.get(pname);
                               local user_info = {};
                               if  ebx == nil then
                                   user_info['nick'] = userinfo["name"];
                                   user_info['gold'] = 0;  -- 金币
                                   user_info['level'] = 0;  -- 等级 
                                   user_info['licon'] = 0; -- 等级图标
                                   user_info['isDev']= 0;-- 是否开发者
                                   user_info['lastmodi'] = 0; --是否更新
                               else
                                  user_info = cjson.decode(ebx);
                               end
                               local eax       = cjson.encode(user_info);
                               local eax       = cache.set(pname, eax) ;     
                            end
                            httpc:close();
                            ngx.redirect("/Profile/Get.mxml");
            end
         end
     end
);--开发者列表

exports.USER_DEV="dev_list"

App(
   Module,
   "Dev",
   function ( message ) 
        local eax = message.data;
        ngx.header["Content-Type"] = "text/html";
       
        if ngx.ctx.uid == nil then
                   ngx.say(cjson.encode({
                    ["res"]=-1,
                    ["error"]="not auth token"}));
                    return;
        end
      
        if message.msgId == "Get" then
--            local result,data  =  exports.addGold(message) ;
--            if result ~= 0 then
--                ngx.say(cjson.encode(data));
--            else
--                ngx.say(cjson.encode(data));
--            end
ngx.say("hi, this is not implements.")
        end
    end
);
App(
   Module,
   "User",
   function ( message ) 
        local eax = message.data;
        ngx.header["Content-Type"] = "text/html";
       
        if ngx.ctx.uid == nil then
                   ngx.say(cjson.encode({
                    ["res"]=-1,
                    ["error"]="not auth token"}));
                    return;
        end
      
        if message.msgId == "AddGold" then
            local result,data  =  exports.addGold(message) ;
            if result ~= 0 then
                ngx.say(cjson.encode(data));
            else
               ngx.say(cjson.encode(data));
            end
        end
    end
);


exports.addGold = function (message) 
      local uid = ngx.ctx.uid;
      local cache   = exports.rdb_client;
      local pname = exports.normalizeSavePath(uid, message, "__user");
      local pdata   = cache.get(pname);
      local ebx = cjson.decode(pdata);
      local totay = string.sub(ngx.utctime() , 1,11);
      if ebx['lastmodi'] == totay then
          return 0,ebx;
      end
      
      ebx['lastmodi'] = totay;
      ebx['gold'] = ebx['gold'] + 10;
      
      cache.set(pname, cjson.encode(ebx));
      return 1,ebx;
end  --@ 用户代码处理程序 
do 
    local cls = exports.createNamespace("client");
    cls.getPluginsScript = function (obj, hash) 
           local i      = 1;
           while i <= #obj do
                      if obj[i].id ~= nil then 
                           obj[i].name = obj[i].id;
                      end 
                      if obj[i].name ~= nil then 
                          if hash == nil then
                                hash = {}
                          end
                          hash[obj[i].name] = 1;
                      end
                      i = i + 1;
            end
    end
    cls.TML_SCRIPT_MODULE=[[
    [App(exports.cls.Module, "{{name}}", function (message) {
          switch(message.msgId) {
               case "Init":
               ({*scripts*})(message.data);
               break;
          }
    })]; 
    ]]
    --@转化客户脚本到模块
    cls.transScriptToModule = function (obj) 
          local cls = exports.createNamespace("client");
          local template = require "template"
          local render = template.compile(cls.TML_SCRIPT_MODULE);
          return render(obj)
    end
     --@分析客户脚本生成符号表
    cls.getClientScriptsCollection  =  function( obj )
       if obj['scenes'] ~= nil then
                local scenes = obj['scenes'] ;
                local collections= nil;
                local index = 1;
                
                while index <= #scenes do
                     local v = scenes[index];
                     
                     local frames = v.frames;
                    
                     for e,g  in pairs(frames) do
                          cls.getPluginsScript(g.plugins, collections);
                     end
                     index = index + 1;
                end
                return collections;
       end
       return nil;
    end
   
end

App(
   Module,
   "TestScript",
   function ( message ) 
      local eax = message.data;
      local __normal__= exports.normalizeSavePath;
      ngx.header["Content-Type"] = "text/html";
      if ngx.ctx.uid == nil then
                 ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not auth token"}));
                  return;
      end
      local uid = ngx.ctx.uid;
       if message.msgId == "Get"  then
           local cache = exports.rdb_client;
           local pname = __normal__(uid, message, eax['name']);
           local data     = cache.get(pname);
           if  data == nil then
                    ngx.say(cjson.encode({
                      ["res"]=-1,
                      ["error"]="not find data."}));
                      return;
           end
           local p       = cjson.decode(data);
           local cls     = exports.createNamespace("client");
           local rdata = cjson.decode(p["value"]);
           local data = nil;
           if rdata ~= nil then
           data  = cls.getClientScriptsCollection (rdata);
           end
           ngx.say(cjson.encode(data))
       end
   end
);
--@ip 

do
      exports.ip  = "127.0.0.1";
      
      exports.getIp = function () 
         local t = io.popen("/sbin/ifconfig | grep inet | grep Bcast | awk '{print(substr($2,6))}'")
         exports.ip = t:read("*all")
         exports.ip = string.sub(exports.ip, 0 , string.len(exports.ip) -1) ;
         return exports.ip;
      end
      
      exports.getIp();
end


App(
   Module,
   "Ip",
   function ( message ) 
       local __normal__ = exports.normalizeSavePath;
       ngx.header["Content-Type"] = "text/plain";
       if message.msgId == "Get" then
            ngx.say(exports.ip);
       end
   end
);--@保存客户端脚本接口
App(
   Module,
   "Client",
   function ( message ) 
       local __normal__ = exports.normalizeSavePath;
       ngx.header["Content-Type"] = "text/plain";
       local eax       = message.data;
       local cache   = exports.rdb_client;
       
       local pname = nil;
       
       if ngx.ctx.uid == nil then
                 ngx.say(cjson.encode({
                  ["res"]=-1,
                  ["error"]="not auth token"}));
                  return;
       end
       local uid = ngx.ctx.uid;
       
       if message.msgId == "GetScript" then
              ngx.say( exports.rdb_client.get("A"));
       end
       
       if message.msgId == "SetScript" then  --@ 保存代码
               pname = __normal__(uid, message, 'client/'..eax['name'] .. '/' ..eax['id'] ..".js");
               
               if eax["value"] ~= nil then
                     cache.set(pname,  eax["value"]);
                     ngx.say(cjson.encode({["res"]=0}));
                     return;
               end
               ngx.say(cjson.encode({["res"]=-1}));
       end
   end
);
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