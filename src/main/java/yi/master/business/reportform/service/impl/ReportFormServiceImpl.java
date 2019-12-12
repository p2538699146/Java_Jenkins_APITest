package yi.master.business.reportform.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yi.master.business.reportform.dao.ReportFormDao;
import yi.master.business.reportform.service.ReportFormService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/12 17:41
 */
@Service("reportFormService")
public class ReportFormServiceImpl implements ReportFormService {

    @Autowired
    private ReportFormDao reportFormDao;

    @Override
    public Map<String, Integer> queryCountByTime(String tableName, String beginTime, String endTime) {
        List<Object[]> os = reportFormDao.queryCountByTime(tableName, beginTime, endTime);
        Map<String, Integer> map = new HashMap<>();
        for (Object[] o:os) {
            map.put(o[0].toString(), Integer.valueOf(o[1].toString()));
        }

        return map;
    }
}
