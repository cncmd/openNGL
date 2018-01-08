  local rdb_client =  {};
  rdb_client.RDB_HOST="http://127.0.0.1:8082/rdb/api/"
--  rdb_client.RDB_INSTANCE="5998477b-4f6b-441b-9b56-9e5ddf39deee";
  rdb_client.RDB_INSTANCE="2878205e-16fd-4e4a-9215-a1edc863835d";
  rdb_client.set = function (k, v) 
    local http      = require "resty.http"  
    local cjson    = require "cjson"
    local httpc     = http.new()  
    local url         =  exports.rdb_client.RDB_HOST .. "set.json";
    
    local params = {
      ["instance"] = exports.rdb_client.RDB_INSTANCE,
      ["args"] = {k,v}
    }
    
    local res, err = httpc:request_uri(url, {  
        method   = "POST",  
        body       = cjson.encode(params),  
    })  
   
   if res ~= nil and res.body ~= nil then
        local eax = cjson.decode(res.body);
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
          method   = "GET",  
          body       = cjson.encode(params),  
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