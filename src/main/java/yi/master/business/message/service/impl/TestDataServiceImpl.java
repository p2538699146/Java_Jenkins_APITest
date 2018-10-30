package yi.master.business.message.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yi.master.business.base.service.impl.BaseServiceImpl;
import yi.master.business.message.bean.TestData;
import yi.master.business.message.dao.TestDataDao;
import yi.master.business.message.service.TestDataService;

@Service("testDataService")
public class TestDataServiceImpl extends BaseServiceImpl<TestData> implements TestDataService{
	
	private TestDataDao testDataDao;
	
	@Autowired
	public void setTestDataDao(TestDataDao testDataDao) {
		super.setBaseDao(testDataDao);
		this.testDataDao = testDataDao;
	}

	@Override
	public void updateDataValue(Integer dataId, String dataName,
			String dataValue) {
		// TODO Auto-generated method stub
		testDataDao.updateDataValue(dataId, dataName, dataValue);
		
	}

	@Override
	public TestData findByDisrc(String dataDiscr, Integer messageSceneId) {
		// TODO Auto-generated method stub
		return testDataDao.findByDisrc(dataDiscr, messageSceneId);
	}

	@Override
	public List<TestData> getDatasByScene(Integer messageSceneId, int count) {
		// TODO Auto-generated method stub
		return testDataDao.getDatasByScene(messageSceneId, count);
	}

	@Override
	public void updateParamsData(Integer dataId, String paramsData) {
		// TODO Auto-generated method stub
		testDataDao.updateDataValue(dataId, "paramsData", paramsData);
	}
}
