
exports.TML_HTML_OWNER=[[
<!DOCTYPE html>
<html>
  <head>
        <meta charset="utf-8">
        <title>{{title}}</title>

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
  <body >
  </body>
    {% for _, lib in ipairs(libsend) do %}
          {*lib*}
    {% end %}
    
    
           <script>
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

 {*dist*}
       </script>
</html>
    ]]