


import com.aliyun.oss.OSSClient
import com.aliyun.oss.model.GetObjectRequest

import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import redis.clients.jedis.Jedis
import redis.clients.jedis.JedisPubSub

class RedisMsgPubSubListener extends JedisPubSub {
    @Override
    public void unsubscribe() {
        super.unsubscribe();
    }
  
    @Override
    public void unsubscribe(String... channels) {
        super.unsubscribe(channels);
    }
  
    @Override
    public void subscribe(String... channels) {
        super.subscribe(channels);
    }
  
    @Override
    public void psubscribe(String... patterns) {
        super.psubscribe(patterns);
    }
  
    @Override
    public void punsubscribe() {
        super.punsubscribe();
    }
  
    @Override
    public void punsubscribe(String... patterns) {
        super.punsubscribe(patterns);
    }
    
    def procMessageHandle ;
    @Override
    public void onMessage(String channel, String message) {
        //System.out.println("channel:" + channel + "receives message :" + message);
        if(message) {
            try {
                def msg = Env.json_decode(message)
                
                if(procMessageHandle) {
                    procMessageHandle.call(msg)
                }
            } catch (e) {
                println(e);
            }
        }
    }
  
    @Override
    public void onPMessage(String pattern, String channel, String message) {
        System.out.println("onPMessage:channel" + channel + "is been subscribed:" + subscribedChannels);
    }
  
    @Override
    public void onSubscribe(String channel, int subscribedChannels) {
        System.out.println("onSubscribe:channel" + channel + "is been subscribed:" + subscribedChannels);
    }
  
    @Override
    public void onPUnsubscribe(String pattern, int subscribedChannels) {
  
    }
  
    @Override
    public void onPSubscribe(String pattern, int subscribedChannels) {
  
    }
  
    @Override
    public void onUnsubscribe(String channel, int subscribedChannels) {
        System.out.println("channel:" + channel + "is been unsubscribed:" + subscribedChannels);
    }
}
class Env {
    static def json_encode = { obj -> new JsonOutput().toJson(obj) }
    static def json_decode = { text-> new JsonSlurper().parseText(text)}
    static def log = {text-> println(text)}
    
    public static void command(cmd) {
        def proc = cmd.execute()
        proc.waitFor();
    }
}
///默认java订阅行为会阻塞程序运行
///使用之后需要取消订阅恢复运行


def appName = null


try {
    appName = args[0]
} catch (e) {
    appName = "test"
}
println("begin daemon")

Jedis jedis = new Jedis("182.254.145.145",6379);
jedis.auth("1q2w3e4r.");

RedisMsgPubSubListener listener = new RedisMsgPubSubListener();
listener.procMessageHandle = { 
    message ->
    println(message)
    switch (message.msgId) {
        case "publishNewVersion":
            
            String endpoint    = "http://oss-cn-beijing.aliyuncs.com";
            String accessKeyId = "LTAIyXPfgbfqSBp9";
            String accessKeySecret = "VvUzCJFt2uvr9klJzryYSIKy2i5h4S";
            String bucketName      = "apollox-oss"
            
            def time_t=System.currentTimeMillis()
            
            OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
            def file = new File("/tmp/${message.fileName}")
            ossClient.getObject(new GetObjectRequest(bucketName, message.path), file);
            println(System.currentTimeMillis() - time_t)
            ossClient.shutdown();
            Env.command("sh /home/admin/start.sh /tmp/${message.fileName}")
        break;
    }
}
jedis.subscribe(listener, appName);
