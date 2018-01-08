exports.TML_COMMON_HEADER=[[
  {% if design ~= nil then %}
    <div class="app-bar">
  {% else %}
    <div class="app-bar fixed-top">
  {% end %}
            <link rel="shortcut icon" href="/favicon.ico" />
            <ul class="app-bar-menu place-left" data-flexdirection="reverse">
                    <li data-flexorderorigin="1" data-flexorder="2">&nbsp;&nbsp;&nbsp;<span class="mif-space-shuttle icon" style="width:38px;font-size:16px;"></span></li>
            </ul>
            <span class="app-bar-divider"></span>
            <ul class="app-bar-menu">
                <li><a href="/Profile/Get.mxml">{{systemName}}</a></li>
            {% if design ~= nil then %}
                            <li>
                                <a href="" class="dropdown-toggle">编辑</a>
                                <ul class="d-menu" data-role="dropdown" style="border:0">
                                    <li><a href="javascript:void(0)" onclick="exports.savehandle()"><span class="mif-drive icon" style="color: #1D1D1D;"></span>保存</a></li>
                                    <li><a href="javascript:void(0)" onclick="exports.buildhandle()"><span class="mif-drive icon" style="color: #1D1D1D;"></span>构建</a></li>
                                    <li class="divider"></li>
                                    <li><a href="javascript:void(0)" onclick="exports.addmodules(event)"><span class="mif-plus icon" style="color: #1D1D1D;"></span>添加模块</a></li>
                                    <li><a href="" class="dropdown-toggle"><span class="mif-tablet-landscape icon" style="color: #1D1D1D;"></span>添加多屏幕预览</a>
                                        <ul class="d-menu" data-role="dropdown">
                                            <li><a href=""><span class="mif-mobile icon" style="color: #1D1D1D;"></span>添加H5屏幕</a></li>
                                            <li><a href=""><span class="mif-display icon" style="color: #1D1D1D;"></span>添加PC屏幕</a></li>
                                        </ul>
                                    </li>
                                    <li class="divider"></li>
                                    <li><a href="" class="dropdown-toggle"><span class="mif-file-archive icon" style="color: #1D1D1D;"></span>发布</a>
                                        <ul class="d-menu" data-role="dropdown">
                                            <li><a href=""><span class="mif-github icon" style="color: #1D1D1D;"></span>发布到gitlab</a></li>
                                            <li><a href=""><span class="mif-jsfiddle icon" style="color: #1D1D1D;"></span>发布到cdn</a></li>
                                            <li><a href=""><span class="mif-file-download icon" style="color: #1D1D1D;"></span>下载到本地</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li> 
                            <span class="app-bar-divider"></span>
                            <li><a href="javascript:void(0)" onclick="exports.sharelink()" ><span class="mif-share icon" style="color: #FFFFFF;"></span> 分享</a></li>
                            <span class="app-bar-divider"></span>
              {% end %}
             <li><a href="/Help/Get.mxml">帮助</a></li>
            </ul>
            <ul class="app-bar-menu place-right" data-flexdirection="reverse">
                         <script src="/build/lua.vm.js"></script>
                        <script src="/build/navx.min.js"></script>
                        <li class="active-container" style="max-width:100px;min-width:100px;">
                            <a href="#" class="dropdown-toggle active-toggle" style="max-width:100px;min-width:100px;"><span class="mif-cog"></span>&nbsp;<span id="username">{{user}}</span></a>
                            <ul class="d-menu" data-role="dropdown" style="min-width:100px;max-width:100px;border:0;">
                                <li><a href="javascript:void(0)" onclick="exports.logout()" style="max-width:100px;min-width:100px;">退出</a></li>
                            </ul>
                        </li>
            </ul>
    </div>
    ]]