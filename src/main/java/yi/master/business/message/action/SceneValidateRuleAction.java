package yi.master.business.message.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import yi.master.business.base.action.BaseAction;
import yi.master.business.message.bean.MessageScene;
import yi.master.business.message.bean.SceneValidateRule;
import yi.master.business.message.service.SceneValidateRuleService;
import yi.master.constant.ReturnCodeConsts;

/**
 * 报文场景验证结果Action
 * 
 * @author xuwangcheng
 * @version 1.0.0.0,2017.3.6
 */

@Controller
@Scope("prototype")
public class SceneValidateRuleAction extends BaseAction<SceneValidateRule> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer messageSceneId;
	
	private SceneValidateRuleService sceneValidateRuleService;
	
	@Autowired
	public void setSceneValidateRuleService(
			SceneValidateRuleService sceneValidateRuleService) {
		super.setBaseService(sceneValidateRuleService);
		this.sceneValidateRuleService = sceneValidateRuleService;
	}

	
	/**
	 * 全文验证规则更新
	 * @return
	 */
	public String validateFullEdit() {
		sceneValidateRuleService.updateValidate(model.getValidateId(), model.getValidateValue(), model.getParameterName());
		return SUCCESS;
	}
	
	/**
	 * 获取所有的节点验证规则
	 * @return
	 */
	public String getValidates() {
		List<SceneValidateRule> rules = sceneValidateRuleService.getParameterValidate(messageSceneId);

		setData(rules);
		return SUCCESS;
	}
	
	/**
	 * 更新节点验证规则的可用状态
	 * @return
	 */
	public String updateValidateStatus() {
		sceneValidateRuleService.updateStatus(model.getValidateId(), model.getStatus());
		return SUCCESS;
	}
	
	/***********************************GET-SET**********************************************************/
	public void setMessageSceneId(Integer messageSceneId) {
		this.messageSceneId = messageSceneId;
	}

}
