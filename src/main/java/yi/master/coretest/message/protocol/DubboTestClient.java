package yi.master.coretest.message.protocol;

import org.apache.commons.net.telnet.TelnetClient;
import yi.master.business.testconfig.bean.TestConfig;
import yi.master.constant.MessageKeys;
import yi.master.coretest.message.protocol.entity.ClientTestResponseObject;
import yi.master.util.PracticalUtils;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
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

    public static final Character lastChar = '>';
    public static final String endingTag = "dubbo>";

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
        ClientTestResponseObject responseObject = new ClientTestResponseObject();
        int connectTimeOut = config.getConnectTimeOut();
        int readTimeOut = config.getReadTimeOut();
        if (callParameter != null) {
            try {
                if (PracticalUtils.isNumeric(callParameter.get(MessageKeys.PUBLIC_PARAMETER_READ_TIMEOUT))) {
                    readTimeOut = Integer.parseInt((String) callParameter.get(MessageKeys.PUBLIC_PARAMETER_READ_TIMEOUT));
                }
                if (PracticalUtils.isNumeric(callParameter.get(MessageKeys.PUBLIC_PARAMETER_CONNECT_TIMEOUT))) {
                    connectTimeOut = Integer.parseInt((String) callParameter.get(MessageKeys.PUBLIC_PARAMETER_CONNECT_TIMEOUT));
                }
            } catch (Exception e) {
                LOGGER.info("报文附加参数获取出错:" + callParameter.toString(), e);
            }
        }
        TelnetClient telnetClient = null;
        try {
            telnetClient = createClient(requestUrl, connectTimeOut, readTimeOut);
        } catch (IOException e) {
            responseObject.setStatusCode("false");
            responseObject.setMark("无法连接到:" + requestUrl);
        }

        if (telnetClient != null && telnetClient.isConnected()) {
            PrintStream out = new PrintStream(telnetClient.getOutputStream());
            InputStream in = telnetClient.getInputStream();

            try {
                long start = System.currentTimeMillis();
                String responseMsg = sendMsg("invoke " + requestUrl.split(":")[2] + "(" + requestMessage + ")", out, in);
                long end = System.currentTimeMillis();

                if (requestMessage != null) {
                    int i = responseMsg.lastIndexOf("\r\n");
                    responseMsg = responseMsg.substring(0, i);
                }

                responseObject.setStatusCode("200");
                responseObject.setUseTime(end - start);
                responseObject.setResponseMessage(responseMsg);
            } catch (IOException e) {
                responseObject.setStatusCode("false");
                responseObject.setMark("发送请求失败:\n" + PracticalUtils.getExceptionAllinformation(e));
            } finally {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    try {
                        in.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (telnetClient.isConnected()) {
                    try {
                        telnetClient.disconnect();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        return responseObject;
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


    /**
     * 通过telnet发送信息
     * @param requestMsg
     * @param out
     * @param in
     * @return
     * @throws IOException
     */
    private String sendMsg (String requestMsg, PrintStream out, InputStream in) throws IOException {
        StringBuilder replyMessage = new StringBuilder("");
        out.println(requestMsg);
        out.flush();

        char ch = (char) in.read();
        while (true) {
            replyMessage.append(ch);
            if (ch == lastChar) {
                if (replyMessage.toString().endsWith(endingTag)) {
                    return replyMessage.toString();
                }
            }
            ch = (char) in.read();
        }
    }

    /**
     * 创建telnet客户端
     * @param host
     * @param connectTimeout
     * @param soTimeout
     * @return
     * @throws IOException
     */
    private TelnetClient createClient (String host, int connectTimeout, int soTimeout) throws IOException {
        TelnetClient client = new TelnetClient();
        String[] ss = host.split(":");
        client.connect(ss[0], Integer.valueOf(ss[1]));
        client.setConnectTimeout(connectTimeout);
        client.setSoTimeout(soTimeout);

        return client;
    }
}
