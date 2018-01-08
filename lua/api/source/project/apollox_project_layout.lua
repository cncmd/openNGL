-- @ layout 
App(
   Module,
   "Layout",
   function ( message ) 
       if message.msgId == "Get" then
            -- 默认layout 是空白layout
          local layout = exports.createNamespace("layout");
          local eax     = message.data;
          
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          if eax["Layout"] == nil then
               local  tml  =  layout.out("none");
               ngx.say(tml);
               return 
          end
          
           local tml =   layout.out(eax["Layout"]);
           ngx.say(tml);
       end
   end
);