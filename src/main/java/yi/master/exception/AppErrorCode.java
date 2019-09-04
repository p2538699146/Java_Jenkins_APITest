package yi.master.exception;

/**
 * 错误码
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/9/4 18:20
 */
public enum AppErrorCode {

    //通用
    INTERNAL_SERVER_ERROR(500, "系统内部错误"),

    //自动化测试
    AUTO_TEST_COMPLEX_SCENE_LACK_BUSINESS_SYSTEM(100001, "测试场景没有配置独立的环境,请打开组合场景中的配置管理添加")


    //组合场景相关


    //接口相关


    ;

    private Integer code;
    private String msg;

    private AppErrorCode (int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
