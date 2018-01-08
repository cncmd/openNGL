exports.TML_VIEW_PROFILE=[[

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
        <div class="flex-grid no-responsive-future" style="height: 100%;">
            <div class="row" style="height: 100%">
                <div class="cell auto-size padding20 bg-white" id="cell-content">
                    <h1 class="text-light">我的搭建 </h1>
                    <hr class="thin bg-grayLighter">
                     <button class="button primary" onclick="metroDialog.open('#dialog')"><span class="mif-plus icon"></span> 创建搭建</button>
                     <button class="button primary" onclick="metroDialog.open('#dialog2')"><span class="mif-plus icon"></span> 创建任务</button>
                     <div class="listview  padding set-border list-type-icons" id="myProject" 
                          data-role="listview" id="lv1" data-on-list-click="exports.invokeBuildView(list.find('.list-title').text())">
                     </div>
                </div>
            </div>
        </div>
    
    
      <div class="window-caption" data-role='dialog' id="dialog">
        <div class="window-caption">
            <span class="window-caption-icon"><span class="mif-plus icon"></span></span>
            <span class="window-caption-title">创建项目</span>
            <span class="btn-close" id="closeBtn"></span>
        </div>
        
        <div class="window-content" style="height: 430px;width: 440px;">
            <div class="grid">
                <div class="cell">
                        <div class="input-control text full-size">
                            <input type="text" placeholder="填入名称" id="appName">
                        </div>
                        
                        <!--<div class="input-control text full-size" data-role="input">
                            <input type="text" placeholder="填入gitlab地址" id="gitlab" value="git@gitlab.alibaba-inc.com:apollox/apollox-mods.git">
                        </div>-->
                        
                        <div class="input-control text full-size" data-role="input">
                                   <input type="text" placeholder="类型"  id="appType" >
                                   <button class="button dropdown-toggle">类型</button>
                                   <ul class="split-content d-menu" data-role="dropdown">
                                        <li><a href="javascript:void(0);" data-config="poplayer 页面" onclick="exports.fselect2Input(event)">poplayer 页面</a></li>
                                        <li><a href="javascript:void(0);" data-config="apollox2d 引擎" onclick="exports.fselect2Input(event)">apollox2d 引擎</a></li>
                                        <li><a href="javascript:void(0);" data-config="metro 页面" onclick="exports.fselect2Input(event)">metro 页面</a></li>
                                    </ul>
                        </div>
                        
                        <div class="cell">
                                <div id="button-group-2" data-role="group" data-group-type="multi-state" data-button-style="class">
                                    <button class="button alert">模块部件</button>
                                    <button class="button warning">单页面应用</button>
                                </div>
                        </div>
                        
                        <div>
                            <button class="button" id="saveBtn"> 保存</button>
                            <button class="button" id="cancelBtn"> 取消</button>
                        </div>
                </div>
            </div>
        </div>
    </div>
    
    
        
      <div class="window-caption" data-role='dialog' id="dialog2">
        <div class="window-caption">
            <span class="window-caption-icon"><span class="mif-plus"></span></span>
            <span class="window-caption-title">创建任务</span>
            <span class="btn-close" id="closeTaskBtn"></span>
        </div>
        
        <div class="window-content" style="height: 500px;width: 500px;">
            <div class="grid">
                <div class="cell">
<table class="table striped" id="taskEditor" style="width: 490px;">
                <tbody>
                <tr>
                    <td style="width: 100px;">应用标识</td>
                    <td>
                        <div class="input-control text full-size">
                            <input type="text" id="appKey">
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 100px;">发布环境</td>
                    <td>
                         <div class="split-button active-container">
                            <button class="button" id="missionEnvBtn">线上环境</button>
                            <button class="split dropdown-toggle"></button>
                            <ul class="split-content d-menu" data-role="dropdown" style="display: none;">
                                <li><a href="javascript:void(0);" data-config="日常环境" onclick="exports.fselectEnvInput(event)">日常环境</a></li>
                                <li><a href="javascript:void(0);" data-config="预发环境" onclick="exports.fselectEnvInput(event)">预发环境</a></li>
                                <li><a href="javascript:void(0);" data-config="线上环境" onclick="exports.fselectEnvInput(event)">线上环境</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
                
                <tr>
                    <td>任务类型</td>
                    <td>
                        <div class="split-button active-container">
                            <button class="button" id="missionTypeBtn">类型A</button>
                            <button class="split dropdown-toggle"></button>
                            <ul class="split-content d-menu" data-role="dropdown" style="display: none;">
                                <li><a href="javascript:void(0);" data-config="类型A" onclick="exports.fselectTypeInput(event)">类型A</a></li>
                                <li><a href="javascript:void(0);" data-config="类型B" onclick="exports.fselectTypeInput(event)">类型B</a></li>
                                <li><a href="javascript:void(0);" data-config="类型C" onclick="exports.fselectTypeInput(event)">类型C</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
                 <tr>
                    <td>开始时间</td>
                    <td>
                        <div class="input-control text full-size" data-locale="zhCN" data-role="datepicker">
                            <input type="text" readonly="readonly" id="missionStartTime">
                            <button class="button" type="button"><span class="mif-calendar"></span></button>
                        <div class="calendar calendar-dropdown" style="position: absolute; max-width: 100%; z-index: 1000; top: 100%; left: 0px; display: none;"><div class="calendar-grid"><div class="calendar-row no-margin calendar-header"><div class="calendar-cell align-center"><a class="btn-previous-year" href="#">-</a></div><div class="calendar-cell align-center"><a class="btn-previous-month" href="#">〈</a></div><div class="calendar-cell sel-month align-center"><a class="btn-select-month" href="#">Nov 2017</a></div><div class="calendar-cell align-center"><a class="btn-next-month" href="#">〉</a></div><div class="calendar-cell align-center"><a class="btn-next-year" href="#">+</a></div></div><div class="calendar-row week-days calendar-subheader"><div class="calendar-cell align-center day-of-week"><div>Su</div></div><div class="calendar-cell align-center day-of-week"><div>Mo</div></div><div class="calendar-cell align-center day-of-week"><div>Tu</div></div><div class="calendar-cell align-center day-of-week"><div>We</div></div><div class="calendar-cell align-center day-of-week"><div>Th</div></div><div class="calendar-cell align-center day-of-week"><div>Fr</div></div><div class="calendar-cell align-center day-of-week"><div>Sa</div></div></div><div class="calendar-row"><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell align-center day"><div><a href="#">1</a></div></div><div class="calendar-cell align-center day"><div><a href="#">2</a></div></div><div class="calendar-cell align-center day"><div><a href="#">3</a></div></div><div class="calendar-cell align-center day"><div><a href="#">4</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">5</a></div></div><div class="calendar-cell align-center day"><div><a href="#">6</a></div></div><div class="calendar-cell align-center day"><div><a href="#">7</a></div></div><div class="calendar-cell align-center day"><div><a href="#">8</a></div></div><div class="calendar-cell align-center day selected"><div><a href="#">9</a></div></div><div class="calendar-cell align-center day"><div><a href="#">10</a></div></div><div class="calendar-cell align-center day"><div><a href="#">11</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">12</a></div></div><div class="calendar-cell align-center day"><div><a href="#">13</a></div></div><div class="calendar-cell align-center day"><div><a href="#">14</a></div></div><div class="calendar-cell align-center day"><div><a href="#">15</a></div></div><div class="calendar-cell align-center day"><div><a href="#">16</a></div></div><div class="calendar-cell align-center day"><div><a href="#">17</a></div></div><div class="calendar-cell align-center day"><div><a href="#">18</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">19</a></div></div><div class="calendar-cell align-center day"><div><a href="#">20</a></div></div><div class="calendar-cell align-center day"><div><a href="#">21</a></div></div><div class="calendar-cell align-center day"><div><a href="#">22</a></div></div><div class="calendar-cell align-center day today"><div><a href="#">23</a></div></div><div class="calendar-cell align-center day"><div><a href="#">24</a></div></div><div class="calendar-cell align-center day"><div><a href="#">25</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">26</a></div></div><div class="calendar-cell align-center day"><div><a href="#">27</a></div></div><div class="calendar-cell align-center day"><div><a href="#">28</a></div></div><div class="calendar-cell align-center day"><div><a href="#">29</a></div></div><div class="calendar-cell align-center day"><div><a href="#">30</a></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div></div></div></div></div>
                        <span>
                            <div class="input-control select full-size">
                                <select id="missionStartTime_h">
                                    <option>00.00</option>
                                    <option>01.00</option>
                                    <option>02.00</option>
                                    <option>03.00</option>
                                    <option>04.00</option>
                                    <option>05.00</option>
                                    <option>06.00</option>
                                    <option>07.00</option>
                                    <option>08.00</option>
                                    <option>09.00</option>
                                    <option>10.00</option>
                                    <option>11.00</option>
                                    <option>12.00</option>
                                    <option>13.00</option>
                                    <option>14.00</option>
                                    <option>15.00</option>
                                    <option>16.00</option>
                                    <option>17.00</option>
                                    <option>18.00</option>
                                    <option>19.00</option>
                                    <option>20.00</option>
                                    <option>21.00</option>
                                    <option>22.00</option>
                                    <option>23.00</option>
                                </select>
                            </div>
                        </span>
                    </td>
                </tr>
                 <tr>
                    <td>结束时间</td>
                     <td>
                        <div class="input-control text full-size" data-locale="zhCN" data-role="datepicker" data-on-select="console.log(d +'\n'+ d0)">
                            <input type="text" readonly="readonly" id="missionEndTime">
                            <button class="button" type="button"><span class="mif-calendar"></span></button>
                        <div class="calendar calendar-dropdown" style="position: absolute; max-width: 100%; z-index: 1000; top: 100%; left: 0px; display: none;"><div class="calendar-grid"><div class="calendar-row no-margin calendar-header"><div class="calendar-cell align-center"><a class="btn-previous-year" href="#">-</a></div><div class="calendar-cell align-center"><a class="btn-previous-month" href="#">〈</a></div><div class="calendar-cell sel-month align-center"><a class="btn-select-month" href="#">Nov 2017</a></div><div class="calendar-cell align-center"><a class="btn-next-month" href="#">〉</a></div><div class="calendar-cell align-center"><a class="btn-next-year" href="#">+</a></div></div><div class="calendar-row week-days calendar-subheader"><div class="calendar-cell align-center day-of-week"><div>Su</div></div><div class="calendar-cell align-center day-of-week"><div>Mo</div></div><div class="calendar-cell align-center day-of-week"><div>Tu</div></div><div class="calendar-cell align-center day-of-week"><div>We</div></div><div class="calendar-cell align-center day-of-week"><div>Th</div></div><div class="calendar-cell align-center day-of-week"><div>Fr</div></div><div class="calendar-cell align-center day-of-week"><div>Sa</div></div></div><div class="calendar-row"><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell align-center day"><div><a href="#">1</a></div></div><div class="calendar-cell align-center day"><div><a href="#">2</a></div></div><div class="calendar-cell align-center day"><div><a href="#">3</a></div></div><div class="calendar-cell align-center day"><div><a href="#">4</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">5</a></div></div><div class="calendar-cell align-center day"><div><a href="#">6</a></div></div><div class="calendar-cell align-center day"><div><a href="#">7</a></div></div><div class="calendar-cell align-center day"><div><a href="#">8</a></div></div><div class="calendar-cell align-center day selected"><div><a href="#">9</a></div></div><div class="calendar-cell align-center day"><div><a href="#">10</a></div></div><div class="calendar-cell align-center day"><div><a href="#">11</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">12</a></div></div><div class="calendar-cell align-center day"><div><a href="#">13</a></div></div><div class="calendar-cell align-center day"><div><a href="#">14</a></div></div><div class="calendar-cell align-center day"><div><a href="#">15</a></div></div><div class="calendar-cell align-center day"><div><a href="#">16</a></div></div><div class="calendar-cell align-center day"><div><a href="#">17</a></div></div><div class="calendar-cell align-center day"><div><a href="#">18</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">19</a></div></div><div class="calendar-cell align-center day"><div><a href="#">20</a></div></div><div class="calendar-cell align-center day"><div><a href="#">21</a></div></div><div class="calendar-cell align-center day"><div><a href="#">22</a></div></div><div class="calendar-cell align-center day today"><div><a href="#">23</a></div></div><div class="calendar-cell align-center day"><div><a href="#">24</a></div></div><div class="calendar-cell align-center day"><div><a href="#">25</a></div></div></div><div class="calendar-row"><div class="calendar-cell align-center day"><div><a href="#">26</a></div></div><div class="calendar-cell align-center day"><div><a href="#">27</a></div></div><div class="calendar-cell align-center day"><div><a href="#">28</a></div></div><div class="calendar-cell align-center day"><div><a href="#">29</a></div></div><div class="calendar-cell align-center day"><div><a href="#">30</a></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div><div class="calendar-cell empty"><div class="other-day" style="visibility: hidden;"></div></div></div></div></div></div>
                        <span>
                            <div class="input-control select full-size">
                                <select id="missionEndTime_h">
                                    <option>00.00</option>
                                    <option>01.00</option>
                                    <option>02.00</option>
                                    <option>03.00</option>
                                    <option>04.00</option>
                                    <option>05.00</option>
                                    <option>06.00</option>
                                    <option>07.00</option>
                                    <option>08.00</option>
                                    <option>09.00</option>
                                    <option>10.00</option>
                                    <option>11.00</option>
                                    <option>12.00</option>
                                    <option>13.00</option>
                                    <option>14.00</option>
                                    <option>15.00</option>
                                    <option>16.00</option>
                                    <option>17.00</option>
                                    <option>18.00</option>
                                    <option>19.00</option>
                                    <option>20.00</option>
                                    <option>21.00</option>
                                    <option>22.00</option>
                                    <option>23.00</option>
                                </select>
                            </div>
                        </span>
                    </td>
                    
                </tr>
                <tr>
                    <td></td>
                    <td><button class="button primary" onclick="exports.createMission()"><span class="mif-plus icon"></span> 保存任务项目</button></td>
                </tr>
                </tbody></table>                        
                </div>
            </div>
        </div>
    </div>
     <footer>
    <div class="bg-steel no-tablet-portrait no-phone">
        <div class="container padding20 fg-white">
            <div class="carousel bg-transparent" data-role="carousel" data-controls="false" data-markers="false" data-effect="fade" data-height="150" style="width: 100%; height: 200px;">
                <div class="slide fg-white">
                    <div class="place-left" style="margin-right: 20px">
                    <span class="mif-space-shuttle icon" style="width:44px;font-size:44px;"></span>
                    </div>
                    <h1>感谢使用apollox搭建平台</h1>
                    <p>如果你需要以开发者身份并且发布模块,贡献代码请加入&nbsp;</p>
                    <a class="button success" href="/Dev/Get.mxml">开发者</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
            <div class="listview  list-type-listing" data-on-list-click="navgateUrl(list)" data-role="listview" style="min-height: 30px;margin-top:15px;" id="lv1">
                    <div class="listview  list-type-listing" data-on-list-click="navgateUrl(list)" data-role="listview" style="min-height: 30px;margin-bottom:15px;" id="lv1">
                        <div class="list" item-key="//mt2.alibaba-inc.com">
                            <img src="//mt2.alibaba-inc.com/assets/img/logo.png" class="list-icon">
                            <span class="list-title">mt2平台</span>
                        </div>
                       
                        <div class="list" item-key="//aone.alibaba-inc.com">
                            <img src="//gtms03.alicdn.com/tps/i3/TB124nHGXXXXXXJXFXXSrT52pXX-190-170.png" class="list-icon">
                            <span class="list-title">阿里巴巴技术协会</span>
                        </div>
                        
                        <div class="list" item-key="//lark.alipay.com/">
                            <img src="//zos.alipayobjects.com/rmsportal/lQoPkzilBAnSDpn.svg" class="list-icon">
                            <span class="list-title">云雀</span>
                        </div>
                        
                        <div class="list" item-key="//aone.alibaba-inc.com">
                            <img src="//ata2-img.cn-hangzhou.img-pub.aliyun-inc.com/d8f598a517efcded5f9ac0a1c5f19b2e.png" class="list-icon">
                        <span class="list-title">aone</span>
            </div>
    </div>
    <div class="align-center padding0 text-small">
    </div>
</footer>
<script>function navgateUrl(url) {window.open($(url).attr("item-key"))} </script>
</body>
</html>

]]