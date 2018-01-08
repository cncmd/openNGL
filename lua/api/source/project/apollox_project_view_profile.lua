-- @ Profile 
App(
   Module,
   "Profile",
   function ( message ) 
       if message.msgId == "Get" then
            -- 默认layout 是空白layout
          local eax     = message.data;
          if eax["Test"] == nil then
              ngx.header["Content-Type"] = "text/html";
          else
              ngx.header["Content-Type"] = "text/plain";
          end
          local template = require "template"
          local render = template.compile(exports.TML_VIEW_PROFILE);
          local menuRender =  template.compile(exports.TML_COMMON_HEADER);
          local libs = {
          '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
          '<script src="/js/metro.min.js"        type="text/javascript"></script>',
          '<script src="/build/actrl.min.js" type="text/javascript"></script>',
          '<script src="/build/profile.min.js"   type="text/javascript"></script>',
          [[<script> window.alert = function () {};</script>]]
          };
                  
          local styles = {
            '<link href="/css/metro.min.css"         rel="stylesheet">',
            '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
            '<link href="/css/metro-icons.min.css"   rel="stylesheet" />',
           '<link href="/css/hook.css" rel="stylesheet" />',
          }
          
          local menu  = menuRender ( {
          ["user"]=ngx.ctx.username,
          ["systemName"]=exports.SystemName
          });
          
          local fsdata  = render({
                ["libs"]=libs ,
                ["styles"] = styles,
                ["title"] = "profile" ,
                ["menu"] = menu
          });
          
        ngx.say(fsdata);
       end
   end
);