package yi.master.business.base.bean;

/**
 * 通用json返回对象
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/9/4 19:06
 */
public class ReturnJSONObject {
    private String msg;
    private Integer returnCode;
    private Object data;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(Integer returnCode) {
        this.returnCode = returnCode;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
