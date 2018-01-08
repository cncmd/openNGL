App(
   Module,
   "Outter",
   function ( message ) 
      
      local template = require "template"
      local eax = message.data;
      local cache = ngx.shared.my_cache;
      local p = cache:get(eax["name"]);
      local render = template.compile(exports.TML_JS_JUMP  );
      if p ~= nil then
          local pdata = render({code=p});
          fsave('.//html/' .. eax["name"] ..'.js', pdata)
      end
      local render = template.compile(exports.TML_HTML_OWNER);
      local fsdata = render({ title = eax["name"] ,dist='<script src="' .. eax["name"] ..'.js"></script>'});
      fsave("./html/test.html", fsdata)
      ngx.say(cjson.encode({data='/test.html?showVertical=1'}))
     end
);


local server = require "resty.websocket.server"

    local wb, err = server:new{
        timeout = 5000,  -- in milliseconds
        max_payload_len = 65535,
    }
    if not wb then
        ngx.log(ngx.ERR, "failed to new websocket: ", err)
        return ngx.exit(444)
    end

    local data, typ, err = wb:recv_frame()

    if not data then
        ngx.log(ngx.ERR, "failed to receive a frame: ", err)
        return ngx.exit(444)
    end

    if typ == "close" then
        -- send a close frame back:

        local bytes, err = wb:send_close(1000, "enough, enough!")
        if not bytes then
            ngx.log(ngx.ERR, "failed to send the close frame: ", err)
            return
        end
        local code = err
        ngx.log(ngx.INFO, "closing with status code ", code, " and message ", data)
        return
    end

    if typ == "ping" then
        -- send a pong frame back:

        local bytes, err = wb:send_pong(data)
        if not bytes then
            ngx.log(ngx.ERR, "failed to send frame: ", err)
            return
        end
    elseif typ == "pong" then
        -- just discard the incoming pong frame

    else
        ngx.log(ngx.INFO, "received a frame of type ", typ, " and payload ", data)
    end

    wb:set_timeout(1000)  -- change the network timeout to 1 second

    bytes, err = wb:send_text("Hello world")
    if not bytes then
        ngx.log(ngx.ERR, "failed to send a text frame: ", err)
        return ngx.exit(444)
    end

    bytes, err = wb:send_binary("blah blah blah...")
    if not bytes then
        ngx.log(ngx.ERR, "failed to send a binary frame: ", err)
        return ngx.exit(444)
    end

    local bytes, err = wb:send_close(1000, "enough, enough!")
    if not bytes then
        ngx.log(ngx.ERR, "failed to send the close frame: ", err)
        return
    end