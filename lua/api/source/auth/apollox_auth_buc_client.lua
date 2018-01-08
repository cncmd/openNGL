

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
                    local o = AuthHandle_C();
                    o.register();
                    o.getPersistentCode( eax['code'] );
                    o.get_sns_token();
                    o.getuserinfo();
            end
         end
     end
);