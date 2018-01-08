
App(
   Module,
   "Keygen",
   function ( message ) 
       if message.msgId == "GetKey"  then
          local src           =  ngx.ctx.uid;
          local encode1 =  ngx.encode_base64(src, true);
          local res = {};
          res.code = 0;
          res.key   = encode1;
          ngx.say(cjson.encode(res)); 
       end
   end
);
