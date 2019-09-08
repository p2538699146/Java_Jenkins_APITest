package yi.master.constant;




/**
 * 系统相关常量
 * @author xuwangcheng
 * @version 1.0.0.0,2017.2.13
 */
public interface SystemConsts {
	/**
	 * 当前版本号
	 */
	public static final String VERSION = "0.1.4beta";


	/**
	 * boolean定义
	 */
	enum DefaultBooleanIdentify  {
		TRUE("true", "1"),
		FALSE("false", "0");

		private String string;
		private String number;

		private DefaultBooleanIdentify (String string, String number) {
			this.string = string;
			this.number = number;
		}

		public void setNumber(String number) {
			this.number = number;
		}

		public void setString(String string) {
			this.string = string;
		}

		public String getNumber() {
			return number;
		}

		public String getString() {
			return string;
		}
	}

	/**
	 * 默认全局的result
	 */
	enum GlobalResultName {
		/**
		 * 用户未登录
		 */
		usernotlogin,
		/**
		 * 操作接口不可用
		 */
		opisdisable,
		/**
		 * 没有权限
		 */
		usernotpower,
		/**
		 * mock接口不存在
		 */
		nonMockInterface,
		/**
		 * mock接口已被禁用
		 */
		mockInterfaceDisabled;

	}

	/**
	 * 一些默认的数据库对象ID
	 */
	enum DefaultObjectId {
		/**
		 * 默认admin角色的roleId
		 */
		ADMIN_ROLE(1),
		/**
		 * 默认default角色的roleId
		 */
		DEFAULT_ROLE(3),
		/**
		 * 默认ADMIN账户的用户ID
		 */
		ADMIN_USER(1),
		/**
		 * 特殊参数的id:数组中的数组参数对象
		 */
		PARAMETER_ARRAY_IN_ARRAY(2),
		/**
		 * 特殊参数的id:数组中的Map参数对象
		 */
		PARAMETER_MAP_IN_ARRAY(3),
		/**
		 * 特殊参数的id:Object对象 对应外层
		 */
		PARAMETER_OBJECT(1);

		private int id;

		private DefaultObjectId (int id) {
			this.id = id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public int getId() {
			return id;
		}
	}

	
	/**
	 * 请求带上此token代表为内部自调用接口，不需要验证权限
	 */
	public static final String REQUEST_ALLOW_TOKEN = "ec189a1731d73dfe16d8f9df16d67187";
	
	
	/**
	 * 管理员角色名
	 * 
	 */
	public static final String SYSTEM_ADMINISTRATOR_ROLE_NAME = "admin";



	/**
	 * sessionMap中登录用户key值
	 */
	public static final String SESSION_ATTRIBUTE_LOGIN_USER = "user";

	//ApplicationMap中指定属性名
	public static final String APPLICATION_ATTRIBUTE_OPERATION_INTERFACE = "ops";
	
	//SessionMap中指定属性名
	public static final String SESSION_ATTRIBUTE_VERIFY_CODE = "verifyCode";
	
	//定时任务相关标志词语	
	public static final String QUARTZ_TIME_TASK_NAME_PREFIX_KEY = "timeScheduleJob";
	public static final String QUARTZ_PROBE_TASK_NAME_PREFIX_KEY = "probeScheduleJob";	
	public static final String QUARTZ_SCHEDULER_START_FLAG = "quartzStatus";	
	public static final String QUARTZ_SCHEDULER_IS_START = "true"; 	
	public static final String QUARTZ_SCHEDULER_IS_STOP = "false";
	
	///////////////////////////////////全局设置指定设置名称/////////////////////////////////////////////////////////////////////
	/**
	 * 通用设置
	 */
	public static final String GLOBAL_SETTING_HOME = "home";
	public static final String GLOBAL_SETTING_VERSION = "version";
	public static final String GLOBAL_SETTING_LOGSWITCH = "logSwitch";

	/**
	 * 接口自动化测试相关全局配置
	 */
	public static final String GLOBAL_SETTING_MESSAGE_ENCODING = "messageEncoding";
	public static final String GLOBAL_SETTING_MESSAGE_REPORT_TITLE = "messageReportTitle";
	/**
	 * 邮件推送格式
	 */
	public static final String GLOBAL_SETTING_MESSAGE_MAIL_STYLE = "messageMailStyle";
	/**
	 * 探测邮件格式
	 */
	public static final String GLOBAL_SETTING_MESSAGE_MAIL_STYLE_PROBE_REPORT = "probe";
	/**
	 * 定时任务邮件格式
	 */
	public static final String GLOBAL_SETTING_MESSAGE_MAIL_STYLE_TASK_REPORT = "time";

	/**
	 * web自动化脚本相关
	 */
	public static final String GLOBAL_SETTING_WEB_SCRIPT_WORKPLACE = "webscriptWorkPlace";
	public static final String GLOBAL_SETTING_WEB_SCRIPT_MODULE_PATH = "webscriptModulePath";

	/**
	 * 邮箱推送相关
	 */
	public static final String GLOBAL_SETTING_IF_SEND_REPORT_MAIL = "sendReportMail";
	public static final String GLOBAL_SETTING_MAIL_SERVER_HOST = "mailHost";
	public static final String GLOBAL_SETTING_MAIL_SERVER_PORT = "mailPort";
	public static final String GLOBAL_SETTING_MAIL_AUTH_USERNAME = "mailUsername";
	public static final String GLOBAL_SETTING_MAIL_AUTH_PASSWORD = "mailPassword";
	public static final String GLOBAL_SETTING_MAIL_RECEIVE_ADDRESS = "mailReceiveAddress";
	public static final String GLOBAL_SETTING_MAIL_COPY_ADDRESS = "mailCopyAddress";
	public static final String GLOBAL_SETTING_MAIL_SSL_FLAG = "mailSSL";
	public static final String GLOBAL_SETTING_MAIL_SEND_ADDRESS = "mailSendAddress";
	public static final String GLOBAL_SETTING_MAIL_PERSONAL_NAME = "mailPersonalName";
	
	/**
	 * 日志记录接口白名单
	 */
	public static final String GLOBAL_SETTING_LOG_RECORD_WHITELIST = "logRecordWhitelist";
	/**
	 * 日志记录接口黑名单
	 */
	public static final String GLOBAL_SETTING_LOG_RECORD_BLACKLIST = "logRecordBlacklist";
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/**
	 * 测试报告静态html存储文件夹
	 */
	public static final String REPORT_VIEW_HTML_FOLDER = "reportHtml";
	/**
	 * 静态报告模板
	 */
	public static final String REPORT_VIEW_HTML_FIXED_HTML_NEW = "offlineReportTemplateNew.xml";
	/**
	 * 测试集测试请求地址
	 */
	public static final String AUTO_TASK_TEST_RMI_URL = "test-scenesTest";
	
	/**
	 * 接口探测测试请求地址
	 */
	public static final String PROBE_TASK_TEST_RMI_URL = "test-probeTest";
	
	/**
	 * 生成静态报告请求地址
	 */
	public static final String CREATE_STATIC_REPORT_HTML_RMI_URL = "report-generateStaticReportHtml";
	
	/**
	 * 上传或者下载 excel保存的文件夹
	 */
	public static final String EXCEL_FILE_FOLDER = "excel";


	/**
	 * 检查版本升级的网址
	 */
	public static final String CHECK_VERSION_UPGRADE_URL = "http://www.xuwangcheng.com/yi/api/checkVersion";
	//public static final String CHECK_VERSION_UPGRADE_URL = "http://localhost:8080/api/checkVersion";

	/**
	 * 版本升级地址
	 */
	public static final String VERSION_UPGRADE_URL = "https://gitee.com/xuwangcheng/masteryi-automated-testing/wikis/pages?sort_id=1608611&doc_id=196989";
}
