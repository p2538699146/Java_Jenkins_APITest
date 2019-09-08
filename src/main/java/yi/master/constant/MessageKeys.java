package yi.master.constant;

import yi.master.coretest.message.parse.*;
import yi.master.coretest.message.process.AnHuiAPPEncryptMessageProcess;
import yi.master.coretest.message.process.MessageProcess;
import yi.master.coretest.message.process.ShanXiOpenApiMessageProcess;
import yi.master.coretest.message.protocol.*;

import java.util.regex.Pattern;

/**
 * 接口报文相关常量
 * @author xuwangcheng
 * @version 2017.12.12,1.0.0.6
 * 
 *
 */
public interface MessageKeys {

	/**
	 * 接口业务类型：CX-查询类接口、SL-办理类接口
	 */
	enum InterfaceBusiType {
		CX,SL;
	}

	/**
	 * 支持的报文格式
	 */
	enum MessageType {
		/**
		 * json类型
		 */
		JSON(new JSONMessageParse()),
		/**
		 * xml类型
		 */
		XML(new XMLMessageParse()),
		/**
		 * url类型
		 */
		URL(new URLMessageParse()),
		/**
		 * 固定类型
		 */
		FIXED(new FixedMessageParse()),
		/**
		 * 自定义类型
		 */
		OPT(new OPTMessageParse());

		private MessageParse parseUtil;

		public MessageParse getParseUtil() {
			return parseUtil;
		}

		public void setParseUtil(MessageParse parseUtil) {
			this.parseUtil = parseUtil;
		}

		private MessageType (MessageParse parseUtil) {
			this.parseUtil = parseUtil;
		}

		public static MessageParse getParseUtilByType (String type) {
			for (MessageType mt:values()) {
				if (mt.name().equalsIgnoreCase(type)) {
					return mt.getParseUtil();
				}
			}
			return OPT.getParseUtil();
		}
	}

	/**
	 * 排序类型
	 */
	enum QueryOrderType {
		DESC,ASC;
	}


	/**
	 * 报文参数节点类型
	 */
	enum MessageParameterType {
		MAP,
		ARRAY,
		NUMBER,
		STRING,
		OBJECT,
		LIST,
		ARRAY_MAP,
		ARRAY_ARRAY,
		CDATA;

		/**
		 * 是否为对象类型：OBJECT MAP ARRAY_MAP
		 * @param type
		 * @return
		 */
		public static boolean isObjectType (String type) {
			if (type == null) {
				return false;
			}

			return Pattern.matches(OBJECT.name() + "|" + MAP.name() + "|" + ARRAY_MAP.name(), type.toUpperCase());
		}

		/**
		 * 是否为数组类型：ARRAY ARRAY_ARRAY LIST
		 * @param type
		 * @return
		 */
		public static boolean isArrayType (String type) {
			if (type == null) {
				return false;
			}

			return Pattern.matches(ARRAY.name() + "|" + ARRAY_ARRAY.name() + "|" + LIST.name(), type.toUpperCase());
		}

		/**
		 * 是否为字符串或者数字类型：STRING NUMBER CDATA
		 * @param type
		 * @return
		 */
		public static boolean isStringOrNumberType(String type) {
			if (type == null) {
				return false;
			}

			return Pattern.matches(STRING.name() + "|" + NUMBER.name() + "|" + CDATA.name(), type.toUpperCase());
		}
	}


	/**
	 * 接口协议类型
	 */
	enum ProtocolType {
		/**
		 * http测试
		 */
		http(new HTTPTestClient()),
		/**
		 * webservice测试
		 */
		webservice(new WebserviceTestClient()),
		/**
		 * socket测试客
		 */
		socket(new SocketTestClient()),
		/**
		 * https测试
		 */
		https(new HTTPTestClient()),
		/**
		 * dubbo测试
		 */
		dubbo(new DubboTestClient());

		private TestClient client;

		private ProtocolType(TestClient client) {
			this.client = client;
		}

		public TestClient getClient() {
			return client;
		}

		public void setClient(TestClient client) {
			this.client = client;
		}

		public static TestClient getClientByType (String type) {
			for (ProtocolType p:values()) {
				if (p.name().equalsIgnoreCase(type)) {
					return p.getClient();
				}
			}

			return null;
		}
	}

	/**
	 * 执行结果中对应的状态<br>
	 */
	enum TestRunStatus {
		/**
		 * 0 - 正常
		 */
		SUCCESS("0"),
		/**
		 * 1 - 执行失败或者验证不通过
		 */
		FAIL("1"),
		/**
		 * 2 -异常结束
		 */
		STOP("2");

		private String code;

		private TestRunStatus (String code) {
			this.code = code;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}
	}

	/**
	 * 报文处理类型
	 */
	enum MessageProcessType {
		ShanXiOpenApi(new ShanXiOpenApiMessageProcess()),
		AnhuiApp(new AnHuiAPPEncryptMessageProcess());

		private MessageProcess processor;

		private MessageProcessType (MessageProcess processor) {
			this.processor = processor;
		}

		public void setProcessor(MessageProcess processor) {
			this.processor = processor;
		}

		public MessageProcess getProcessor() {
			return processor;
		}

		public static MessageProcess getProcessorByType(String type) {
			for (MessageProcessType m:values()) {
				if (m.name().equalsIgnoreCase(type)) {
					return m.getProcessor();
				}
			}

			return null;
		}
	}


	/**协议公共调用参数*/
	public static final String PUBLIC_PARAMETER_CONNECT_TIMEOUT = "ConnectTimeOut";
	public static final String PUBLIC_PARAMETER_READ_TIMEOUT = "ReadTimeOut";
	public static final String PUBLIC_PARAMETER_USERNAME = "Username";
	public static final String PUBLIC_PARAMETER_PASSWORD = "Password";
	public static final String PUBLIC_PARAMETER_METHOD = "Method";


	/**HTTP协议调用参数*/
	public static final String HTTP_PARAMETER_HEADER = "Headers";
	public static final String HTTP_PARAMETER_QUERYS = "Querys";
	public static final String HTTP_PARAMETER_AUTHORIZATION = "Authorization";
	public static final String HTTP_PARAMETER_ENC_TYPE = "EncType";
	public static final String HTTP_PARAMETER_REC_ENC_TYPE = "RecEncType";

	/**webservice协议调用参数*/
	public static final String WEB_SERVICE_PARAMETER_NAMESPACE = "Namespace";


	/**默认path路径根节点*/
	public static final String MESSAGE_PARAMETER_DEFAULT_ROOT_PATH = "TopRoot";


	/**测试环境中默认路径中的替换变量*/
	public static final String BUSINESS_SYSTEM_DEFAULTPATH_NAME_ATTRIBUTE = "\\$\\{name\\}";
	public static final String BUSINESS_SYSTEM_DEFAULTPATH_PATH_ATTRIBUTE = "\\$\\{path\\}";


	/**
	 * 使用节点参数时需要再参数路径左右加上以下左右边界
	 */
	public static final String CUSTOM_PARAMETER_BOUNDARY_SYMBOL_LEFT = "#";
	public static final String CUSTOM_PARAMETER_BOUNDARY_SYMBOL_RIGHT = "#";


	/**
	 * quartz定时任务执行的测试将会在对应的测试报告添加下面的备注
	 */
	public static final String QUARTZ_AUTO_TEST_REPORT_MARK = "自动化定时任务";

	/**
	 * 缺少测试数据时测试详情中的备注
	 */
	public static final String NO_ENOUGH_TEST_DATA_RESULT_MARK = "缺少测试数据";
	
}
