package yi.master.test;

import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

import java.net.InetSocketAddress;
import java.net.URISyntaxException;

/**
 * Created by Administrator on 2019/9/13.
 */
public class WebSocketTest {
    public static void main(String[] args) throws URISyntaxException {
        WebSocketServer server = new WebSocketServer(new InetSocketAddress(9787)) {

            @Override
            public void onStart() {
                System.out.println("start...");

            }

            @Override
            public void onOpen(WebSocket arg0, ClientHandshake arg1) {
                System.out.println("open...");
                System.out.println(arg0.getRemoteSocketAddress().getPort());
            }

            @Override
            public void onMessage(WebSocket arg0, String arg1) {
                System.out.println("收到消息..." + arg1);
                arg0.send("aasssss");
            }

            @Override
            public void onError(WebSocket arg0, Exception arg1) {
                arg1.printStackTrace();
            }

            @Override
            public void onClose(WebSocket arg0, int arg1, String arg2, boolean arg3) {
                System.out.println("close...");
                arg0.close();
            }
        };

        server.start();
    }
}