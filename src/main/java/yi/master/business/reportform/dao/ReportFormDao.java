package yi.master.business.reportform.dao;

import yi.master.business.message.bean.TestReport;

import java.util.List;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/12 17:35
 */
public interface ReportFormDao {
    /**
     *  查询指定时间内，每天新增的数量
     * @author xuwangcheng
     * @date 2019/12/12 17:52
     * @param tableName tableName 表名
     * @param beginTime beginTime 开始时间
     * @param endTime endTime 结束时间
     * @return {@link List}
     */
    List<Object[]> queryCountByTime(String tableName, String beginTime, String endTime);

    List<TestReport> queryReportByTime();
}

