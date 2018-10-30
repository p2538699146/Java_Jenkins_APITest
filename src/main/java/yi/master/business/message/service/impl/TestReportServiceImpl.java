package yi.master.business.message.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yi.master.business.base.service.impl.BaseServiceImpl;
import yi.master.business.message.bean.TestReport;
import yi.master.business.message.dao.TestReportDao;
import yi.master.business.message.service.TestReportService;

@Service("testReportService")
public class TestReportServiceImpl extends BaseServiceImpl<TestReport> implements TestReportService {
	
	private TestReportDao testReportDao;
	
	@Autowired
	public void setTestReportDao(TestReportDao testReportDao) {
		super.setBaseDao(testReportDao);
		this.testReportDao = testReportDao;
	}

	@Override
	public String isFinished(Integer reportId) {
		// TODO Auto-generated method stub
		return testReportDao.isFinished(reportId);
	}

	@Override
	public TestReport findByGuid(String guid) {
		// TODO Auto-generated method stub
		return testReportDao.findByGuid(guid);
	}

	@Override
	public String getDetailsJson(Integer reportId) {
		// TODO Auto-generated method stub
		return testReportDao.getDetailsJson(reportId);
	}

}
