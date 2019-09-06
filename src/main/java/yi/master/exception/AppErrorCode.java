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
    NO_LOGIN(7, "你还没有登录或者登录已失效,请重新登录"),
    NO_PERMISSION(8, "你没有权限进行此操作"),
    OP_DISABLE(4, "服务不可用"),
    OP_NOT_FOUND(5, "服务不存在"),
    NO_FILE_UPLOAD(6, "上传文件不存在"),
    NO_RESULT(3, "查询无结果"),
    MISS_PARAM(2, "缺少请求参数"),
    ILLEGAL_HANDLE(9, "禁止操作"),
    NAME_EXIST(10, "名称重复"),
    PARAMETER_VALIDATE_FAIL(11, "参数验证失败"),
    OPERATION_FAIL(9999, "操作失败,请稍后再试"),
    API_TOKEN_VALIDATE_FAIL(9998, "token不正确"),
    MOCK_INTERFACE_DISABLED(9997, "mock接口被禁止调用"),
    MOCK_INTERFACE_NOT_EXIST(9996, "未定义的mock接口"),
    MOCK_ERROR(9995, "接口mock出错,请联系接口自动化测试平台"),


    //自动化测试
    AUTO_TEST_COMPLEX_SCENE_LACK_BUSINESS_SYSTEM(100001, "测试场景没有配置独立的环境,请打开组合场景中的配置管理添加"),
    AUTO_TEST_NO_SCENE(100002, "无可测试的场景"),


    //用户相关
    USER_RE_LOGIN(200001, "你已登陆此账号"),
    USER_ACCOUNT_LOCK(200002, "该账号已被锁定,请联系管理员"),
    USER_VERIFY_CODE_ERROR(200003, "验证码不正确"),
    USER_ERROR_ACCOUNT(200004, "账号或者密码不正确"),
    USER_PASSWORD_VALIDATE_ERROR(200005, "密码验证不正确"),

    //站内信
    MAIL_MISS_RECEIVER(300001, "需要选定一个收件用户才能发送"),

    //查询数据源
    DB_CONNECT_FAIL(310001, "尝试连接数据库失败,请检查配置"),


    //接口相关
    INTERFACE_ILLEGAL_TYPE(320001, "格式不正确"),

    //报文相关
    MESSAGE_VALIDATE_ERROR(330001, "入参验证失败"),



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
