package yi.master.business.system.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import yi.master.business.base.action.BaseAction;
import yi.master.business.system.bean.BusiMenuInfo;
import yi.master.business.system.service.BusiMenuInfoService;
import yi.master.business.user.bean.User;
import yi.master.util.FrameworkUtil;


@Controller
@Scope("prototype")
public class BusiMenuInfoAction extends BaseAction<BusiMenuInfo> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private BusiMenuInfoService busiMenuInfoService;
	
	@Autowired
	public void setBusiMenuInfoService(BusiMenuInfoService busiMenuInfoService) {
		super.setBaseService(busiMenuInfoService);
		this.busiMenuInfoService = busiMenuInfoService;
	}
	
	@Override
	public String edit() {
		if (model.getParentNodeId2() != null) {
			model.setParentNode(new BusiMenuInfo(model.getParentNodeId2()));
		}
		if (model.getMenuId() == null) {
			model.setCreateUser((User) FrameworkUtil.getSessionMap().get("user"));
		}		
		return super.edit();
	}

}
