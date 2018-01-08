
exports.TML_JS_JUMP=  [[

;exports.moduleist = [];
;exports.codegen   = "";

;(
    function () {
        var cls = exports.createNamespace("client");
        
        
        ////底层移植数据结构
        cls.SceneVO  = function (e) {
            if(e) {
                  if(e.sceneId) {
                     this.sceneId =  e.sceneId;
                  }
                  
                  if(e.sceneIndex != null) {
                     this.sceneIndex = e.sceneIndex;
                  }
                  
                  if(e.frames) {
                      this.frames = frames;
                  }
            } else {
                  this.sceneId    = "场景1";
                  this.sceneIndex = 0;
                  this.frames     = [];
            }
        }
        
        /////帧结构
        cls.FrameVO  = function (e) {
             if(e) {
                 if(e.frameIndex){
                    this.frameIndex = e.frameIndex;
                 }
                 
                 if(e.pos) {  ////定位标识
                     this.pos = e.pos;
                 }
    
                 if(e.plugins) {
                     this.plugins = e.plugins;
                 }
             } else {
                 this.frameIndex = 0;
                 this.pos  = null;
                 this.plugins = [];
             }
        }

   cls.ProjectVO = function (v) {
            this.name = "";
            this.deamonPlugins= {};
            this.plugins=  [];
            this.res    =  [];
            this.scripts=  [];
            this.type   =  0;
            this.opt    =  [];
            this.backgroundColor="";
            this.layers = [];
            this.modulelist=[];
            this.scenes = [];
       }
        
       cls.PluginVO = function () {
           
           this.name   = "";
           this.params = [];
           this.mod    = ""; ///类
           this.x =  0;
           this.y =  0;
           this.layer = 0;
           
           this.scripts = "";
           this.schema  = "";
           
           this.description = function () {
               var w   = exports.AppWidth  || window.innerWidth;
               var h   = exports.AppHeight || window.innerHeight;
        
               return  {
                   "name":this.name,
                   "params": this.params,
                   "mod":this.mod,
                   "x":this.x,
                   "y":this.y,
                   "layer":this.layer,
                   "scripts":this.scripts,
                   "schema":this.schema,
                   "xpos":(this.x / w),
                   "ypos":(this.y / h)
               }
           }
           
           
       }
    }
)();


if(exports.layers == null) {
    if(exports.createLayer != null) {
        exports.createLayer(); ///针对其他没有分层的应用
    }
    
    if(!exports.currLayer) {
        var f = document.createDocumentFragment();
        var p = document.createElement("div");
        p.id  = "layer0";
        
        var w   = exports.AppWidth || document.body.clientWidth;
        var h   = exports.AppHeight|| document.body.clientHeight;
    
    
        p.style.width = w+ 'px';
        p.style.height= h+ 'px';
        p.style.background ="#232628";
        f.appendChild(p);
        document.body.appendChild(f);
        
        exports.currLayer = document.getElementById("layer0") ;
        exports.currLayer.addChild = function (node) {
                var c = document.createDocumentFragment();
                c.appendChild(node);
                exports.currLayer.appendChild(c);
        }
        exports.layers = [exports.currLayer];
    }
}
;exports.initProject  = function () {

     exports.AppWidth = window.innerWidth;
     exports.AppHeight= window.innerHeight;
     
     var cls = exports.createNamespace("client");
     if(exports.currProject == null) {
         exports.currProject = new cls.ProjectVO();
     }
     var eax = exports.currProject;
     
     if(eax.scenes.length == 0) {
         eax.scenes[0] = new cls.SceneVO();
     }
     
     exports.currScene =  eax.scenes[0];
     
     if(exports.currScene.frames.length == 0) {
         exports.currScene.frames[0] = new cls.FrameVO();
     }
     exports.currFrame =  exports.currScene.frames[0];
     exports.currFrameIndex =0;
     exports.currSceneIndex =0;
}

exports.invokeScript =  function(str, obj) {
    var tmp = [];
    tmp.push('\n;[App(exports.cls.Module, "'+obj.name+'", function(message){\n');
    tmp.push('\tswitch(message.msgId) {\n');
    tmp.push('\tcase "Init":\n');
    tmp.push('\t\t;(\n'+obj.scripts+'\n)(message.data);\n')
    tmp.push('\tbreak;\n')
    tmp.push('}})];\n')
    return tmp.join("");
}

exports.makeView = function (ebx) {
   return function () {
        var cls = exports.createNamespace("plugin");
        if(!ebx.mod) {
            return;
        }
        var w   = exports.AppWidth  || document.body.clientWidth;
        var h   = exports.AppHeight || document.body.clientHeight;
        console.log(w,h)
        mod = cls[ebx.mod];
        
        if(mod == null) {
            return;
        }
        var plug = new mod();
        if(ebx.params.length > 0) {
                var datac ={};
                for( var k in ebx.params) {
                    if(!ebx.params[k].key) {
                        continue;
                    }
                    datac[ebx.params[k].key] = ebx.params[k].value
                }
                plug.init(datac);
        }
        
        var view = plug.getView();
        
        if(view == null) {
              return;
        }
        if(view.pos == null) {
            view.style.position="absolute";
            view.style.top = h* ebx.ypos + "px";
            view.style.left= w* ebx.xpos + "px";
        } else {
            view.pos(w * ebx.xpos, h* ebx.ypos);
        }
        
        if(view.scale == null) {
            
        } else {
            view.scale(exports.dpiw ,exports.dpiw);
        }
        
        
        console.log(plug.update);
        if(plug.update != null) {
              plug.update();
        }
                        
        exports.currLayer.addChild(view);
        exports.moduleist.push(plug);
        plug.vo = ebx;
        if(ebx.scripts) {
            eval(exports.invokeScript(ebx.scripts, ebx));
            [Message("Init", ebx.name, plug)];
        }
        }(ebx);
}

;( function (e) {
    if(exports.currLayer == null) {
        exports.currLayer = exports.layers[0];
    }
    
    try{
       e = JSON.parse(e.value);
    }catch (e) {
       e = {}
    }
    
    exports.initProject();
    
    
    var eax = null;
    var mod = null;
    ///偏移量设置
    var w   = exports.AppWidth || document.body.clientWidth;
    var h   = exports.AppHeight|| document.body.clientHeight;
    exports.dpiw = w / e.dpiw ;
    exports.dpih = h / e.dpih ;
    ///创建layer
    ///创建daemon
   
     
    if(e.daemon) {
        for(var k in e.daemon) {
            eax = e.daemon[k];
            if(!eax.mod) {
                continue;
            }
            mod = cls[eax.mod];
            var plug = new mod();
            plug.init();
        }
    }
    
    ///0724 移植
    if(e.scenes) {
       var len = e.scenes.length;
       var edx = e.scenes;
       var cls = exports.createNamespace("client");
       for( var i=0;i<len; i++ ) {///scene
           var s= edx[i].frames;
           var sIns     = new cls.SceneVO();
           sIns.sceneId = edx[i].name ;
           sIns.frames  = [];
           exports.currProject.scenes[i] = sIns;
           
           for(var k=0,len=s.length; k < len; k++) { ///frame
               var p  = s[k];
               var esi= p.plugins;
               var ebp= esi.length;
               
               var fIns = new cls.FrameVO();
               sIns.frames[i] = fIns;
               exports.currFrame = fIns;
               for(var ecx =0; ecx < ebp; ecx ++) { ///plugin
                   exports.makeView(esi[ecx]);
               }
           }
       }
    }
    
    /////创建plugin
    if(e.plugins) {
        var len = e.plugins.length;
        var eax = e.plugins;
        var ebx = null;
        
        if(len > 0) {
            for(var i =0; i< len; i ++) {
                ebx = eax[i];
                (function (ebx) {
                        if(!ebx.mod) {
                            return;
                        }
                        var w   = exports.AppWidth  || document.body.clientWidth;
                        var h   = exports.AppHeight || document.body.clientHeight;
                        mod = cls[ebx.mod];
                        
                        if(mod == null) {
                            return;
                        }
                        var plug = new mod();
                        if(ebx.params.length > 0) {
                                var datac ={};
                                for( var k in ebx.params) {
                                    if(!ebx.params[k].key) {
                                        continue;
                                    }
                                    datac[ebx.params[k].key] = ebx.params[k].value
                                }
                                plug.init(datac);
                        }
                        
                        var view = plug.getView();
                        
                        if(view == null) {
                              console.log("view==null");
                              return;
                        }
                        if(view.pos == null) {
                            view.style.position="absolute";
                            view.style.top = h* ebx.ypos + "px";
                            view.style.left= w* ebx.xpos + "px";
                        } else {
                            view.pos(w * ebx.xpos, h* ebx.ypos);
                        }
                        
                        
                        if(view.scale != null) {
                          view.scale(exports.dpiw ,exports.dpiw);  
                        } 
                        console.log(plug.update);
                        if(plug.update != null) {
                            plug.update();
                        }
                        exports.currLayer.addChild(view);
                        exports.moduleist.push(plug);
                        plug.vo = ebx;
                        if(ebx.scripts) {
                            eval(exports.invokeScript(ebx.scripts, ebx));
                            [Message("Init", ebx.name, plug)];
                        }
                })(ebx);
            }
        }
    }
})({*code*})
]]