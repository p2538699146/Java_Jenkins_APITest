package yi.master.coretest.message.protocol;

import yi.master.business.testconfig.bean.TestConfig;
import yi.master.coretest.message.protocol.entity.ClientTestResponseObject;

import java.util.Map;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/9/12 8:59
 */
public class WebSocketTestClient extends TestClient {
    private static WebSocketTestClient webSocketTestClient;
    private WebSocketTestClient () {}

    public static WebSocketTestClient getInstance () {
        if (webSocketTestClient == null) {
            webSocketTestClient = new WebSocketTestClient();
        }

        return webSocketTestClient;
    }

    @Override
    public ClientTestResponseObject sendRequest(String requestUrl, String requestMessage, Map<String, Object> callParameter, TestConfig config, Object client) {
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
    public void putBackTestClient(Object protocolClient) {

    }
}
