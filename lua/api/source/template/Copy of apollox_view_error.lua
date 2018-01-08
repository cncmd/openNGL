exports.TML_VIEW_ERROR=[[

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
    <div class="bg-steel no-tablet-portrait no-phone">
        <div class="container padding20 fg-white">
            <div class="carousel bg-transparent" data-role="carousel" data-controls="false" data-markers="false"
             data-effect="fade" data-height="150" style="margin-Top:251px;width: 100%; height: 150px;">
                <div class="slide fg-white">
                    <h1>你所访问的页面在外太空，上车请联系司机。</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="padding10 bg-red fg-white text-accent">当你看到这页面的时候， 请不要惊讶，你需要的只是点击返回而已 <a class="button success" href="/">返回</a></div>
</body>
</html>
]]