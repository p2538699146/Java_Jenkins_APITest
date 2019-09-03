//全局常量

//请求路径
var REQUEST_URL = {
    //登陆相关
    LOGIN: {
        LOGOUT: "user-logout",
        LOGIN: "user-toLogin",
        CREATE_VERIFY_CODE: "user-createVerifyCode",
        JUDGE_LOGIN: "user-judgeLogin",
        GET_LOGIN_USER_INFO: "user-getLoginUserInfo"
    },
    //自动化测试
    AUTO_TEST: {
        BATCH_AUTO_TEST_URL: "test-scenesTest", //批量测试   测试集或者全量
        GET_TEST_CONFIG_URL: "test-getConfig", //获取当前用户的测试配置
        UPDATE_TEST_CONFIG_URL: "test-updateConfig",
        CHECK_DATA_URL: "test-checkHasData",
        TEST_SCENE_URL: "test-sceneTest",
        TEST_COMPLEX_SCENE_URL: "test-complexSceneTest"
    },
    //接口参数
    INTERFACE_PARAMS: {
        SAVE: "param-save",
        DEL: "param-del",
        GET:"param-get",
        EDIT:"param-edit",
        LIST: "param-getParams",
        MSG_IMPORT: "param-batchImportParams",
        DEL_ALL_BY_INTERFACE_ID: "param-delInterfaceParams"
    },
    //接口
    INTERFACE: {
        DEL: "interface-del",
        GET:"interface-get",
        EDIT:"interface-edit",
        LIST: "interface-list",
        CHECK_NAME: "interface-checkName",
        IMPORT_FROM_EXCEL: "interface-importFromExcel",
        EXPORT_DOCUMENT_EXCEL: "interface-exportInterfaceDocument",
        GET_PARAMETERS_JSON_TREE: "interface-getParametersJsonTree",
        UPDATE_CHILDREN_BUSINESS_SYSTEMS: "interface-updateChildrenBusinessSystems"
    },
    //报文
    MESSAGE: {
        DEL: "message-del",
        GET:"message-get",
        EDIT:"message-edit",
        LIST: "message-list",
        FORMAT: "message-format",
        VALIDATE_JSON: "message-validateJson",
        IMPORT_FROM_EXCEL: "message-importFromExcel",
        CREATE_MESSAGE_BY_NODES: "message-createMessage"
    },
    //场景
    MESSAGE_SCENE: {
        DEL: "scene-del",
        GET:"scene-get",
        EDIT:"scene-edit",
        LIST: "scene-list",
        GET_TEST_OBJECT: "scene-getTestObject",
        LIST_NO_DATA_SCENES: "scene-listNoDataScenes",
        IMPORT_FROM_EXCEL: "scene-importFromExcel",
        UPDATE_RESPONSE_EXAMPLE: "scene-updateResponseExample",
        GET_REQUEST_MSG_JSON_TREE: "scene-getRequestMsgJsonTree",
        GET_RESPONSE_MSG_JSON_TREE: "scene-getResponseMsgJsonTree"
    },
    //测试数据
    TEST_DATA: {
        GET_SETTING_DATA: "data-getSettingData",
        IMPORT_DATA_VALUES: "data-importDatas",
        DEL: "data-del",
        GET:"data-get",
        EDIT:"data-edit",
        LIST: "data-list",
        CHECK_NAME: "data-checkName",
        CREATE_NEW_DATA_MSG: "data-createDataMsg",
        CHANGE_STATUS: "data-changeStatus",
        UPDATE_PARAMS_DATA: "data-updateParamsData"
    },
    //测试报告
    REPORT: {
        DEL: "report-del",
        GET:"report-get",
        LIST: "report-list",
        DOWNLOAD_STATIC_REPORT_HTML: "report-generateStaticReportHtml",
        GET_DETAILS: "report-getReportDetail",
        SEND_MAIL: "report-sendMail"
    },
    //测试结果
    REPORT_RESULT: {
        LIST: "result-list",
        GET: "result-get"
    },
    //测试集
    TEST_SET: {
        OP_SCENE: "set-opScene",
        LIST_MY_SETS: "set-getMySet",
        SET_SCENE_LIST: "set-listScenes",
        DEL: "set-del",
        GET:"set-get",
        EDIT:"set-edit",
        LIST: "set-list",
        CHECK_NAME: "set-checkName",
        SETTING_RUN_CONFIG: "set-settingConfig",
        GET_CATEGORY_NODES: "set-getCategoryNodes",
        MOVE_TO_FOLDER: "set-moveFolder"
    },
    //组合场景
    COMPLEX_SCENE: {
        DEL: "complexScene-del",
        GET:"complexScene-get",
        EDIT:"complexScene-edit",
        LIST: "complexScene-list",
        LIST_SET_SCENES: "complexScene-listSetScenes",
        ADD_TO_SET: "complexScene-addToSet",
        DEL_FROM_SET: "complexScene-delFromSet",
        LIST_SCENES: "complexScene-listScenes",
        UPDATE_CONFIG_INFO: "complexScene-updateConfigInfo",
        ADD_SCENE: "complexScene-addScene",
        DEL_SCENE: "complexScene-delScene",
        SORT_SCENES: "complexScene-sortScenes",
        UPDATE_SCENE_CONFIG: "complexScene-updateSceneConfig",
        LIST_SAVE_VARIABLES: "complexScene-getSaveVariables"
    },
    //验证规则
    VALIDATE: {
        GET: "validate-getValidate",
        FULL_EDIT: "validate-validateFullEdit",
        DEL: "validate-del",
        GET:"validate-get",
        EDIT:"validate-edit",
        LIST: "complexScene-getValidates",
        FULL_RULE_GET: "validate-getValidate",
        RULE_UPDATE_STATUS: "validate-updateValidateStatus"
    },
    //定时任务
    TASK: {
        CHECK_NAME: "task-checkName",
        DEL: "task-del",
        GET:"task-get",
        EDIT:"task-edit",
        LIST: "task-list",
        STOP_TASK: "task-stopRunningTask",
        ADD_RUNNABLE_TASK: "task-startRunableTask",
        START_QUARTZ: "task-startQuartz",
        STOP_QUARTZ: "task-stopQuartz",
        GET_QUARTZ_STATUS: "task-getQuartzStatus",
        UPDATE_CRON_EXPRESSION: "task-updateCronExpression"
    },
    //全局设置
    GLOBAL_SETTING: {
        EDIT: "global-edit",
        SETTING_LIST_ALL: "global-listAll",
        GET_WEB_SETTINGS: "global-getWebSettings",
        GET_STATISTICAL_QUANTITY: "global-getStatisticalQuantity"
    },
    //内部接口
    OP_INTERFACE: {
        DEL: "op-del",
        GET:"op-get",
        EDIT:"op-edit",
        LIST: "op-listOp",
        GET_NODE_TREE: "op-getNodeTree",
        LIST_ALL: "op-listAll"
    },
    //查询数据源
    QUERY_DB: {
        LINK_TEST: "db-testDB",
        DEL: "db-del",
        GET:"db-get",
        EDIT:"db-edit",
        LIST: "db-list",
        LIST_ALL: "db-listAll"
    },
    //站内信
    MAIL: {
        LIST: "mail-list",
        DEL: "mail-del",
        CHANGE_STATUS: "mail-changeStatus",
        GET_NO_READ_MAIL_NUM: "mail-getNoReadMailNum",

    },
    //角色
    ROLE: {
        DEL: "role-del",
        GET:"role-get",
        EDIT:"role-edit",
        LIST: "role-list",
        GET_NODES_INTERFACE: "role-getInterfaceNodes",
        GET_NODES_MENU: "role-getMenuNodes",
        UPDATE_POWER: "role-updateRolePower",
        UPDATE_MENU: "role-updateRoleMenu",
        LIST_ALL: "role-listAll"
    },
    //用户
    USER: {
        LIST: "user-list",
        LOCK: "user-lock",
        GET: "user-get",
        EDIT: "user-edit",
        RESET_PASSWORD: "user-resetPwd",
        VERIFY_PASSWORD: "user-verifyPasswd",
        MODIFY_PASSWORD: "user-modifyPasswd",
    },
    //全局变量
    GLOBAL_VARIABLE: {
        DEL: "variable-del",
        GET:"variable-get",
        EDIT:"variable-edit",
        LIST_ALL: "variable-listAll",
        CHECK_NAME: "variable-checkName",
        UPDATE_VALUE: "variable-updateValue",
        CREATE_VARIABLE: "variable-createVariable"
    },
    //业务系统
    BUSINESS_SYSTEM: {
        DEL: "system-del",
        GET:"system-get",
        EDIT:"system-edit",
        LIST_ALL: "system-listAll",
        LIST: "system-list",
        INTERFACE_LIST: "system-listInterface",
        OP_INTERFACE: "system-opInterface"
    },
    //探测任务
    PROBE_TASK: {
        DEL: "probe-del",
        GET:"probe-get",
        EDIT:"probe-edit",
        LIST_ALL: "probe-listAll",
        LIST: "probe-list",
        UPDATE_CONFIG: "probe-updateConfig",
        START: "probe-startTask",
        STOP: "probe-stopTask",
        GET_SINGLE_REPORT_DATA: "probe-getProbeResultReportData",
        GET_PROBE_RESULT_SYNOPSIS_VIEW_DATA: "probe-getProbeResultSynopsisViewData",
        BATCH_ADD: "probe-batchAdd"
    },
    //文件上传和下载
    FILE: {
        UPLOAD_FILE: "file-upload",
        DOWNLOAD_FILE: "file-download"
    },
    //日志记录
    LOG_RECORD: {
        DEL: "log-del",
        GET:"log-get",
        LIST: "log-list",
    },
    //接口MOCK
    INTERFACE_MOCK: {
        DEL: "mock-del",
        GET:"mock-get",
        EDIT:"mock-edit",
        LIST: "mock-list",
        CHECK_NAME: "mock-checkName",
        UPDATE_STATUS: "mock-updateStatus",
        UPDATE_SETTING: "mock-updateSetting",
        PARSE_MESSAGE_TO_CONFIG: "mock-parseMessageToConfig",
        PARSE_MESSAGE_TO_NODES: "mock-parseMessageToNodes"
    },
    //性能测试
    PERFORMANCE_TEST: {
        DEL: "ptc-del",
        GET:"ptc-get",
        EDIT:"ptc-edit",
        LIST: "ptc-list",
        TASK_LIST: "ptc-listTest",
        TASK_STOP: "ptc-stopTest",
        TASK_DEL: "ptc-delTest",
        TASK_ACTION: "ptc-actionTest",
        TASK_VIEW: "ptc-viewTest",
        TASK_INIT: "ptc-initTest"
    },
    //性能测试结果
    PERFORMANCE_RESULT: {
        DEL: "ptr-del",
        GET:"ptr-get",
        LIST: "ptr-list",
        ANALYZE: "ptr-anaylzeView",
        SUMMARIZED: "ptr-summarizedView",
        DETAILS_LIST_ALL: "ptr-detailsList"
    },
    //Web自动化脚本模块
    WEB_SCRIPT_MODULE:{
        DEL: "webModule-del",
        GET:"webModule-get",
        EDIT:"webModule-edit",
        LIST: "webModule-list",
        CHECK_NAME: "webModule-checkName"
    },
    //Web自动化脚本任务
    WEB_SCRIPT_TASK: {
        LIST:"webTask-list",
        DEL:"webTask-del"
    },
    //web元素
    WEB_ELEMENT: {
        LIST_ALL: "element-listAll",
        DEL: "element-del",
        GET:"element-get",
        EDIT:"element-edit",
        LIST: "element-list",
        MOVE: "element-move",
        COPY: "element-copy"
    },
    //web用例
    WEB_CASE: {
        LIST_ALL: "webcase-listAll",
        DEL: "webcase-del",
        GET:"webcase-get",
        EDIT:"webcase-edit",
        LIST: "webcase-list",
        CHANGE_BROWSER_TYPE: "webcase-changeBroswerType",
        UPDATE_CONFIG_JSON: "webcase-updateConfig"
    },
    //web步骤
    WEB_STEP: {
        LIST_ALL: "webstep-listAll",
        DEL: "webstep-del",
        GET:"webstep-get",
        EDIT:"webstep-edit",
        LIST: "webstep-list",
        UPDATE_CONFIG: "webstep-updateConfig"
    },
    //web测试套件
    WEB_SUITE: {
        LIST_ALL: "websuite-listAll",
        DEL: "websuite-del",
        GET:"websuite-get",
        EDIT:"websuite-edit",
        LIST: "websuite-list",
        SUITE_CHANGE_BROWSER_TYPE: "websuite-changeBroswerType",
        UPDATE_CONFIG_JSON: "websuite-updateConfig",
        LIST_CASE: "websuite-listCase",
        OP_CASE: "websuite-opCase",
        CASE_UPDATE_SETTING: "websuite-updateCaseSetting"
    },
    //web自动化设置
    WEB_CONFIG: {
        GET: "webconfig-get",
        EDIT: "webconfig-edit"
    },
    //菜单
    MENU: {
        LIST_ALL: "menu-listAll",
        DEL: "menu-del",
        GET:"menu-get",
        EDIT:"menu-edit",
        LIST: "menu-list",
        GET_USER_MENUS: "menu-getUserMenus"
    }
}