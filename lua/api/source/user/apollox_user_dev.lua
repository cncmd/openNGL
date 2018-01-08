--开发者列表

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
