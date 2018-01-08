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
end