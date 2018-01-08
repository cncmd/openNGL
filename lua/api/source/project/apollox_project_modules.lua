do 
        local cls = exports.createNamespace("modules");
        
        cls.mockNoneLayout = function ()
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="检测插件" ,
                        ["mod"]="StatViewPlugin"
            }
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="精灵动画测试模块" ,
                        ["mod"]="LogoModule"
            }
            
            return cjson.encode(test);
        end
        cls.mockPoplayerLayout = function () 
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="poplayer落地插件" ,
                        ["mod"]="PoplayerImage"
            }
            
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="测试插件" ,
                        ["mod"]="MetroTest"
            }
            
            return cjson.encode(test);
        end
        
        
        cls.mockMetroLayout = function () 
             local test = {}
             test[1] = {}
             test[2] = {} 
             local z=  test [1];
             
             z[1] = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"]="mobx协议落地插件" ,
                        ["mod"]="mobx"
            }
            
            z[2]  = {
                        ["logo"]="/images/rvbs/defaultproject.png",
                        ["title"] ="测试插件" ,
                        ["mod"]="MetroTest"
            }
            
            return cjson.encode(test);
        end
        
        cls.getModules = function (type) 
             --- mock
             if  type == 1  then
               return  cls.mockMetroLayout ();
             elseif type == 2 then
               return cls.mockPoplayerLayout();
             else 
               return cls.mockNoneLayout();
             end
        end
end