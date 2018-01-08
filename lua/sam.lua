--@sam.lua framework for openresty.
local exports = {};
do
  exports.CONST ={};--常量的节区
  exports.DATA  ={};--全局动态数据的节区
  exports.SYMBOL={};--全局符号的节区
  exports.DATA  ={};--全局动态数据的节区
  exports.MODULE={};--模块的节区
  exports.LOCATION={};--静态路由
  
  exports.createNamespace = function (name)
    if exports[name] == nil 
    then
      exports[name] = {}
    end
    return exports[name];
  end
  exports.version = "1.0.0.1"
  exports.isstring = function (a) 
        return type(a) == 'string' 
  end
  
  exports.sprintf  = function (fmt, ...)
      local argc  = exports.utils.getParams(...);
      return string.format(fmt, unpack(argc))
  end
end
--TODO modules
do
  local cls = exports.createNamespace("cls");
  
  cls.peekMessage = function ()
    return {msgId=nil,all=nil,to=nil,from=nil,data=nil};
  end
  
  cls.MessageSender = {}
  cls.Module = {}
  cls.Model  = {}
  cls.View   = {}
  cls.Controller={}
  
  function cls.MessageSender:new()
      local o = {}
      setmetatable(o, self)
      self.__index = self
      
      self.getOneTarget=function (str)
        local notifies = exports.MODULE;
        if notifies[str] == nil
        then
           notifies[str] = {
           procMessage=function (msg) 
            ngx.redirect("/login.html") ;
           end
           };
        end
        return notifies[str];
      end
      
      self.notifyByAll = function (message) 
         local notifies = exports.MODULE;
         for k in ipairs(notifies) do
                self.getOneTarget(k).procMessage(message);
         end
      end
      
      self.notifyByOne = function (target , message) 
        target.procMessage(message);
      end
      
      self.notifyOnsending = function (message) 
        if message["all"] ~= nil then
            return self.notifyByAll(message);
        end
        if exports.isstring(message["to"]) then
            self.notifyByOne(self.getOneTarget(message["to"]), message);
        end
      end
      return o
  end
  cls.sender = cls.MessageSender:new();
  
  function cls.Module:new (modu_name) 
      local o = {}
      setmetatable(o, self)
      o.__index     = self
      o.modu_name   = modu_name ;
      o.fsm         = nil;
      o.sendMessage = function (message) 
            exports.cls.sender.notifyOnsending(message);    
      end
      
      o.getModuName = function () 
            return o.modu_name;
      end
      o.procMessage = function () end;
      exports.MODULE[modu_name] = o;
      
      return o
    end
    
    --TODO utils
    local utils = exports.createNamespace("utils");
    --请求
    
    utils.getTimer = function ()
      local t = os.clock()
      return t
    end
    
    --获取参数
    exports.utils.getParams = function (...)
      local params = { ... }
      if (arg == nil) then
        params = { ... }
        params = select("1",params)
      else
        params = arg
      end
      return params
    end
    
    --TODO tools
    function exports.App(...)
      local argc = exports.utils.getParams(...);

      if exports.MODULE [argc[2]] ~= nil then
      --TODO 缓存代码
            return
      end
      
      if argc[1] ~= nil then
        if argc[2] ~= nil then
          local modu = argc[1]:new(argc[2])
          if argc[3] then
            modu.procMessage =argc[3];
          end
        end
      else
        print("params is error")
      end
    end
    
    function exports.Message(...) 
      local message = exports.cls.peekMessage();
      local argc    = exports.utils.getParams(...);
      
      if argc[1] ~= nil then
        message.msgId = argc[1];
      end
      if argc[2] ~= nil then
        message.to    = argc[2];
      end
      if argc[3] ~= nil then
        message.data  = argc[3];
      end
      if argc[4] ~= nil then
        message.all   = argc[4];
      end
      exports.cls.sender.notifyOnsending(message);
    end   
end

local getRequestMessage = function ( )
       local src    =  ngx.var.request_uri;  
       local eax  = string.find(src , "?");
       local ebx = string.find(src,"/")
       local base = "";  --处理截取的字符
       if  eax ~= nil then
          base = string.sub(src, ebx+1 , eax-1);
       else 
          base = string.sub(src, ebx+1,  -1); 
       end
       local eax  = string.find(base , "/");
       if eax == nil then
           eax = 0
       end
       local modu   =  string.sub(base, 1 , eax - 1); 
       local msg     =  string.sub(base, eax+1 , - 6); 
       local method = ngx.req.get_method();
       local args       = ngx.req.get_uri_args() ;
       
       if args == nil then
            args = {}
       end
       if method == "POST" then
             ngx.req.read_body() ;
             local data, err = ngx.req.get_post_args()
             if data ~= nil then
                 for key, val in pairs(data) do
                    args[key] = val;
                 end
             end
       end
       local info = {}
       info['modu']   = modu;
       info['msgId']   = msg;
       info['data']      = args;
       return info;
end  
exports.uri_cache = {};
exports.getRequestMessage = getRequestMessage;
return exports

