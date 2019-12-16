package yi.master.business.reportform.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import yi.master.business.message.bean.TestReport;
import yi.master.business.reportform.dao.ReportFormDao;

import java.util.List;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/12 17:39
 */
@Repository("reportFormDao")
public class ReportFormDaoImpl implements ReportFormDao {
    @Autowired
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    @Override
    public List<Object[]> queryCountByTime(String tableName, String beginTime, String endTime) {
        StringBuilder hql = new StringBuilder();
        hql.append("select m.ct,count(1) from (");
        hql.append("select date_format(t.create_time, '%Y-%m-%d') as ct,t.* from ");
        hql.append(tableName);
        hql.append(" t where t.create_time >= :beginTime and t.create_time <= :endTime");
        hql.append(") m group by m.ct order by m.ct");

        return getSession().createSQLQuery(hql.toString()).setString("beginTime", beginTime)
                .setString("endTime", endTime).list();
    }

    @Override
    public List<TestReport> queryReportByTime(String beginTime, String endTime) {
        String hql = "from TestReport t where t.finishTime >= :beginTime and t.finishTime <= :endTime and finishFlag = 'Y' order by finishTime";
        return getSession().createQuery(hql).setString("beginTime", beginTime)
                .setString("endTime", endTime).list();
    }
}
