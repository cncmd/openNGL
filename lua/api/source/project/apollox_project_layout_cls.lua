-- @layout 默认是空布局， 适合画布类应用的布局
 --@update 2017-08-16

do 
        local layout = exports.createNamespace("layout");
        layout.bools= {};
        layout.Empty = "none";
        ---空布局
        layout.out = function (p,e) 
            if layout.bools[p] ~= nil then
                  return layout.bools[p].out(e);
            end
            return layout.bools[layout.Empty].out(e)
        end
end
--@ layout metro layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["metro"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                    '<script src="/js/metro.min.js" type="text/javascript"></script>',
                    };
                    
                    styles = {
                     '<link href="/css/metro.min.css" rel="stylesheet">',
                     '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                     '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                    }
                else 
                      libs = {
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='metro layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end


--@ layout metro layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["mission"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                    '<script src="/js/metro.min.js" type="text/javascript"></script>',
                    };
                    
                    styles = {
                     '<link href="/css/metro.min.css" rel="stylesheet">',
                     '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                     '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                    }
                else 
                      libs = {
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"]     ='mission layout',
                      ["dist"]      = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end


--@ layout poplayer layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools["poplayer"] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local publish = nil;
                local libs = nil;
                local styles = nil;
                local libsend=nil;
                
                if e ~= nil then
                    publish = 1;
                    libs = {
                    '<script data-mt-inline src="//g.alicdn.com/mtb/??lib-flexible/0.3.4/flexible.js,lib-promise/3.1.3/polyfillB.js,lib-env/1.9.9/env.js,lib-windvane/2.1.8/windvane.js,lib-httpurl/1.3.8/httpurl.js"></script>',
                    '<script data-mt-inline src="//g.alicdn.com/heyi_h5/swordrain/0.0.2/mtop.js"></script>'
                    };
                    
                    styles = {
                    }
                    
                    libsend = {
                        '<script src="/js/yctrl.min.js" type="text/javascript"></script>'
                    }
                else 
                      libs = {
                       '<script data-mt-inline src="//g.alicdn.com/mtb/??lib-flexible/0.3.4/flexible.js,lib-promise/3.1.3/polyfillB.js,lib-env/1.9.9/env.js,lib-windvane/2.1.8/windvane.js,lib-httpurl/1.3.8/httpurl.js"></script>',
                     '<script data-mt-inline src="//g.alicdn.com/heyi_h5/swordrain/0.0.2/mtop.js"></script>',
                      '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                      '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                      [[<script> window.alert = function () {};</script>]]
                      };
                      
                       styles = {
                       '<link href="/css/metro.min.css" rel="stylesheet">',
                      '<link href="/css/metro-schemes.min.css" rel="stylesheet" />',
                      '<link href="/css/metro-icons.min.css" rel="stylesheet" />'
                      }
                      
                       libsend = {
                            '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                            '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      }
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='aft layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end

--@ layout none layout
do 
      local layout = exports.createNamespace("layout");
      
      layout.bools[layout.Empty] = {
           ["out"] = function(e) 
                local template = require "template"
                local render = template.compile(exports.TML_LAYOUT_NONE);
                
                local libs = {
                '<script src="/js/jquery.min.js"        type="text/javascript"></script>',
                '<script src="/js/metro.min.js"        type="text/javascript"></script>',
                [[<script> window.alert = function () {};</script>]]
                };
                
                
                local styles = {
                }
                
                local libsend = {
                      '<script src="/js/laya.core.min.js"    type="text/javascript" ></script>',
                      '<script src="/js/laya.webgl.min.js" type="text/javascript"  ></script>',
                      '<script src="/js/yctrl.min.js" type="text/javascript"></script>',
                      '<script src="/js/apollox.core.min.js" type="text/javascript"></script>',
                      '<script src="/build/mobx.min.js"   type="text/javascript"></script>',
                      '<script type="text/javascript" src="/source/plugin/LogoMotion.js" ></script>',
                      '<script type="text/javascript" src="/source/plugin/Stat.js" ></script>'
                }
                local publish = nil;
                if e ~= nil then
                    publish = 1;
                end
                local fsdata  = render({
                      ["libs"]=libs ,
                      ["styles"] = styles,
                      ["title"] = "Layout" .. layout.Empty ,
                      ["libsend"] = libsend,
                      ["publish"] = publish,
                      ["type"] ='custom layout',
                      ["dist"] = e
                });
                
                if fsdata ~= nil then
                    return fsdata;
                end
               return "error:layout render."
           end
       }
end