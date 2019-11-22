package yi.master.business.advanced.service;

import java.util.List;

import yi.master.business.advanced.bean.InterfaceMock;
import yi.master.business.base.service.BaseService;

public interface InterfaceMockService extends BaseService<InterfaceMock> {
	/**
	 * 根据mockUrl查找指定的mock信息
	 * @param mockUrl
	 * @return
	 */
	InterfaceMock findByMockUrl(String mockUrl);
	
	/**
	 * 更新状态
	 * @param mockId
	 * @param status
	 */
	void updateStatus(Integer mockId, String status);
	
	/**
	 * 更新验证或者mock配置信息json串
	 * @param mockId
	 * @param settingType
	 * @param configJson
	 */
	void updateSetting(Integer mockId, String settingType, String configJson);
	
	/**
	 * 获取所有启用状态的 Mock服务
	 * @return
	 */
	List<InterfaceMock> getEnableMockServer();

    /**
     * 更新调用次数：包含成功和失败的
     * @author xuwangcheng
     * @date 2019/11/22 16:11
     * @param mockId mockId
     * @return
     */
    void updateCallCount(Integer mockId);
}
