package yi.master.business.user.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import yi.master.business.base.dao.impl.BaseDaoImpl;
import yi.master.business.user.bean.OperationInterface;
import yi.master.business.user.dao.OperationInterfaceDao;

/**
 * 操作接口DAO接口实现
 * @author xuwangcheng
 * @version 1.0.0.0,2017.2.14
 */

@Repository("operationInterfaceDao")
public class OperationInterfaceDaoImpl extends BaseDaoImpl<OperationInterface> implements OperationInterfaceDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<OperationInterface> listByRoleId(Integer roleId) {
		// TODO Auto-generated method stub
		String hql = "select o from OperationInterface o join o.roles r where r.roleId=:roleId";
		return getSession().createQuery(hql).setInteger("roleId", roleId).list();
	}

}
