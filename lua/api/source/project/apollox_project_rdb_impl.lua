

App(
   Module,
   "Test",
   function ( message ) 
       ngx.header["Content-Type"] = "text/html";
       if message.msgId == "Get" then
              ngx.say( exports.rdb_client.get("A"));
       end
       if message.msgId == "Set" then
               local result = exports.rdb_client.set("A","Hellow I am From RDB");
               ngx.say(result)
       end
       if message.msgId == "Key"  then
          local src           =  ngx.ctx.uid;
          local encode1 =  ngx.encode_base64(src, true);
          ngx.say("raw  ", src);
          ngx.say("encode ", encode1);
          ngx.say("decode ",ngx.decode_base64(encode1))
       end
   end
);
