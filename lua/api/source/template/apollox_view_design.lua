exports.TML_VIEW_DESIGN=[[
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
        
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
      <script>
      var module_list = {*modules*}
      </script>
  </head>
  <body>
         <div>
             <div class="progress small" id="loading" data-parts="true" data-role="progress" data-value="0" data-colors="{&quot;bg-red&quot;: 33, &quot;bg-yellow&quot;: 66, &quot;bg-cyan&quot;: 90, &quot;bg-green&quot;: 100}">
                 <div class="bar bg-green" style="width: 98%;"></div></div>
         </div>
        {*menu*}
        <!--
          content
        -->
        <div class="grid" id="container" style="opacity: 0;">
            <div >
                <div class="cell">
                    <ul class="sidebar no-responsive-future compact" id="sidebarLeft">
                            <li label-role="mymodule">
                                <a href="#">
                                   <span class="mif-apps icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="我的模块|"></span>
                                       <span class="title">我的模块</span>
                                </a>
                            </li>
                            
                             <li label-role="mycode">
                                <a href="#">
                                   <span class="mif-settings-ethernet icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="我的脚本|"></span>
                                   <span class="title">我的脚本</span>
                                </a>
                            </li>
                            
                            <!--
                            <li label-role="myres">
                                <a href="#" >
                                   <span class="mif-images icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="资源管理|"></span>
                                   <span class="title">资源管理</span>
                                </a>
                            </li>
                            
                        
                            
                            <li label-role="viewlayer">
                                <a href="#">
                                   <span class="mif-layers icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="图层管理|"></span>
                                   <span class="title">图层管理</span>
                                </a>
                            </li>
                            
                             <li label-role="viewsetting">
                                <a href="#">
                                   <span class="mif-wrench icon" data-role="hint"
                                        data-hint-background="bg-pink"
                                        data-hint-color="fg-white"
                                        data-hint-mode="2" data-hint-position="right"
                                        data-hint="页面设置|"></span>
                                   <span class="title">页面设置</span>
                                </a>
                            </li>
                            -->
                        </ul>
                        
                        <div id="leftCotnentCloseBtn">
                            <a href="javascript:void(0)"><span class="mif-chevron-thin-left icon"></span></a>
                        </div>
                           
                        <div class="grid" id="sidebarLeftContent"  >
                            <!--
                              modulelist sheet
                            -->
                            
                            <div class="row">
                                <div class="cell" id="leftModuleContent">
                                    <a class="shortcut-button" onclick="exports.addmodules(event)" style="margin-top: 250px; margin-left: 155px; font-size: 14px;">
                                        <span class="icon mif-plus icon"></span>
                                        <span class="title">添加模块</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                </div>
                <!--
                    content
                -->
                            <div class="h5-screen">
                                    <div class="mask">
                                        <span class="mif-plus icon"></span>
                                    </div>
                                    {*mLayout*}
                            </div>
                 
                            <div class="probs">
                                <div class="panel">
                                    <div class="heading">
                                        <span class="icon mif-chevron-thin-right" id="clostRight"></span>
                                        <span class="title">模块属性 </span>
                                        <span class="input-control text"  style="width: 100%; ">
                                                <input type="text" id="target3" value="暂无脚本,请添加脚本方式">
                                                 <button class="button dropdown-toggle"><span class="mif-file-code icon"></span></button>
                                                
                                                 <div data-role="dropdown" data-no-close="true" class="d-menu" style="right: 0px; top: 100%; display: none;">
                                                            <li><a href="javascript:void(0)" onclick="exports.embedcode()"><span class="mif-file-binary icon"></span>嵌入代码</a></li>
                                                            <li><a href="javascript:void(0)"><span class="mif-file-binary icon"></span>上传脚本</a></li>
                                                </div>
                                       </span>
                                    </div>
                                    <div class="content" style="margin-top: 28px;">
                                                <table class="table border bordered hovered cell-hovered" style=" overflow-y:auto;">
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                    </div>
                                </div>
                            </div>
                            
        </div>
        <div data-role="dialog" id="dialog" data-close-button="true">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-file-binary icon"></span></span>
                <span class="window-caption-title" id="embedCodeTitle"></span>
                <span class="btn-close"></span>
            </div>
            <pre id="editor" style="font-family:Monaco, Menlo,SimSun;">
            </pre>
        </div>


        <div data-role="charm" id="showResult" class="charm right-side" 
        style="opacity: 1; display: block; bottom: 0px; top: auto; left: 0px; right: 0px;">
            <span class="charm-closer"></span>
            <span id="linkAddr"></span>
        </div>
        <!--
          描述：模块抽屉-所有模块
        -->
        <div class="window" data-role='dialog' id="allmodules">
            <div class="window-caption">
                <span class="window-caption-icon"><span class="mif-plus icon"></span></span>
                <span class="window-caption-title">添加模块到本地</span>
                <span class="btn-close" id="closeBtn" onclick="exports.closeModuleList(event)"></span>
            </div>
            
            <div class="window-content" style="height: 500px;width: 550px;">
                        <div class="tabcontrol" data-role="tabcontrol">
                                <ul class="tabs">
                                    <li class="active"><a href="#frame_1_1">该layout下模块</a></li>
                                    <li class=""><a href="#frame_1_2">通用模块</a></li>
                                </ul>
                                <div class="frames">
                                    <div class="frame" id="frame_1_1" style="display: block;">
                                           <div class="listview padding10 list-type-icons" data-role="listview" 
                                           id="moduleListView" data-on-list-click="exports.addModuleToLocal(list)">
                                           </div>
                                    </div>
                                    <div class="frame" id="frame_1_2" style="display: none;"></div>
                                </div>
                         </div>
            </div>
        </div>
        {*src*}              
  </body>
</html>

]]