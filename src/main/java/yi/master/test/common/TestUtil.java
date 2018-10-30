package yi.master.test.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;
import org.junit.Test;

import yi.master.business.advanced.bean.config.mock.MockGenerateRuleConfig;
import yi.master.business.advanced.bean.config.mock.MockRequestValidateConfig;
import yi.master.business.advanced.bean.config.mock.MockResponseConfig;
import yi.master.business.advanced.bean.config.mock.MockValidateRuleConfig;
import yi.master.business.message.bean.ComplexParameter;
import yi.master.business.message.bean.ComplexSceneConfig;
import yi.master.business.message.bean.Parameter;
import yi.master.business.message.bean.TestResult;
import yi.master.business.testconfig.bean.TestConfig;
import yi.master.coretest.message.parse.MessageParse;
import yi.master.coretest.message.protocol.TestClient;
import yi.master.util.FrameworkUtil;
import yi.master.util.PracticalUtils;
import yi.master.util.message.JsonUtil;
import yi.master.util.message.JsonUtil.TypeEnum;
import yi.master.util.message.XmlUtil;
import yi.master.util.notify.NotifyMail;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import nl.flotsam.xeger.Xeger;

/**
 * Test相关
 * @author xuwangcheng
 * @version 1.0.0.0,2017.2.14
 */

public class TestUtil {
	
	@SuppressWarnings("unused")
	@Test
	public void testJsonUtil() throws Exception{
		
		Parameter p1 = new Parameter("ROOT", "", "", "", "Map");
		p1.setParameterId(1);
		
		Parameter p2 = new Parameter("ReturnCode", "", "0000", "", "String");
		p2.setParameterId(2);
		
		Parameter p3 = new Parameter("msg", "", "ok", "", "String");
		p3.setParameterId(3);
		
		Parameter p4 = new Parameter("data", "", "", "", "Array");
		p4.setParameterId(4);
		
		Parameter p5 = new Parameter("userid", "", "11", "", "Number");
		p5.setParameterId(5);
		
		Parameter p6 = new Parameter("username", "", "aa", "", "String");
		p5.setParameterId(6);
		
		Parameter p7 = new Parameter("", "", "", "", "array_map");
		p7.setParameterId(7);
		
		Parameter p8 = new Parameter("", "", "", "", "array_array");
		p8.setParameterId(8);
		
		Parameter p9 = new Parameter("user", "", "", "", "Map");
		p9.setParameterId(9);
		
		Parameter p10 = new Parameter("", "", "", "", "Object");
		p10.setParameterId(10);
		
		ComplexParameter complexParam10 = new ComplexParameter(10, p10, new HashSet<ComplexParameter>(), null);
		
		ComplexParameter complexParam1 = new ComplexParameter(1, p1, new HashSet<ComplexParameter>(), complexParam10);		
						
		ComplexParameter complexParam2 = new ComplexParameter(2, p2, new HashSet<ComplexParameter>(), complexParam1);
		
		ComplexParameter complexParam3 = new ComplexParameter(3, p3, new HashSet<ComplexParameter>(), complexParam1);
		
		ComplexParameter complexParam4 = new ComplexParameter(4, p4, new HashSet<ComplexParameter>(), complexParam1);
		
		ComplexParameter complexParam7 = new ComplexParameter(7, p7, new HashSet<ComplexParameter>(), complexParam4);
		
		ComplexParameter complexParam5 = new ComplexParameter(5, p5, new HashSet<ComplexParameter>(), complexParam7);
		
		ComplexParameter complexParam6 = new ComplexParameter(6, p6, new HashSet<ComplexParameter>(), complexParam7);	
		
		ComplexParameter complexParam9 = new ComplexParameter(9, p9, new HashSet<ComplexParameter>(), complexParam4);
		
		
		
		complexParam10.addChildComplexParameter(complexParam1);
		
	/*	complexParam10.addChildComplexParameter(complexParam2);
		complexParam10.addChildComplexParameter(complexParam3);
		complexParam10.addChildComplexParameter(complexParam4);*/
		
		complexParam1.addChildComplexParameter(complexParam2);
		complexParam1.addChildComplexParameter(complexParam3);
		complexParam1.addChildComplexParameter(complexParam4);	
		
		complexParam7.addChildComplexParameter(complexParam5);
		complexParam7.addChildComplexParameter(complexParam6);
		
		complexParam4.addChildComplexParameter(complexParam7);
		complexParam4.addChildComplexParameter(complexParam7);
		
		/*complexParam9.addChildComplexParameter(complexParam5);
		complexParam9.addChildComplexParameter(complexParam6);*/
		
		System.out.println(MessageParse.getParseInstance("json").depacketizeMessageToString(complexParam10, null));
		System.out.println(MessageParse.getParseInstance("xml").depacketizeMessageToString(complexParam10, null));
		System.out.println(MessageParse.getParseInstance("url").depacketizeMessageToString(complexParam10, null));
	}
	
	@Test
	public void someTest() throws Exception {
		String xmlStr = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><ROOT>		<data>			<username mode=\"2\">aa</username>		</data>		<data>			<username>aa</username>		</data>	 <ReturnCodeXXX type=\"int\" quis=\"wwss\">12345</ReturnCodeXXX></ROOT>";
		//String jsonStr = "{\"ROOT\":{\"data\":[{\"username\":\"aa\"},{\"username\":\"aa\"}],\"ReturnCodeXXX\":[\"0000\",\"1111\"]}}";
		//System.out.println(XmlUtil.getObjectByXml(xmlStr, "ROOT.ReturnCodeXXX", TypeEnum.string));
		System.out.println(XmlUtil.getXmlList(xmlStr, 5));
		
	}
	
	@Test
	public void myHttpTest() throws Exception {
		String host = "http://www.xuwangcheng.cn/AutoTest/mock/NewTest";
		String body = "{\"id\": 1}";
		String callParameter = "{\"header\":{\"Content-type\":\"application/json;charset=UTF-8\"},\"method\":\"post\"}";
		TestConfig config = new TestConfig();
		config.setConnectTimeOut(6000);
		config.setReadTimeOut(6000);
		
		Map<String, Object> callParameterMap = PracticalUtils.jsonToMap(callParameter);
		
		TestClient client = TestClient.getTestClientInstance("http");
		Map<String, String> map = client.sendRequest(host, body, callParameterMap, config, client.getTestClient());
		client.closeConnection();
		System.out.println(map.toString());
		Map<String, String> map1 = client.sendRequest(host, body, callParameterMap, config, client.getTestClient());
		System.out.println(map1.toString());
		client.closeConnection();
		
		host = "https://www.xuwangcheng.cn/dcits";
		body = "";
		callParameter = "{\"method\":\"get\"}";
		
		Map<String, String> map2 = client.sendRequest(host, body, callParameterMap, config, client.getTestClient());
		System.out.println(map2.toString());
		client.closeConnection();
		
		Map<String, String> map3 = client.sendRequest(host, body, callParameterMap, config, client.getTestClient());
		System.out.println(map3.toString());
		client.closeConnection();
	}
	
	@Test
	public void Test2 () {
		String[] ab = "cc,aa,dd,bb,ff,ee".split(",");
		
		Arrays.sort(ab);
		StringBuilder str = new StringBuilder();
		
		for (int i = 0;i < ab.length;i++) {
			str.append(ab[i]);
			
			if (i <  ab.length - 1) {
				str.append(",");
			}
		}
		
		System.out.println(str.toString());
	}
	
	@Test
	public void test3 () {
		String ab = "sa#da#dsad#asda#dsaww";
		String s = "#(.*?)#";
		Pattern pattern = Pattern.compile(s);
		Matcher matcher = pattern.matcher(ab);
		
		while (matcher.find()) {
			System.out.println(matcher.group());
			System.out.println(matcher.group(1));
		}
	}
	
	@Test
	public void test4() throws IOException {
		System.out.println(new File("").getCanonicalPath());
		/*System.out.println(String.format("%.2f", Double.valueOf(String.valueOf(((double)39 / 128 * 100)))));*/
	}	
	
	@Test
	public void test5() throws JsonParseException, JsonMappingException, IOException  {
		String jsonStr = "{\"ROOT\":{\"OP_CODE\":\"4303\",\"CUST_ID_TYPE\":\"2\",\"BATCH_TYPE\":1,\"CREATE_ACCEPT\":60006860745805,\"BIZ_ORIGIN\":1,\"BUSI_TYPE_ID\":\"2\",\"SUB_ORDER_NAME\":\"??????\",\"ORDER_STATUS\":13,\"OL_NUM\":1,\"FINISH_TIME\":\"20170520\",\"CONTACT_ID\":\"1117051700000001367931846\",\"CONTACT_PHONE\":\"000\",\"STATUS\":\"N\",\"BUSI_LIST\":[{\"CUST_ID_TYPE\":\"2\",\"CREATE_ACCEPT\":30000001033051,\"ACTION_ID\":1147,\"ORDER_LINE_ID\":\"L17051700000031\",\"CUST_ID_VALUE\":\"22080980732617\"}],\"BIZPACK_ID\":\"CP17051700000029\",\"CHANNEL_TYPE\":\"21J\",\"CUST_ID\":22080980732615,\"EXTEND_INFO3\":\"1001\",\"CONTACT_PERSON\":\"000\",\"GROUP_ID\":\"122000464\",\"OPR_INFO\":{\"OP_CODE\":\"4622\",\"CUST_ID_TYPE\":2,\"TRACE_ID\":\"11*20170517164631*4622*M0AAA0002*994563\",\"CUST_REGION_ID\":22,\"LOGIN_PWD\":\"fb0bdec823cf4cdb\",\"SER_NAME\":\"0\",\"CONTACT_ID\":\"1117051700000001367931846\",\"APP_ID\":\"\",\"BAK1\":\"\",\"CNTT_LOGIN_ACCEPT\":\"30000001033050\",\"CNTT_OP_TIME\":\"20170518004849\",\"BAK2\":\"\",\"CHANNEL_TYPE\":\"21J\",\"BAK3\":\"\",\"CUST_ID\":22080980732615,\"SRC_PORT\":\"\",\"FROM_SYS\":\"CRM\",\"MASTER_SERV_ID\":\"1001\",\"DEST_IP\":\"\",\"ID_ICCID\":\"\",\"IP_ADDRESS\":\"10.152.30.77\",\"TYPE_CODE\":\"1\",\"OCR_LOGIN_ACCEPT\":30000001033050,\"APP_NAME\":\"\",\"GROUP_ID\":\"122000464\",\"BRAND_ID\":\"003\",\"SERVICE_NO\":\"13515507525\",\"ROUND_AUDIT\":\"\",\"SUB_ORDER_ID\":\"S17051700000029\",\"OP_NOTE\":\"?\",\"PROVINCE_GROUP\":\"10017\",\"DEST_PORT\":\"\",\"CUST_ID_VALUE\":22080980732617,\"AUTHEN_CODE\":\"\",\"REGION_ID\":\"22\",\"PARTITION_CODE\":20,\"REGION_NAME\":\"??\",\"PRODPRC_NAME\":\"\",\"OP_TIME\":\"20170517164501\",\"ID_NO\":22310003678466,\"MSG_STENCIL\":\"\",\"ORDER_ID\":\"O17051700000016\",\"AUTHEN_NAME\":\"????\",\"SYS_NOTE\":\"???\",\"SESSION_ID\":\"\",\"LOGIN_NO\":\"M0AAA0002\",\"BILL_ID\":\"K17051700000060\",\"CONTRACT_NO\":0},\"BRAND_ID\":\"003\",\"SERVICE_NO\":\"15255041973\",\"SUB_ORDER_ID\":\"S17050800000047\",\"OP_NOTE\":\"?\",\"PROVINCE_GROUP\":\"10017\",\"HANDLE_TIME\":\"201705\",\"EXTEND_INFO0\":\"N\",\"CUST_ID_VALUE\":\"22080980732617\",\"OL_FINISH_NUM\":0,\"REGION_ID\":\"22\",\"ORDER_TYPE_ID\":1,\"INSRC_KEY\":\"K17051700000060\",\"OP_TIME\":\"20170517170507\",\"ORDER_ID\":\"S17050800000047\",\"OLD_ORDER_ID\":\"S17051700000029\",\"CONFIRM_STATUS\":\"N\",\"ID_NO\":22310003678466,\"IS_AUTO_CONFIRM\":\"N\",\"OL_REMOVE_NUM\":1,\"LOGIN_NO\":\"Y18610590\"},\"COMMON_INFO\":{\"TRACE_ID\":\"11*20170517164631*4622*M0AAA0002*994563\",\"CALL_ID\":\"S17051700000029_null\"},\"HEADER\":{\"REGION_ID\":\"22\",\"ROUTING\":{\"ROUTE_KEY\":\"SSEESS\",\"ROUTE_VALUE\":\"\"},\"DB_ID\":\"\",\"TRACE_ID\":\"11*20170517164631*4622*M0AAA0002*994563\",\"CHANNEL_ID\":\"40\",\"POOL_ID\":\"11\"}}";
		
		//Map maps = new ObjectMapper().readValue(jsonStr, Map.class);
		//System.out.println(maps.toString());
		System.out.println(JsonUtil.getObjectByJson(jsonStr, "HEADER.ROUTING.ROUTE_KEY", TypeEnum.map));
	}
	
	@Test
	public void test6() {
		String str = "http://localhost:8080/esw/service/${interfaceName}";
		System.out.println(str.replaceAll("\\$\\{interfaceName\\}", "getUserId"));
	}
	
	@Test
	public void test7 () throws UnsupportedEncodingException {
		StringBuilder str = new StringBuilder();
		str.append("我爱你");
		
		System.out.println(new String(str.toString().getBytes("UTF-8"), "GBK"));
	}
	
	@Test
	public void test8 () {
		/*Map<String, ComplexSceneConfig> configs = new HashMap<String, ComplexSceneConfig>();
		configs.put("1", new ComplexSceneConfig(1, new HashMap<String, String>(), new HashMap<String, String>(), 3, 3000, "0"));
		configs.put("2", new ComplexSceneConfig(2, new HashMap<String, String>(), new HashMap<String, String>(), 3, 3000, "0"));
		configs.put("3", new ComplexSceneConfig(3, new HashMap<String, String>(), new HashMap<String, String>(), 3, 3000, "0"));

		JSONObject jsonStu = JSONObject.fromObject(configs);
		System.out.println(jsonStu.toString());*/
		String json = "{\"3\":{\"errorExecFlag\":\"0\",\"intervalTime\":3000,\"messageSceneId\":3,\"retryCount\":3,\"saveVariables\":{},\"useVariables\":{}},\"2\":{\"errorExecFlag\":\"0\",\"intervalTime\":3000,\"messageSceneId\":2,\"retryCount\":3,\"saveVariables\":{},\"useVariables\":{}},\"1\":{\"errorExecFlag\":\"0\",\"intervalTime\":3000,\"messageSceneId\":1,\"retryCount\":3,\"saveVariables\":{},\"useVariables\":{}}}";
		JSONObject obj = new JSONObject().fromObject(json);
		Map<String, ComplexSceneConfig>	configs = new HashMap<String, ComplexSceneConfig>();
		Map<String, Class> classMap = new HashMap<String, Class>();
		classMap.put("useVariables", Map.class);
		classMap.put("saveVariables", Map.class);
		Map<String, Object> objs = (Map<String, Object>) obj.toBean(obj, Map.class,classMap);
		
		for (String key:objs.keySet()) {
			JSONObject o = obj.getJSONObject(key);
			configs.put(key, (ComplexSceneConfig) o.getJSONObject(key).toBean(o, ComplexSceneConfig.class, classMap));
		}
		
		System.out.println(configs.toString());
		
	}
	
	@Test
	public void test9 () {
		String json = "{\"delSystems\":[11,13],\"addSystems\":[]}";
		JSONObject obj = JSONObject.fromObject(json);
		Collection<String> delSystems = JSONArray.toCollection(obj.getJSONArray("delSystems"), String.class);
		Collection<String> addSystems = JSONArray.toCollection(obj.getJSONArray("addSystems"), String.class);
		
		System.out.println(StringUtils.join(addSystems, ","));
		System.out.println(StringUtils.join(delSystems, ","));
	}
	
	@Test
	public void test10() {	
		String xml = "xmlhead=<?xml version='1.0' encoding='UTF-8'?><InterBOSS>	<Version>0100</Version>	<TestFlag>0</TestFlag>	<BIPType>		<BIPCode>BIP3B505</BIPCode>		<ActivityCode>T3000505</ActivityCode>		<ActionCode>0</ActionCode>	</BIPType>	<RoutingInfo>		<OrigDomain>CTRM</OrigDomain>		<RouteType>00</RouteType>		<Routing>			<HomeDomain>BOSS</HomeDomain>			<RouteValue>351</RouteValue>		</Routing>	</RoutingInfo>	<TransInfo>		<SessionID>280_20180514110001892_6CaJ</SessionID>		<TransIDO>280_20180514110001892_6CaJ</TransIDO>		<TransIDOTime>20180514110001</TransIDOTime>	</TransInfo>	<SNReserve>		<TransIDC>99808080-ctrm2-hq3q120180514110003795351695</TransIDC>		<ConvID>383115da-fc4f-4361-8287-684eca885f09</ConvID>		<CutOffDay>20180514</CutOffDay>		<OSNTime>20180514110003</OSNTime>		<OSNDUNS>9980</OSNDUNS>		<HSNDUNS>3510</HSNDUNS>		<MsgSender>0046</MsgSender>		<MsgReceiver>3511</MsgReceiver>		<Priority>3</Priority>		<ServiceLevel>1</ServiceLevel>	</SNReserve></InterBOSS>&xmlbody=<?xml version='1.0' encoding='UTF-8'?><InterBOSS>	<SvcCont>	<![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?><BizReq><OprNumb>280_20180514110001892_6CaJ</OprNumb><ChannelID>280</ChannelID><NumType>1</NumType><MobileNo>18703561903</MobileNo><CheckType>3</CheckType><GoodsID>999090010000001</GoodsID><ProductList><ProductType>09001</ProductType><ProductID>999090010000001</ProductID></ProductList></BizReq>]]></SvcCont></InterBOSS>";
		String[] ss = xml.split("&");	
		for (String s:ss) {
			String[] st = StringUtils.split(s, "=", 2);
			for (String sp:st) {
				System.out.println("++" + sp);
			}
			System.out.println();
		}
	}
	
	@Test
	public void test11() {		
		MockRequestValidateConfig validateConfig = new MockRequestValidateConfig();
		validateConfig.setMessageType("url");
		validateConfig.setMethod("get");
		
		validateConfig.getHeaders().add(new MockValidateRuleConfig("Content-Type", "", "string", "equal", "application/json", true, "", "", "", ""));
		validateConfig.getQuerys().add(new MockValidateRuleConfig("txt", "", "string", "equal", "1.2332", true, "", "", "", ""));
		validateConfig.getQuerys().add(new MockValidateRuleConfig("version", "", "string", "none", "", true, "", "", "3", "2"));
		validateConfig.getParameters().add(new MockValidateRuleConfig("name", "", "string", "contain", "xu", true, "5", "20", "", ""));
		validateConfig.getParameters().add(new MockValidateRuleConfig("age", "", "number", "none", "", true, "", "", "100", "10"));
		
		System.out.println(JSONObject.fromObject(validateConfig).toString());
		
	}
	
	@Test
	public void test12() {
		MockResponseConfig mockConfig = new MockResponseConfig();
		mockConfig.setCharset("utf-8");
		mockConfig.setSleepTime(300L);
		mockConfig.setMessageType("json");
		mockConfig.setExampleResponseMsg("{\"note\":{\"to\":\"George\",\"from\":\"John\",\"heading\":\"Reminder\",\"body\":\"Don't forget the meeting!\"}}");
		
		mockConfig.getHeaders().add(new MockGenerateRuleConfig("Content-Type", "", "constant", "application/json"));
		mockConfig.getHeaders().add(new MockGenerateRuleConfig("token", "", "variable", "${__adss}"));
		mockConfig.getHeaders().add(new MockGenerateRuleConfig("regx", "", "regular", "[ab]{4,6}c"));
		
		mockConfig.getParameters().add(new MockGenerateRuleConfig("to", "TopRoot.note", "regular", "[ab]{4,6}c"));
		mockConfig.getParameters().add(new MockGenerateRuleConfig("heading", "TopRoot.note", "variable", "${__current_timestamp}"));
		mockConfig.getParameters().add(new MockGenerateRuleConfig("body", "TopRoot.note", "constant", "你好，我是傻逼"));
		
		System.out.println(JSONObject.fromObject(mockConfig).toString());
	}
	
	@Test
	public void test13() {
		String regex = "[ab]{4,6}c";
		Xeger generator = new Xeger(regex); 
		System.out.println(generator.generate());
	}
	
	@Test
	public void test14() {
		String key = "abcs.wda.wewqasa";
		String msg = "{\"name\":\"{abcs.wda.wewqasa}\"}";
		System.out.println(msg.replaceAll("\\{" + key + "\\}", "2333"));
	}
	
	@Test
	public void test15() throws SigarException {
		Sigar sigar = PracticalUtils.initSigar();
		double cpuUsedPerc = sigar.getCpuPerc().getCombined();//cpu
		System.out.println("cpuUsedPerc=" + cpuUsedPerc);
		double memUsed = sigar.getMem().getActualUsed();//mem
		System.out.println("memUsed=" + memUsed);
		double memTotal = sigar.getMem().getTotal();
		System.out.println("memTotal=" + memTotal);
		double memUsedPerc = sigar.getMem().getUsedPercent();
		System.out.println("memUsedPerc=" + memUsedPerc);
		String memUsedStr = String.format("%.2f", memUsed/1024/1024/1024)+"GB";// mem to string GB
		System.out.println("memUsedStr=" + memUsedStr);
		String memTotalStr = String.format("%.2f", memTotal/1024/1024/1024)+"GB";
		System.out.println("memTotalStr=" + memTotalStr);
		String memUsedPercStr = String.format("%.2f", memUsedPerc)+" %";
		System.out.println("memUsedPercStr=" + memUsedPercStr);
		double diskUsed = sigar.getFileSystemUsage(FrameworkUtil.getProjectPath()).getUsed();//disk
		System.out.println("diskUsed=" + diskUsed);
		double diskTotal = sigar.getFileSystemUsage(FrameworkUtil.getProjectPath()).getTotal();
		System.out.println("diskTotal=" + diskTotal);
		double diskUsedPerc = sigar.getFileSystemUsage(FrameworkUtil.getProjectPath()).getUsePercent();
		System.out.println("diskUsedPerc=" + diskUsedPerc);
		String diskUsedStr = String.format("%.2f", diskUsed/1024/1024)+"GB";//disk to String GB
		System.out.println("diskUsedStr=" + diskUsedStr);
		String diskTotalStr = String.format("%.2f", diskTotal/1024/1024)+"GB";
		System.out.println("diskTotalStr=" + diskTotalStr);
		String diskUsedPercStr = String.format("%.2f", diskUsedPerc*100)+" %";
		System.out.println("diskUsedPercStr=" + diskUsedPercStr);
		String fqdn = sigar.getFQDN();//FQDN
		System.out.println("fqdn=" + fqdn);
		
	}
	
	@Test
	public void test16() {
		String json = "{\"time\":[\"2018-07-17 17:15:05\",\"2018-07-17 17:15:13\",\"2018-07-17 17:15:21\",\"2018-07-17 17:15:29\",\"2018-07-17 17:15:37\",\"2018-07-17 17:15:45\",\"2018-07-17 17:15:53\",\"2018-07-17 17:16:01\",\"2018-07-17 17:16:09\",\"2018-07-17 17:16:17\",\"2018-07-17 17:16:25\"]}";
		JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd HH:mm:ss"}), true);		
		Map map = new HashMap();
		map.put("time", java.util.Date.class);		
		TestJSONLib t = (TestJSONLib) JSONObject.toBean(JSONObject.fromObject(json), TestJSONLib.class, map);
		System.out.println(t.getTime().get(0).getClass().getName());
		System.out.println(t.toString());
	}
	
	
	@Test
	public void test17() throws IOException {
		Person p1 = new Person(20,"张三",33.4);
        Person p2 = new Person(50,"李四",53.4);
        Person p3 = new Person(10,"王五",123.4);
        
        //存入序列化的对象
        FileOutputStream fos = new FileOutputStream("person.txt");
        ObjectOutputStream oos = new ObjectOutputStream(fos);
    
        oos.writeObject(p1);
        oos.writeObject(p2);
        oos.writeObject(p3);
    
        oos.close();
	}
	
	
	@Test
	public void test18() throws ClassNotFoundException, IOException {
		 //取出序列化的对象
        FileInputStream fn = new FileInputStream("55e1e21c14db43c39447344c395ff44b.txt");
        ObjectInputStream ois = new ObjectInputStream(fn);
    
        List<TestResult> results = (List<TestResult>) ois.readObject();
        
        for (TestResult t:results) {
        	System.out.println(t.getResponseMessage());
        }
	}
	
	@Test
	public void test19 () {
		String json = "{\"headers\":[],\"messageType\":\"\",\"method\":\"\",\"parameters\":[{\"name\":\"UIS\",\"path\":\"\\\"ssss\\\":\\\"ssss\\\"\",\"type\":\"String\",\"validateType\":\"exist\",\"validateValue\":\"234\",\"ignoreCase\":\"true\",\"minLength\":\"\",\"maxLength\":\"\",\"min\":\"\",\"max\":\"\"}],\"querys\":[]}";	
		JSONObject o = JSONObject.fromObject(json);
		System.out.println(o.getJSONArray("parameters").getJSONObject(0).get("path"));
		MockRequestValidateConfig config = MockRequestValidateConfig.getInstance(json);
		System.out.println(config.getParameters().get(0).toString());
	}	
	
	
	@Test
	public void test20() {
		Properties props = new Properties(); 
		
		props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.smtp.host", "smtp.qq.com");   // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 需要请求认证
        props.setProperty("mail.smtp.port", "25");
		
        Session session = Session.getInstance(props);
        session.setDebug(true);
        Address[] receiveAddresses = NotifyMail.createAddresses(new String[]{"xuwch_dcits@163.com"});
        Address[] copyAddresses = NotifyMail.createAddresses(new String[]{"xuwangcheng14@163.com"});
        Transport transport = null;
        try {
			transport = session.getTransport();
		
			transport.connect("610421185", "");
			
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress("610421185@qq.com", "4rfrrr化平台", "UTF-8"));		
			message.setRecipients(RecipientType.TO, receiveAddresses);
			message.setRecipients(RecipientType.CC, copyAddresses);
			
			message.setSubject("dsdsdsdsds", "UTF-8");
			
			//添加附件
			MimeBodyPart attachment = new MimeBodyPart();
			DataHandler dh2 = new DataHandler(new FileDataSource("D:\\BugReport.txt"));
			attachment.setDataHandler(dh2);
			attachment.setFileName(MimeUtility.encodeText(dh2.getName()));
			
			//邮件内容
			MimeBodyPart text = new MimeBodyPart();
			text.setContent("你好：<br>接口自动化平台在"  
					+ "完成一次定时测试任务。<br>本次共执行测试场景<span style=\"color:#0000FF;\"></span>个,"
					+ "其中测试成功<span style=\"color:green;\">" + "</span>个,"
					+ "测试失败<span style=\"color:red;\">"  + "</span>个,"
					+ "异常中断<span style=\"color:#848484;\">" + "</span>个。"
					+ "<br>详情请参考附件中的离线测试报告!(请先从邮箱中下载在本地打开查看，否则会出现样式错误!)", "text/html;charset=UTF-8");

			MimeMultipart mm = new MimeMultipart("mixed");
			mm.addBodyPart(attachment);
			mm.addBodyPart(text);
			
			message.setContent(mm);
			message.setSentDate(new Date());
			message.saveChanges();
			
			
	        transport.sendMessage(message, message.getAllRecipients());
	        transport.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}     
	}
	
	@Test
	public void test21() {
		JSONArray arr = new JSONArray();
		arr.add("1");
		arr.add("2");
		arr.add("3");
		arr.add("4");
		
		System.out.println(arr.get(0));
		System.out.println(arr.get(1));
		System.out.println(arr.get(2));
		System.out.println(arr.get(3));
	}
	
}	
