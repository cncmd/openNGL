  --@ 用户代码处理程序 
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
