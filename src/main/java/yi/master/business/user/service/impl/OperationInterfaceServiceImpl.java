package yi.master.business.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yi.master.business.base.service.impl.BaseServiceImpl;
import yi.master.business.user.bean.OperationInterface;
import yi.master.business.user.dao.OperationInterfaceDao;
import yi.master.business.user.service.OperationInterfaceService;

/**
 * 操作接口Service接口实现
 * @author xuwangcheng
 * @version 1.0.0.0,2017.2.14
 */

@Service("operationInterfaceService")
public class OperationInterfaceServiceImpl extends BaseServiceImpl<OperationInterface> implements OperationInterfaceService {
	
	private OperationInterfaceDao operationInterfaceDao;
	
	@Autowired
	public void setOperationInterfaceDao(OperationInterfaceDao operationInterfaceDao) {
		super.setBaseDao(operationInterfaceDao);
		this.operationInterfaceDao = operationInterfaceDao;
	}

	@Override
	public List<OperationInterface> listByRoleId(Integer roleId) {
		// TODO Auto-generated method stub
		return operationInterfaceDao.listByRoleId(roleId);
	}

}
