package yi.master.business.reportform.bean.index;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import org.apache.struts2.json.annotations.JSON;
import yi.master.business.reportform.service.ReportFormService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 首页图表的渲染数据对象
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/12 11:45
 */
public class IndexChartRenderData {
    /**
     * 散点图数据
     */
    private Map<Integer, List<List<Object>>> overview;
    /**
     * 折线图数据
     */
    private StatData stat = new StatData();

    private IndexChartRenderData () {}

    public static IndexChartRenderData getRenderData(ReportFormService reportFormService) {
        IndexChartRenderData renderData = new IndexChartRenderData();
        String beginDate = DateUtil.formatDate(DateUtil.offsetDay(new Date(), -30)) + " 00:00:00";
        String endDate = DateUtil.formatDate(new Date()) + " 23:59:59";

        Map<String, Integer> interfaceMap = reportFormService.queryCountByTime("at_interface_info", beginDate, endDate);
        Map<String, Integer> msgMap = reportFormService.queryCountByTime("at_message", beginDate, endDate);
        Map<String, Integer> sceneMap = reportFormService.queryCountByTime("at_message_scene", beginDate, endDate);
        Map<String, Integer> reportMap = reportFormService.queryCountByTime("at_test_report", beginDate, endDate);

        List<String> time = new ArrayList<>();
        List<Integer> interfaceCountList = new ArrayList<>();
        List<Integer> msgCountList = new ArrayList<>();
        List<Integer> sceneCountList = new ArrayList<>();
        List<Integer> reportCountList = new ArrayList<>();

        time.addAll(interfaceMap.keySet());
        time.addAll(msgMap.keySet());
        time.addAll(sceneMap.keySet());
        time.addAll(reportMap.keySet());

        time = CollUtil.sortByPinyin(CollUtil.distinct(time));

        for (String t:time) {
            interfaceCountList.add(getCount(interfaceMap, t));
            msgCountList.add(getCount(msgMap, t));
            sceneCountList.add(getCount(sceneMap, t));
            reportCountList.add(getCount(reportMap, t));
        }

        renderData.getStat().setTime(time);
        renderData.getStat().getData().add(interfaceCountList);
        renderData.getStat().getData().add(msgCountList);
        renderData.getStat().getData().add(sceneCountList);
        renderData.getStat().getData().add(reportCountList);


        return renderData;
    }

    @JSON(serialize = false)
    private static Integer getCount (Map<String, Integer> m, String time) {
        if (m.get(time) != null) {
            return m.get(time);
        } else {
            return 0;
        }
    }

    public void setOverview(Map<Integer, List<List<Object>>> overview) {
        this.overview = overview;
    }

    public void setStat(StatData stat) {
        this.stat = stat;
    }

    public Map<Integer, List<List<Object>>> getOverview() {
        return overview;
    }

    public StatData getStat() {
        return stat;
    }

    public class StatData {
        private List<List<Integer>> data = new ArrayList<>();
        private List<String> time;

        public void setData(List<List<Integer>> data) {
            this.data = data;
        }

        public void setTime(List<String> time) {
            this.time = time;
        }

        public List<List<Integer>> getData() {
            return data;
        }

        public List<String> getTime() {
            return time;
        }
    }
}
