local exports=require "sam"
local cjson    =require "cjson"
local App      =exports.App
local Module =exports.cls.Module
local Message=exports.Message

exports.SystemName='apollox搭建系统' ;

local module=require "api_module"

--@ App Route 模块
--@ API路由规则 [域名/api/version/module/message]
--@ /api/{ModuleName}/{MessageId}

--@ 应用程序域
ngx.header["Access-Control-Allow-Origin"]="*";

--@读取用户名称和验证
if ngx.var.cookie_apollox_token then
--      local cache   = ngx.shared.my_cache;
      local cache   = exports.rdb_client;
--      local eax       = cache:get(ngx.var.cookie_apollox_token) 
      local eax       = cache.get(ngx.var.cookie_apollox_token .. "user") 
      
      if(eax ~= nil)  then
          local user  = cjson.decode(eax);
          if user ~= nil then
                  ngx.ctx.username = user['nick'];
          end
      end
end
--@校验请求

if not ngx.ctx.username then
    ngx.ctx.username = "DEV";
end

ngx.ctx.uid = ngx.var.cookie_apollox_token;

local message = exports.getRequestMessage();

if message.data["sharekey"] ~= nil  then
  ngx.ctx.uid = ngx.decode_base64(message.data["sharekey"]);
  if message.to == "Set" then
      ngx.say("no access.")
  end
end

Message(message.msgId, message.modu,  message.data);