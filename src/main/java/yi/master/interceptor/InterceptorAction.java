package yi.master.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import yi.master.business.base.bean.ReturnJSONObject;
import yi.master.constant.ReturnCodeConsts;
import yi.master.exception.AppErrorCode;
import yi.master.exception.YiException;
import yi.master.util.PracticalUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 根据跳转请求action返回前台指定的returnCode和msg
 * 该action主要将一些通用的返回集合起来供全局调用
 * @author xuwangcheng
 * @version 1.0.0.0,2017.2.13
 */

@Controller
public class InterceptorAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	
	/**
	 * Logger
	 */
	private static Logger logger = Logger.getLogger(InterceptorAction.class.getName());
	
	/**
	 * ajax调用返回给前台的map
	 */
	private ReturnJSONObject jsonObject;

	
	/**
	 * 全局异常处理
	 * @return
	 */
	public String error() {
		Exception ex = (Exception)ActionContext.getContext().getValueStack().findValue("exception");
		String exDetails = PracticalUtils.getExceptionAllinformation(ex);

		logger.error("系统内部错误:\n" + exDetails);
		if (ex instanceof YiException) {
			YiException yiEx = (YiException) ex;
			jsonObject = new ReturnJSONObject(yiEx);
			return SUCCESS;
		}

		jsonObject = new ReturnJSONObject(AppErrorCode.INTERNAL_SERVER_ERROR);
		jsonObject.data(exDetails);

		return SUCCESS;
	}

	public ReturnJSONObject getJsonObject() {
		return jsonObject;
	}
}
