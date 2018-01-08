 function  fsave (path, data) 
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
);