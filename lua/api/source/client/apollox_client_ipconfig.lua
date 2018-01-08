--@ip 

do
      exports.ip  = "127.0.0.1";
      
      exports.getIp = function () 
         local t = io.popen("/sbin/ifconfig | grep inet | grep Bcast | awk '{print(substr($2,6))}'")
         exports.ip = t:read("*all")
         exports.ip = string.sub(exports.ip, 0 , string.len(exports.ip) -1) ;
         return exports.ip;
      end
      
      exports.getIp();
end


App(
   Module,
   "Ip",
   function ( message ) 
       local __normal__ = exports.normalizeSavePath;
       ngx.header["Content-Type"] = "text/plain";
       if message.msgId == "Get" then
            ngx.say(exports.ip);
       end
   end
);