package yi.master.coretest.message.protocol;

import org.apache.log4j.Logger;
import yi.master.business.testconfig.bean.TestConfig;
import yi.master.constant.MessageKeys;
import yi.master.coretest.message.protocol.entity.ClientTestResponseObject;
import yi.master.coretest.message.test.TestMessageScene;

import java.util.Map;

/**
 * 
 * 测试客户端，不同协议的请求通过工厂方法获取
 * @author xuwangcheng
 * @version 1.0.0.0,2017.4.24
 *
 */
public abstract class TestClient {
	
	public static final Logger LOGGER = Logger.getLogger(TestClient.class.getName());

	/**
	 * 发送测试请求到指定接口地址
	 * @param requestUrl  请求地址
	 * @param requestMessage 请求报文
	 * @param callParameter  自定义的请求参数,不同类型报文格式，不同请求协议需要不同的配置规则
	 * @param config 用户的测试配置，不会再这里面配置太多内容
	 * @return  测试结果详情
	 * 
	 */
	public abstract ClientTestResponseObject sendRequest(String requestUrl, String requestMessage, Map<String, Object> callParameter, TestConfig config, Object client);
	
	public ClientTestResponseObject  sendRequest(TestMessageScene scene, Object client) {
		return sendRequest(scene.getRequestUrl(), scene.getRequestMessage(), scene.getCallParameter(), scene.getConfig(), client);
	};
	
	/**
	 * 测试该接口地址是否可通
	 * @param requestUrl
	 * @return
	 */
	public abstract boolean testInterface(String requestUrl);
	
	/**
	 * 获取一个全新的测试客户端
	 */
	public abstract Object getTestClient();
	
	/**
	 * 将测试客户端放回池子中
	 */
	public abstract void putBackTestClient(Object protocolClient);
	
	/**
	 * 根据协议类型返回指定的测试客户端
	 * 
	 * @param type 协议类型 目前支持的：http/https webservice socket
	 * @return
	 */
	public static TestClient getTestClientInstance(String type) {
		return MessageKeys.ProtocolType.getClientByType(type);
	}
	
}
