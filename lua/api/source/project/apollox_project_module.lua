 exports.PROJECT_INDEXER="__indexer__";
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
