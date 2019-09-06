package yi.master.coretest.message.process;

import yi.master.constant.MessageKeys;

/**
 * 在进行测试前需要进行特殊处理的操作,比如加密、解密、格式化等
 * @author xuwangcheng
 * @version 2018.4.19
 *
 */
public abstract class MessageProcess {
	
	/**
	 * 处理请求报文
	 * @param requestMessage 请求报文
	 * @param processParameter 处理类型的参数设定
	 * @return 返回经过处理的入参报文
	 */
	public abstract String processRequestMessage(String requestMessage, String processParameter);
	/**
	 * 处理返回报文
	 * @param responseMessage 返回保温
	 * @param processParameter 处理参数
	 * @return 返回仅供处理的出参报文
	 */
	public abstract String processResponseMessage(String responseMessage, String processParameter);
	
	
	public static MessageProcess getProcessInstance(String processType) {
		return MessageKeys.MessageProcessType.getProcessorByType(processType);
	}	
}
