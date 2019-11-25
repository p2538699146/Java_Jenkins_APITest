package yi.master.business.advanced.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yi.master.business.advanced.bean.InterfaceMock;
import yi.master.business.advanced.dao.InterfaceMockDao;
import yi.master.business.advanced.service.InterfaceMockService;
import yi.master.business.base.service.impl.BaseServiceImpl;
import yi.master.business.message.bean.MessageScene;
import yi.master.business.message.dao.MessageSceneDao;
import yi.master.exception.AppErrorCode;
import yi.master.exception.YiException;

import java.util.List;

@Service("interfaceMockService")
public class InterfaceMockServiceImpl extends BaseServiceImpl<InterfaceMock> implements InterfaceMockService {
    private InterfaceMockDao interfaceMockDao;

    @Autowired
    private MessageSceneDao messageSceneDao;

	@Autowired
	public void setInterfaceMockDao(InterfaceMockDao interfaceMockDao) {
		super.setBaseDao(interfaceMockDao);
		this.interfaceMockDao = interfaceMockDao;
	}

	@Override
	public InterfaceMock findByMockUrl(String mockUrl) {
		
		return interfaceMockDao.findByMockUrl(mockUrl);
	}

	@Override
	public void updateStatus(Integer mockId, String status) {
		
		interfaceMockDao.updateStatus(mockId, status);
	}

	@Override
	public void updateSetting(Integer mockId, String settingType,
			String configJson) {
		
		if (StringUtils.isBlank(settingType) || StringUtils.isBlank(configJson)) {
            return;
        }
		interfaceMockDao.updateSetting(mockId, settingType, configJson);
	}

	@Override
	public List<InterfaceMock> getEnableMockServer() {
		
		return interfaceMockDao.getEnableMockServer();
	}

    @Override
    public void updateCallCount(Integer mockId) {
        interfaceMockDao.updateCallCount(mockId);
    }

    @Override
    public boolean parseSceneToMock(Integer sceneId) {
        MessageScene messageScene = messageSceneDao.get(sceneId);
        if (messageScene == null) {
            throw new YiException(AppErrorCode.MESSAGE_INFO_NOT_EXITS);
        }



        return false;
    }
}
