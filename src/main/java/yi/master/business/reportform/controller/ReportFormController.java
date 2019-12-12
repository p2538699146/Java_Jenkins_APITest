package yi.master.business.reportform.controller;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import yi.master.business.base.bean.ReturnJSONObject;
import yi.master.business.reportform.bean.index.IndexChartRenderData;
import yi.master.business.reportform.service.ReportFormService;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/12 18:01
 */
@Controller
@Scope("prototype")
public class ReportFormController extends ActionSupport {
    private static final long serialVersionUID = 1L;

    @Autowired
    private ReportFormService reportFormService;
    /**
     * LOGGER
     */
    private static final Logger LOGGER = Logger.getLogger(ReportFormController.class.getName());
    /**
     * ajax调用返回的map
     */
    private ReturnJSONObject jsonObject = new ReturnJSONObject();


    /**
     * 获取首页图表渲染数据
     * @author xuwangcheng
     * @date 2019/12/12 18:08
     * @param
     * @return {@link String}
     */
    public String getIndexChartRenderData () {
        jsonObject.setData(IndexChartRenderData.getRenderData(reportFormService));
        return SUCCESS;
    }




    public ReturnJSONObject getJsonObject() {
        return jsonObject;
    }
}
