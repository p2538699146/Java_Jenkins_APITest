$(document).ready(function(){
    //获取登陆之后的相关信息
    queryLoginInfo();

    //获取权限列表
    $.get(REQUEST_URL.ROLE.GET_USER_PERMISSION_LIST, function (json) {
        if (json.returnCode == RETURN_CODE.SUCCESS) {
            top.currentUserPermissionList = json.data;
        } else {
            layer.alert('获取用户权限信息出错,请重新登陆!');
        }
    });

    //检查系统版本
    $.get(REQUEST_URL.GLOBAL_SETTING.CHECK_SYSTEM_VERSION, function(json){
        if (json.returnCode == 0) {
            if (json.data.newVersion != null && json.data.newVersion != json.data.version) {
                $("#version").html('<i class="Hui-iconfont">&#xe679;</i><a style="color:blue;" href="' + json.data.versionUpgradeUrl + '" target="_blank">有新版本可以升级</a>');
            }
        } else {
            console.error("检查系统版本失败:" + json.msg);
        }
    });
});

/**
 * 获取登陆之好的相关信息：包括用户信息，全局配置，测试统计数据等
 */
function queryLoginInfo(){
    var userInfo = {};
    var lastLoginTime = "";
    var df = $.Deferred();
    df.done(function(){
        if (!($.isEmptyObject(userInfo))) {
            //加载目录信息
            parent.loadMenuFun();
            //获取配置
            getSetting();
            //获取统计信息
            getStatisticalQuantity();
            //获取未读邮件信息
            queryMailNum();

            //填充页面基本信息
            $("#group_name").text(userInfo.role.roleGroup);
            $("#real_name").text(userInfo.realName);
            $("#last_login_time").text(lastLoginTime);
            parent.$("#role_name").text(userInfo.role.roleName);
            parent.$("#real_name").text(userInfo.realName);
            if (userInfo.role.roleName != "admin") {
                parent.$(".adminPower").css("display","none");
            }


        }
    });

    //获取登陆用户信息
    $.post(REQUEST_URL.LOGIN.GET_LOGIN_USER_INFO, {token:parent.token}, function(data) {
        if (data.returnCode == RETURN_CODE.SUCCESS) {
            userInfo = data.data.user;
            lastLoginTime = data.data.lastLoginTime;
            parent.homeUrl = data.data.homeUrl;
            parent.userId = userInfo.userId;
            df.resolve();
        } else if (data.returnCode == RETURN_CODE.NO_LOGIN) {
            var username = getCookie("username");
            var password = getCookie("password");
            if (username != null && password != null && parent.token == null) {
                $.post(REQUEST_URL.LOGIN.LOGIN,{
                    username:username,
                    password:password
                }, function(data) {
                    if (data.returnCode == RETURN_CODE.SUCCESS) {
                        userInfo = data.data.user;
                        lastLoginTime = data.data.lastLoginTime;
                        parent.homeUrl = data.data.homeUrl;
                        parent.userId = userInfo.userId;
                        df.resolve();
                    } else {
                        parent.window.location.href = parent.backUrl;
                    }
                });
            } else {
                parent.window.location.href = parent.backUrl;
            }
        }else{
            parent.window.location.href = parent.backUrl;
        }
    });
}

/**
 * 获取全局配置并设置到页面
 */
function getSetting() {
    $.get(REQUEST_URL.GLOBAL_SETTING.GET_WEB_SETTINGS, function(data) {
        if(data.returnCode == 0){
            data = data.data;
            $("#notice").html(data.notice);
            $("#copyright").html(data.copyright);
            $("#siteName").html(data.siteName);
            parent.$("#siteName").html(data.siteName);
            parent.$("#version").text("V" + data.version);
        }
    });
}

/**
 * ajax请求查询用户未读邮件数量
 */
function getMailNum(){
    $.get(REQUEST_URL.MAIL.GET_NO_READ_MAIL_NUM, function(data) {
        if (data.returnCode === RETURN_CODE.SUCCESS && data.data !== 0) {
            parent.$(".noReadMailNum").text(data.data);
        } else {
            parent.$(".noReadMailNum").text("");
        }
    });
}

/**
 * 查询未读邮件数量，默认使用webSocket，否则使用ajax轮询
 */
function queryMailNum () {
    //第一次获取
    getMailNum();

    let userId = parent.userId;
    let ws = createWebSocket('/push/mail/' + userId);

    if (ws == null) {
        setInterval(getMailNum, 90000);
        return;
    }

    ws.onmessage = function(event) {
        if (event.data !== 0) {
            parent.$(".noReadMailNum").text(event.data);
        }
    }

    parent.window.onbeforeunload = function(event) {
        ws.close();
    }
}



/**
 * 获取测试统计数据
 */
function getStatisticalQuantity() {
    $.get(REQUEST_URL.GLOBAL_SETTING.GET_STATISTICAL_QUANTITY, function(data) {
        if(data.returnCode == 0){
            $.each(data.data, function(itemName, countInfo) {
                $("td[count-type='" + itemName + "']").eq(0).text(countInfo.totalCount);
                $("td[count-type='" + itemName + "']").eq(1).text(countInfo.todayCount);
                $("td[count-type='" + itemName + "']").eq(2).text(countInfo.yesterdayCount);
                $("td[count-type='" + itemName + "']").eq(3).text(countInfo.thisWeekCount);
                $("td[count-type='" + itemName + "']").eq(4).text(countInfo.thisMonthCount);
            });
        }
    });
}