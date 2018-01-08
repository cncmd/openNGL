--@保存客户端脚本接口
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
