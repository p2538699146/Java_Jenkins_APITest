package yi.master.business.advanced.action;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import yi.master.business.advanced.bean.InterfaceMock;
import yi.master.business.advanced.bean.config.mock.MockRequestValidateConfig;
import yi.master.business.advanced.bean.config.mock.MockResponseConfig;
import yi.master.business.advanced.bean.config.mock.MockValidateRuleConfig;
import yi.master.business.advanced.enums.InterfaceMockStatus;
import yi.master.business.base.dto.ParseMessageToNodesOutDTO;
import yi.master.business.advanced.service.InterfaceMockService;
import yi.master.business.base.action.BaseAction;
import yi.master.business.message.bean.Parameter;
import yi.master.business.user.bean.User;
import yi.master.constant.MessageKeys;
import yi.master.coretest.message.parse.MessageParse;
import yi.master.coretest.message.test.mock.MockSocketServer;
import yi.master.exception.AppErrorCode;
import yi.master.exception.YiException;
import yi.master.util.FrameworkUtil;
import yi.master.util.PracticalUtils;
import yi.master.util.cache.CacheUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 接口mock相关接口
 * @author xuwangcheng
 * @version 20180612
 *
 */
@Controller
@Scope("prototype")
public class InterfaceMockAction extends BaseAction<InterfaceMock> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOGGER = Logger.getLogger(InterfaceMockAction.class);
	
	private InterfaceMockService interfaceMockService;
	
	private String message;
	
	@Autowired
	public void setInterfaceMockService(
			InterfaceMockService interfaceMockService) {
		super.setBaseService(interfaceMockService);
		this.interfaceMockService = interfaceMockService;
	}
	
	
	public String updateStatus() {
		interfaceMockService.updateStatus(model.getMockId(), model.getStatus());
		return SUCCESS;
	}
	
	@Override
	public String edit(){
		if (model.getMockId() == null) {
			model.setUser(FrameworkUtil.getLoginUser());
			model.setRequestValidate(JSONObject.fromObject(new MockRequestValidateConfig()).toString());
			model.setResponseMock(JSONObject.fromObject(new MockResponseConfig()).toString());
			model.setMockId(interfaceMockService.save(model));
		} else {
			interfaceMockService.edit(model);
		}
		
		//开启Socket模拟服务
		MockSocketServer server = CacheUtil.getSocketServers().get(model.getMockId());
		
		if (server != null && (InterfaceMockStatus.DISABLED.getStatus().equals(model.getStatus())
				|| !MessageKeys.ProtocolType.socket.name().equalsIgnoreCase(model.getProtocolType()))) {
			server.stop();
		}
		
		if (server == null && InterfaceMockStatus.ENABLED.getStatus().equals(model.getStatus())
				&& MessageKeys.ProtocolType.socket.name().equalsIgnoreCase(model.getProtocolType())) {
			try {
				new MockSocketServer(model.getMockId());
			} catch (Exception e) {
				LOGGER.warn(e.getMessage(), e);
			}
		}
		
		setData(model);
		return SUCCESS;
	}
	
	/**
	 * 更新配置内容
	 * @return
	 */
	public String updateSetting (){
		String settingType = "";
		String settingValue = "";
		if (StringUtils.isNotBlank(model.getResponseMock())) {
			settingType = "responseMock";
			settingValue = model.getResponseMock();
		}
		if (StringUtils.isNotBlank(model.getRequestValidate())) {
			settingType = "requestValidate";
			settingValue = model.getRequestValidate();
		}
		interfaceMockService.updateSetting(model.getMockId(), settingType, settingValue);
		MockSocketServer thisSocket = CacheUtil.getSocketServers().get(model.getMockId());
		if (thisSocket != null) {
			thisSocket.updateConfig(settingType, settingValue);
		}

		return SUCCESS;
	}
	
	
	/**
	 * 解析入参报文成默认的验证规则
	 * @return
	 */
	public String parseMessageToConfig() {
		MessageParse parseUtil = MessageParse.getParseInstance(MessageParse.judgeType(message));
		Set<Parameter> parameters = parseUtil.importMessageToParameter(message, null);
		JSONArray rules = new JSONArray();
		for (Parameter param:parameters) {
			if (MessageKeys.MessageParameterType.isStringOrNumberType(param.getType())) {
				MockValidateRuleConfig rule = new MockValidateRuleConfig();
				rule.setName(param.getParameterIdentify());
				rule.setPath(param.getPath().replaceAll(MessageKeys.MESSAGE_PARAMETER_DEFAULT_ROOT_PATH + "\\.*", ""));
				rule.setType(param.getType());
				rule.setValidateValue(param.getDefaultValue());
				rules.add(rule);
			}
		}
		setData(rules.toString());
		return SUCCESS;
	}
	
	/**
	 * 解析指定的示例报文成适合ztree的tree node
	 * @return
	 */
	public String parseMessageToNodes() {
		MessageParse parseUtil = MessageParse.getParseInstance(MessageParse.judgeType(message));
		Set<Parameter> params = parseUtil.importMessageToParameter(message, new HashSet<Parameter>());
		if (params == null) {
			throw new YiException(AppErrorCode.NO_RESULT.getCode(), "尚不支持此类型的报文格式，请检查出报文格式!");
		}
		//自定义parmeterId
		int count = 1;
		for (Parameter p:params) {
			p.setParameterId(count++);
		}
		
		Object[] os = PracticalUtils.getParameterZtreeMap(params);
		
		if (os == null) {
			throw new YiException(AppErrorCode.NO_RESULT.getCode(), "没有可用的参数,请检查!");
		}
		setData(new ParseMessageToNodesOutDTO(os[0], Integer.parseInt(os[1].toString()), os[2].toString()));

		return SUCCESS;
	}
	
	@Override
	public void checkObjectName() {
		InterfaceMock mock = interfaceMockService.findByMockUrl(model.getMockUrl());
		checkNameFlag = (mock != null && !mock.getMockId().equals(model.getMockId())) ? "请求路径重复" : "true";
		
		if (model.getMockId() == null) {
			checkNameFlag = (mock == null) ? "true" : "请求路径重复";
		}
	}
	
	
	public void setMessage(String message) {
		this.message = message;
	}
	
}	
