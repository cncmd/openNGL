
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
);