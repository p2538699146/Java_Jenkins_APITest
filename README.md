# 易大师接口自动化测试平台
QQ群交流：576431024，加群验证：易大师

#### 项目介绍 
专注于接口自动化测试的管理平台，MasterYi  Interface Automated Test Platform。 
<br>
码云地址：https://gitee.com/xuwangcheng/masteryi-automated-testing  
更新日志： https://gitee.com/xuwangcheng/masteryi-automated-testing/wikis/pages?title=%E6%9B%B4%E6%96%B0%E8%AF%B4%E6%98%8E&parent=  
使用说明： https://gitee.com/xuwangcheng/masteryi-automated-testing/wikis/  
演示地址： http://www.xuwangcheng.com/yi （admin/q708162543）   


##### 主要功能  

- 接口、报文、场景三层分离，接口测试更加灵活多变；
- 支持Http/Https/Socket/WebService协议接口，后续支持更多；
- 支持Xml/Json/自定义格式报文；
- 单场景调试、测试集批量测试、定时任务测试等；
- 多样数据验证方式；
- 使用数据池统一管理测试数据；
- 高级拓展测试：接口探测、性能测试、批量比对测试、服务调用地图等；
- 报表分析，多图表展示；
- ...

问题：    
1. 开发能力有限，代码很渣；  
2. 功能尚未完善；  
3. 安全性未知;  
4. 缺少配套的项目管理模块；  
5. 有bug，很多;
6. ...


##### 部署安装
###### 环境要求
- JDK >= 1.7  
- Mysql = 5.6
- Maven >= 3.3

###### 安装步骤
1. 使用git clone克隆项目到本地;  
2. 导入到eclipse或者idea为maven项目;  
3. 导入项目根目录下的sql脚本到mysql数据库，修改配置文件db_druid.properties中的数据库链接信息;  
4. 使用tomcat启动项目，访问http://localhot:8080/yi, 登录账号 admin/q708162543.



