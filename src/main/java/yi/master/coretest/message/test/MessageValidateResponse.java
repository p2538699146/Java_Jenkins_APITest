package yi.master.coretest.message.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yi.master.business.message.bean.MessageScene;
import yi.master.business.message.bean.SceneValidateRule;
import yi.master.business.message.enums.CommonStatus;
import yi.master.business.message.enums.SceneValidateType;
import yi.master.business.message.enums.SceneValidateValueGetMethod;
import yi.master.business.message.service.SceneValidateRuleService;
import yi.master.business.testconfig.bean.DataDB;
import yi.master.business.testconfig.service.GlobalVariableService;
import yi.master.coretest.message.parse.MessageParse;
import yi.master.util.DBUtil;
import yi.master.util.PracticalUtils;
import yi.master.util.cache.CacheUtil;

/**
 * 接口自动化<br>
 * 返回验证
 * <br>
 * 20171123 不同类型的验证规则可以同时存在
 * 
 * @author xuwangcheng
 * @version 1.1.0.0, 20171123
 *
 */
@Service
public class MessageValidateResponse {
	
	@Autowired
	private SceneValidateRuleService validateRuleService;
	
	private static final Logger LOGGER = Logger.getLogger(MessageValidateResponse.class.getName());
	
	private ObjectMapper mapper = new ObjectMapper();
	
	public static final String VALIDATE_MAP_STATUS_KEY = "status";
	public static final String VALIDATE_MAP_MSG_KEY = "msg";

	public static final String VALIDATE_SUCCESS_FLAG = "0";
	public static final String VALIDATE_FAIL_FLAG = "1";
	@Autowired
	private GlobalVariableService globalVariableService;
	
	/**
	 * 
	 * @param responseMessage
	 * @param requestMessage
	 * @param scene
	 * @return Map&lt;String, String&gt;<br>
	 * status 验证结果 0-成功 1-不成功<br>
	 * msg 备注信息 
	 */
	public Map<String,String> validate(String responseMessage, String requestMessage, MessageScene scene, String messageType) {
		List<SceneValidateRule> rules = validateRuleService.getParameterValidate(scene.getMessageSceneId());
		
		if (rules.size() < 1) {
			Map<String,String> map = new HashMap<String, String>();
			map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_SUCCESS_FLAG);
			map.put(VALIDATE_MAP_MSG_KEY, "没有找到需要验证的规则条目,默认测试成功!");
			return map;
		}
		
		MessageParse parseUtil = MessageParse.getParseInstance(messageType);
		
		String passFlag = VALIDATE_SUCCESS_FLAG;
		Map<String, String> validateMap = new HashMap<String, String>();
		StringBuilder msg = new StringBuilder();
		
		int totalCount = 0;
		int successCount = 0;
		int failCount = 0;
		
		for (SceneValidateRule rule:rules) {			
			//状态为0可验证
			if (!CommonStatus.ENABLED.getStatus().equals(rule.getStatus())) {
				continue;
			}
			totalCount ++;
			Map<String, String> resultMap = null;
			//关键字匹配验证,通过左右边界
			if (SceneValidateType.ASSOCIATED_VALIDATION.getType().equals(rule.getValidateMethodFlag())) {
				resultMap = relateKeyValidate(responseMessage, requestMessage, rule, parseUtil);
				//节点参数验证，复杂验证
			} else if (SceneValidateType.NODE_VALIDATION.getType().equals(rule.getValidateMethodFlag())) {
				resultMap = nodeParameterValidate(responseMessage, requestMessage, rule, parseUtil);
			}
			
			msg.append(resultMap.get(VALIDATE_MAP_MSG_KEY) + "\n");
			if (!VALIDATE_SUCCESS_FLAG.equals(resultMap.get(VALIDATE_MAP_STATUS_KEY))) {
				passFlag = "1";
				failCount ++;
			} else {
				successCount ++;
			}
		}		
		validateMap.put(VALIDATE_MAP_STATUS_KEY, passFlag);
		validateMap.put(VALIDATE_MAP_MSG_KEY, msg + "\n总共" + totalCount + "条验证规则,成功" 
						+ successCount + "条,失败" + failCount + "条。");
		return validateMap;		
	}
	
	/**
	 * 关联左右边界取值
	 * @param responseMessage
	 * @param requestMessage
	 * @param rule
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private Map<String, String> relateKeyValidate(String responseMessage, String requestMessage, SceneValidateRule rule, MessageParse parseUtil) {
		Map<String,String> map = new HashMap<String, String>();
		Map maps = null;
		try {
			maps = mapper.readValue(rule.getParameterName(), Map.class);
		} catch (Exception e) {
			LOGGER.error("解析关键字关联验证规则出错!", e);
		}
		
		if (maps == null) {
			map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_FAIL_FLAG);
			map.put(VALIDATE_MAP_MSG_KEY, "关联验证配置出错，请检查或者重新设置!");
			return map;
		}
		
		String getValue = PracticalUtils.getValueByRelationKeyWord(maps, responseMessage);
		if (getValue == null) {
			map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_FAIL_FLAG);
			map.put(VALIDATE_MAP_MSG_KEY, "根据指定的左右边界等参数无法在出参报文中匹配到相应的内容,请检查!");
			return map;
		}
		
		StringBuilder msg = new StringBuilder("【关联验证】");
		String validateValue = rule.getValidateValue();
		
		
		//字符串
		if (SceneValidateValueGetMethod.CONSTANT.getMethod().equals(rule.getGetValueMethod())
				|| StringUtils.isBlank(rule.getGetValueMethod())) {
			validateValue = PracticalUtils.replaceGlobalVariable(rule.getValidateValue(), globalVariableService);
		}
		
		//入参节点获取
		if (SceneValidateValueGetMethod.REQUEST_PARAMS_NODE.getMethod().equals(rule.getGetValueMethod())) {
			validateValue = parseUtil.getObjectByPath(requestMessage, rule.getValidateValue());
			
			if (validateValue == null) {
				map.put(VALIDATE_MAP_MSG_KEY, msg + "在入参报文中没有找到路径为 " + rule.getValidateValue() + " 的节点,请检查验证规则!");
				return map;
			}
		} 
		
		//全局变量
		if (SceneValidateValueGetMethod.GLOBAL_VARIABLE.getMethod().equals(rule.getGetValueMethod())) {
			validateValue = PracticalUtils.replaceGlobalVariable(rule.getValidateValue(), globalVariableService);
		}
		msg.append("预期结果为 [" + validateValue + "] ,与实际结果 [" + getValue + "] ");
		
		boolean flag = false;
		
		if (SceneValidateValueGetMethod.REGULAR_EXPRESSION.getMethod().equals(rule.getGetValueMethod())) {
			flag = Pattern.matches(rule.getValidateValue(), getValue);
		} else {
			flag = getValue.equals(validateValue);
		}
		
		if (!flag) {
			map.put(VALIDATE_MAP_MSG_KEY, msg.append("验证不一致,验证失败!").toString());
			return map;				
		}	
	
		map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_SUCCESS_FLAG);
		map.put(VALIDATE_MAP_MSG_KEY,msg.append("验证一致,验证成功!").toString());
		return map;
	}
	
	/**
	 * 针对返回报文中各个指定path的节点进行验证<br>
	 * 出错则停止验证并返回失败标记
	 * @param responseMessage
	 * @param requestMessage
	 * @param rule
	 * @param parseUtil
	 * @return
	 */
	private Map<String, String> nodeParameterValidate(String responseMessage, String requestMessage, SceneValidateRule rule, MessageParse parseUtil) {
		Map<String,String> map = new HashMap<String, String>();
		map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_FAIL_FLAG);
		StringBuilder msg = new StringBuilder();		
		//不是指定的格式，不能用此方式验证
		MessageParse responseMessageParseUtil = MessageParse.judgeMessageType(responseMessage);

		
		msg.append("【节点验证】在验证出参节点路径为 " + rule.getParameterName() + " 时: ");
		
		String vaildateStr = responseMessageParseUtil.getObjectByPath(responseMessage, rule.getParameterName());
		
		if (vaildateStr == null) {
			map.put(VALIDATE_MAP_MSG_KEY, msg + "返回报文中没有找到该路径节点,请检查验证规则!");
			return map;
		}
		
		String validateValue = rule.getValidateValue();
		
		//字符串
		if (rule.getGetValueMethod().equals(SceneValidateValueGetMethod.CONSTANT.getMethod())) {
			validateValue = PracticalUtils.replaceGlobalVariable(rule.getValidateValue(), globalVariableService);
		}
		
		//入参节点获取
		if (rule.getGetValueMethod().equals(SceneValidateValueGetMethod.REQUEST_PARAMS_NODE.getMethod())) {
			validateValue = parseUtil.getObjectByPath(requestMessage, rule.getValidateValue());
			
			if (validateValue == null) {
				map.put(VALIDATE_MAP_MSG_KEY, msg + "在入参报文中没有找到路径为 " + rule.getValidateValue() + " 的节点,请检查验证规则!");
				return map;
			}
		} 
		
		//全局变量
		if (rule.getGetValueMethod().equals(SceneValidateValueGetMethod.GLOBAL_VARIABLE.getMethod())) {
			validateValue = PracticalUtils.replaceGlobalVariable(rule.getValidateValue(), globalVariableService);
		}
		
		//数据库获取
		if (rule.getGetValueMethod().startsWith(SceneValidateValueGetMethod.QUERY_SQL.getMethod())) {
			DataDB db = CacheUtil.getQueryDBById(rule.getGetValueMethod());
			
			if (db == null) {
				map.put(VALIDATE_MAP_MSG_KEY, msg + "没有找到dbId为 " + rule.getGetValueMethod() + " 查询数据信息!");
				return map;
			}
			
			String querySql = PracticalUtils.replaceGlobalVariable(
					parseUtil.parameterReplaceByNodePath(requestMessage, rule.getValidateValue()), globalVariableService);
			
			validateValue = DBUtil.getDBData(db, querySql);
			
			if (validateValue == null) {
				map.put(VALIDATE_MAP_MSG_KEY, msg + "从查询数据库 " + db.getDbName() + " 中查询数据出错[" + querySql + "]");
				return map;
			}
		}
		msg.append("预期结果为 [" + validateValue + "] ,与实际结果 [" + vaildateStr + "] ");
		
		boolean flag = false;
		
		if (rule.getGetValueMethod().equals(SceneValidateValueGetMethod.REGULAR_EXPRESSION.getMethod())) {
			flag = Pattern.matches(rule.getValidateValue(), vaildateStr);
		} else {
			flag = vaildateStr.equals(validateValue);
		}
		
		if (!flag) {
			map.put(VALIDATE_MAP_MSG_KEY, msg.append("验证不一致,验证失败!").toString());
			return map;				
		}	
	
		map.put(VALIDATE_MAP_STATUS_KEY, VALIDATE_SUCCESS_FLAG);
		map.put(VALIDATE_MAP_MSG_KEY,msg.append("验证一致,验证成功!").toString());
		return map;
	}
}
