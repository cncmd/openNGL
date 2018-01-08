exports.TML_VIEW_HELP=[[

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>搭建系统</title>
      {% for _, style in ipairs(styles) do %}
          {*style*}
     {% end %}
       
      {% for _, lib in ipairs(libs) do %}
        {*lib*}
      {% end %}
        <style>
            html, body {
            height: 100%;
        }
        body {
        }
        .page-content {
            padding-top: 3.125rem;
            min-height: 100%;
            height: 100%;
        }
      </style>
      
</head>
<body>
    {*menu*}
        

    <div class="page-content">
        <div class="grid">
                <div class="row ">
                    <div class="cell">
                        <ul class="step-list">
                            <li>
                                <h2 class="no-margin-top">搭建系统的目标</h2>
                                <hr class="bg-red">
                                <div>
                                    <p class="text-accent">
                                                                目前只是技术预研demo，我的目标是使这个搭建系统可以支持但不限于apollox引擎的搭建，所以
                                                                在系统的灵活度和复杂度上做了取舍，整个系统的生命周期都可以hook和进行切面编程来拓展。
                                                                我尽量保持这个系统的简单和简洁。另外这个阶段的目标我觉得需要聚焦在快速搭建和模块的复用能力上。
                                                            </br>    
                                                                感谢家人和同事对我工作的支持。
                                    </p>
                                           
                                    <address>
                                        <strong>钟元</strong><br>
                                                                                阿里大优酷-大剧技术团队<br>
                                        wangwenbo@alibaba-inc.com<br>
                                    </address>
                                    
                                    <br>
                                    <br>
                                </div>
                            </li>
                            <li>
                                <h2 class="no-margin-top">未来支持的目标</h2>
                                <hr class="bg-green">
                                <div>
                                     <div class="cell">
                                        <h4></h4>
                                        <ol class="numeric-list square-marker">
                                            <li>apollox 2d 引擎</li>
                                            <li>阿里的AFT动画引擎</li>
                                            <li>阿里的hilo游戏引擎</li>
                                            <li>sam.js隔离框架</li>
                                            <li>和更多的引擎和框架</li>
                                        </ol>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <h2 class="no-margin-top">贡献者</h2>
                                <hr class="bg-blue">
                                <div>
                                    子之,渚薰,钟元
                                    <br>
                                    <br>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
    </div>
</body>
</html>
]]