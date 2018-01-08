
exports.TML_LAYOUT_NONE=[[
<!DOCTYPE html>
<html>
  <meta name='viewport' 
        content='width=device-width,initial-scale=1.0,
        minimum-scale=1.0,maximum-scale=1.0,user-scalable=no'/>
  <head>
        <!--{{type}}-->
        <meta charset="utf-8">
        <title></title>

        {% for _, style in ipairs(styles) do %}
          {*style*}
        {% end %}
       
        {% for _, lib in ipairs(libs) do %}
          {*lib*}
        {% end %}
       <style>
                body {
                   width:100%;
                   height:100%;
                   margin:0;
                }
       </style>
  </head>
  <body>
  </body>
    {% for _, lib in ipairs(libsend) do %}
          {*lib*}
    {% end %}
           <script>
              
;(function(window, lib) {
    lib.env = lib.env || {};

    var ua = window.navigator.userAgent;
    var matched;
    
    if ((matched = ua.match(/Windows\sPhone\s(?:OS\s)?([\d\.]+)/))) {
        lib.env.os = {
            name: 'Windows Phone',
            isWindowsPhone: true,
            version: matched[1]
        }
    } else if(!!ua.match(/Safari/) && (matched = ua.match(/Android[\s\/]([\d\.]+)/))) {
        lib.env.os = {
            version: matched[1]
        }

        if ((!!ua.match(/Mobile\s+Safari/))) {
            lib.env.os.name = 'Android';
            lib.env.os.isAndroid = true;
        } else {
            lib.env.os.name = 'AndroidPad';
            lib.env.os.isAndroidPad = true;
        }
    } else if((matched = ua.match(/(iPhone|iPad|iPod)/))) {
        var name = matched[1];

        matched = ua.match(/OS ([\d_\.]+) like Mac OS X/);

        lib.env.os = {
            name: name,
            isIPhone: (name === 'iPhone' || name === 'iPod'),
            isIPad: name === 'iPad',
            isIOS: true,
            version: matched[1].split('_').join('.')
        }
    } else {
        lib.env.os = {
            name:'unknown',
            version:'0.0.0'
        }
    }
    
    if (lib.version) {
        lib.env.os.version = lib.version(lib.env.os.version);
    }
    
})(window, window['lib'] || (window['lib'] = {}));

       ;(
    function () {
            var cls = exports.createNamespace("plugin");
    
            cls.mobx = function () {
                this.content = null;
                this.init = function (data) {
                    this.data    = data;
                }
                
                this.dealloc= function() {  ///销毁
                }
                
                this.getView= function () {
                     var p = document.createElement("span");
                     var att=document.createAttribute("class");
                     var style=document.createAttribute("style");
                     style.value="color:#FFFFFF;font-size:22px;width:50px;height:50px;";
                     att.value="mif-truck mif-ani-pass";
                     p.setAttributeNode(att);
                     p.setAttributeNode(style);
                     return p;
                }
                
                this.proto  = (function () {
                    return "format:string|精灵动画的描述json,interval:int|刷新频率" ;
                })();
                
                this.mockData = function () {
                    return {
                        "format":"//on9hafglw.bkt.clouddn.com/daily/test/0.0.1/fighter.json",
                        "interval":1
                    }
                }
            }
    }
)();

;(
    function () {
            var cls = exports.createNamespace("plugin");
    
            cls.PoplayerImage = function () {
                this.content = null;
                this.img       = null;
                
                this.init = function (data) {
                    this.data    = data;
                    this.content = document.createElement("div");
                    this.content.style.position="absolute";
                    this.img       = document.createElement("img");
                    var att  =document.createAttribute("src");
                    att.value=data.src;
                    this.img.setAttributeNode(att);
                    this.content.appendChild(this.img);
                    
                    test();
                    
                    clickHandle(this);
                    
                }
                 this.update = function () {
                      var data = this.data;
                      var style = this.img.style;
                  
                     if(data.width) {
                       style.width   = data.width + "px";
                     }
                     
                     if(data.height) {
                         style.height = data.height + "px"
                     }
                     
                     var style = this.content.style;
                     if(data.offsetX) {
                          // var offLeft = (window.screen.availWidth  - (Number(data.width) *  exports.dpih))  ;
                          // style.left = (offLeft - (data.offsetX * exports.dpih) )    + "px";
                          var offLeft = (window.screen.availWidth  -  Number(data.width)) 
                          style.left = (offLeft - data.offsetX  )    + "px";
                     }
                     
                     if(data.offsetY){
                            //var offRight  = (window.screen.availHeight - (Number(data.height) * exports.dpih));
                            //style.top =  (offRight-(data.offsetY * exports.dpih))  + "px";
                            
                            var offRight  = (window.screen.availHeight - Number(data.height));
                            style.top =  (offRight- data.offsetY)  + "px";
                     }
                     
                     if(data.closeButton == "显示") {
                        console.log("show close button");
                        var closeButton   = document.createElement("img");
                        var att  =document.createAttribute("src");
                        att.value= "http://apollox-hb.oss-cn-beijing.aliyuncs.com/8BKmqmcgavUu9e0b1N8zxwiEiE/%E6%8C%82%E8%A7%92_%E5%85%B3%E9%97%AD%E6%8C%89%E9%92%AE@2x.png";
                        closeButton.setAttributeNode(att);
                        closeButton.style.top = "2px";
                        closeButton.style.width ="17px";
                        closeButton.style.height="17px";
                        closeButton.style.position="absolute";
                        closeButton.style.left = 100 + "px";
                        closeButton.style.top =0 + "px";
                        
                        closeButton.addEventListener("click", function () {
                              window.WindVane.call('WVPopLayer', 'close', {}, function(s){
                                  // do something when success;
                                }, function(e) {
                               // do something when failed;
                                }); 
                                
                                console.log("close button click");
                        });
                        this.content.appendChild(closeButton);
                     }
                     console.log(offLeft, offRight, style.left, data.offsetY );
                 }
                 
                function  test() {
                  //查询播放器信息
                         if(  window.WindVane == null)  return;
                         window.WindVane.call('DJH5Player', 'videoinfo', {}, function(e) {
                            console.log('videoinfo success: ' + JSON.stringify(e.param));
                          }, function(e) {
                          });
                  
                       //开启监听，除了prepare其他监听默认关闭
                       var params = {
                              "play":1,
                              "pause":1,
                              "duration":1,
                              "hdchange":1,
                              "langchange":1,
                              "fullscreen":1,
                              "halfscreen":1,
                              "playend":1,
                              "playerror":1,
                              "start":1
                          };
                        window.WindVane.call('DJH5Player', 'openlistener', params, function(e) {
                          isopen = true;
                        }, function(e) {
                        });
                  
                     //监听正片开始
                      document.addEventListener('DJH5PlayerListener.start', function(e) {
                        console.log("start"+JSON.stringify(e.param));
                        exports.count = 10;
                        exports.hide   = false;
                      }, false);
                  
                      //监听进度
                      document.addEventListener('DJH5PlayerListener.duration', function(e) {
                        //param.second 毫秒
                        console.log("duration"+JSON.stringify(e.param));
                        
                        if(exports.count > 0) {
                            exports.count  --;
                        } else {
                            if(exports.hide) {
                                window.WindVane.call('WVPopLayer', 'close', {}, function(s){
                                  // do something when success;
                                }, function(e) {
                               // do something when failed;
                                }); 
                                console.log("close poplayer");
                                 return;
                            }
                            exports.hide = true;
                            window.WindVane.call('WVPopLayer', 'display', {});  
                            exports.count = 15;
                        }
                      }, false);
                } 
                function  clickHandle (ctx) {
                  var eax = ctx.getView(); ///获取视图 
                  var ebx = ctx.data;
                  
                  if(ebx.type == "PopLayer") {
                  }
                
                  var lib = window.lib;
                    
                    if(!lib) {
                        console.log("error::not find the lib-env");
                        return;
                    }
                    
                    var isIOS = false; 
                    
                    if(lib.env) {
                        isIOS = lib.env.os.isIOS;
                    } 
                      
                  eax.addEventListener("click",function () { 
                    switch(ebx.type) {
                         case "PopLayer":
                               if(isIOS) {
                                      window.WindVane.call('DYKBaseJSBridge', 'nativeOpen', {
                                        'url': "youku://openWVH5?url="+ebx.navigateToURL
                                        }, function (e) {
                                        }, function (e) {
                                            location.href="youku://jsbjump?weburl=" +
                                            encodeURIComponent(ebx.navigateToURL);
                                        });
                               } else {
                                    window.WindVane.call('WVPopLayer', 'navToUrl',
                                       { 'url':ebx.navigateToURL }, function(s){
                                         }, function(e) {
                                             location.href= ebx.navigateToURL;
                                         });
                               }
                             break;
                     }
                  });
                }


                this.dealloc= function() {  ///销毁
                }
                
                this.getView= function () {
                     return this.content;
                }
                
                this.proto  = (function () {
                    return "src:string|图片地址, "+
                    "closeButton:opt|显示关闭按钮#*隐藏*显示,"+
                    "navigateToURL:string|需要跳转的地址,"+
                    "width:string|图片的宽度,"+
                    "height:string|图片的高度,"+
                    "offsetX:string|据左边框的位移,"+
                    "offsetY:string|据下边框的位移,"+
                    "type:opt|跳转类型#*PopLayer*WebView*Other" ;
                })();
                
                this.mockData = function () {
                    return {
                        "src":"//on9hafglw.bkt.clouddn.com/daily/test/0.0.1/test.png"
                    }
                }
            }
    }
)();
</script>
  {% if publish ~= nil then %}
  {*dist*}
  {% end %}
</html>
 ]]