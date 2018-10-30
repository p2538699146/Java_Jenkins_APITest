package yi.master.business.advanced.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import yi.master.business.advanced.bean.InterfaceProbe;
import yi.master.business.advanced.dao.InterfaceProbeDao;
import yi.master.business.advanced.service.InterfaceProbeService;
import yi.master.business.base.service.impl.BaseServiceImpl;
import yi.master.business.message.bean.TestResult;
import yi.master.statement.vo.ProbeResultSynopsisView;

@Service("interfaceProbeService")
public class InterfaceProbeServiceImpl extends BaseServiceImpl<InterfaceProbe> implements InterfaceProbeService {
	
	private InterfaceProbeDao interfaceProbeDao;
	
	@Autowired
	public void setInterfaceProbeDao(InterfaceProbeDao interfaceProbeDao) {
		super.setBaseDao(interfaceProbeDao);
		this.interfaceProbeDao = interfaceProbeDao;
	}

	@Override
	public void updateConfig(Integer probeId, String configJson) {
		// TODO Auto-generated method stub
		interfaceProbeDao.updateConfig(probeId, configJson);
	}

	@Override
	public List<InterfaceProbe> findRunTasks() {
		// TODO Auto-generated method stub
		return interfaceProbeDao.findRunTasks();
	}

	@Override
	public TestResult getLastResult(Integer probeId, Timestamp lastRunTime) {
		// TODO Auto-generated method stub
		return interfaceProbeDao.getLastResult(probeId, lastRunTime);
	}

	@Override
	public List<TestResult> findProbeResults(Integer probeId,
			Timestamp startTime) {
		// TODO Auto-generated method stub
		return interfaceProbeDao.findProbeResults(probeId, startTime);
	}

	@Override
	public List<TestResult> listProbeResultsByTimeRange(Integer probeId,
			Timestamp startTime, Timestamp endTime) {
		// TODO Auto-generated method stub
		return interfaceProbeDao.listProbeResultsByTimeRange(probeId, startTime, endTime);
	}

	@Override
	public List<ProbeResultSynopsisView> listProbeBeforeResultInfo(int dateNum) {
		// TODO Auto-generated method stub
		return interfaceProbeDao.listProbeBeforeResultInfo(dateNum);
	}
	
}
