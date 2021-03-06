package yi.master.business.testconfig.dao;

import yi.master.business.base.dao.BaseDao;
import yi.master.business.testconfig.bean.TestConfig;

/**
 * 接口自动化<br>
 * 测试配置Dao接口类
 * @author xuwangcheng
 * @version 1.0.0.0,20170428
 *
 */
public interface TestConfigDao extends BaseDao<TestConfig> {
	
	/**
	 * 根据userId查找指定的测试配置
	 * @param userId 0为系统默认配置
	 * @return
	 */
	TestConfig getConfigByUserId(Integer userId);


}
