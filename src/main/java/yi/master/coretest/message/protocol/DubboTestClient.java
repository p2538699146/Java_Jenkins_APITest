package yi.master.coretest.message.protocol;

import yi.master.business.testconfig.bean.TestConfig;
import yi.master.coretest.message.protocol.entity.ClientTestResponseObject;

import java.util.Map;

/**
 * 基于telnet客户端的invoke方式来调用dubbo接口
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/9/5 19:41
 */
public class DubboTestClient extends TestClient {
    private static DubboTestClient dubboTestClient;

    private DubboTestClient () {}

    public static DubboTestClient getInstance () {
        if (dubboTestClient == null) {
            dubboTestClient = new DubboTestClient();
        }

        return dubboTestClient;
    }

    @Override
    public ClientTestResponseObject sendRequest(String requestUrl, String requestMessage,
                                                Map<String, Object> callParameter, TestConfig config, Object client) {
        return null;
    }


    @Override
    public boolean testInterface(String requestUrl) {
        return false;
    }


    @Override
    public Object getTestClient() {
        return null;
    }

    @Override
    public void putBackTestClient(Object procotolClient) {

    }



}
