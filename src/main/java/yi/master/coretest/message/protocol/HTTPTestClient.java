package yi.master.coretest.message.protocol;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.http.*;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.impl.conn.PoolingClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.log4j.Logger;

import org.springframework.http.HttpMethod;
import yi.master.business.testconfig.bean.TestConfig;
import yi.master.constant.MessageKeys;
import yi.master.coretest.message.parse.URLMessageParse;
import yi.master.coretest.message.protocol.entity.ClientTestResponseObject;
import yi.master.coretest.message.protocol.entity.HttpDeleteWithBody;
import yi.master.util.PracticalUtils;

/**
 * 接口自动化<br>
 * Http协议接口测试客户端
 * @author xuwangcheng
 * @version 1.0.0.2,20180530
 *
 */
public class HTTPTestClient extends TestClient {
	private static HTTPTestClient httpTestClient;

	private static final Logger LOGGER = Logger.getLogger(HTTPTestClient.class);
	
	private static final Object lock = new Object();
	
	private static final String ENC_CHARSET = "utf-8";
	
	private static final String REC_ENC_CHARSET = "utf-8";
	
	private static final int MAX_TOTAL_CONNECTION_COUNT = 1000;
	
	private static final int DEFAULT_MAX_PER_ROUTE_CONNECTION_COUNT = 500;
	
	private static final String DEFAULT_HTTP_METHOD = HttpMethod.POST.name();
	
	/**可同时存在的最大httpclient数量*/
	private static final int MAX_DEFAULT_HTTP_CLIENT_COUNT = 100;
	/**活跃客户端池*/
	private static final List<DefaultHttpClient> activeClientPool = new ArrayList<DefaultHttpClient>();
	/**可用客户端池*/
	private static final List<DefaultHttpClient> availableClientPool = new ArrayList<DefaultHttpClient>();
	
	private static final DefaultHttpClient defaultClient = getHttpClient();

	private HTTPTestClient () {}

	public static HTTPTestClient getInstance () {
		if (httpTestClient == null) {
			httpTestClient = new HTTPTestClient();
		}

		return httpTestClient;
	}

	/**
	 * 从HttpClient池中获取可以的客户端
	 * @return
	 */
	private static DefaultHttpClient getHttpClient () {		
		synchronized(lock) {
			//可用客户端不足
			if (availableClientPool.size() < 1) {
				if (activeClientPool.size() >= MAX_DEFAULT_HTTP_CLIENT_COUNT) {
					//等待释放
					while (availableClientPool.size() < 1) {
						try {
							lock.wait(800);
						} catch (InterruptedException e) {
							LOGGER.warn("InterruptedException", e);
						}
					}
				} else {
					//新建客户端
					DefaultHttpClient newClient = getNewHttpClient();
					activeClientPool.add(newClient);
					return newClient;
				}
			}
			DefaultHttpClient client = availableClientPool.get(0);
			client.getCookieStore().clear();
			availableClientPool.remove(client);
			return client;
		}		
	}
	
	private static DefaultHttpClient getNewHttpClient () {
		HttpParams params = new BasicHttpParams();  
        //设置基本参数  
        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);  
        HttpProtocolParams.setContentCharset(params, ENC_CHARSET);  
        HttpProtocolParams.setUserAgent(params, "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.89 Safari/537.36");

        HttpProtocolParams.setUseExpectContinue(params, true);  
        
        params.setLongParameter(ClientPNames.CONN_MANAGER_TIMEOUT, 8000);
        //在提交请求之前 测试连接是否可用
        params.setBooleanParameter(CoreConnectionPNames.STALE_CONNECTION_CHECK, true);
        params.setParameter(ClientPNames.COOKIE_POLICY, CookiePolicy.BROWSER_COMPATIBILITY);

        //使用线程安全的连接管理来创建HttpClient  
        PoolingClientConnectionManager conMgr = new PoolingClientConnectionManager();
		//客户端总并行连接最大数
        conMgr.setMaxTotal(MAX_TOTAL_CONNECTION_COUNT);
		//单个主机的最大并行连接数
        conMgr.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE_CONNECTION_COUNT);
       
        DefaultHttpClient httpClient = new DefaultHttpClient(conMgr, params);
        httpClient.setHttpRequestRetryHandler(new DefaultHttpRequestRetryHandler(0, false));

        //设置ssl https
        X509TrustManager xtm = new X509TrustManager() {
        	@Override
            public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {}
			@Override
            public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {}
			@Override
            public X509Certificate[] getAcceptedIssuers() {return null;}
        };

        try {
            SSLContext ctx = SSLContext.getInstance("TLS");
            ctx.init(null, new TrustManager[] { xtm }, null);
            SSLSocketFactory socketFactory = new SSLSocketFactory(ctx);
            httpClient.getConnectionManager().getSchemeRegistry().register(new Scheme("https", 443, socketFactory));
        } catch (Exception e) {
            LOGGER.error("创建ssl连接失败!", e);
        }
        
        return httpClient;       
	}

	
	@Override
	public Object getTestClient() {
		return getHttpClient();
	}

	@SuppressWarnings({ "resource", "unchecked" })
	@Override
	public ClientTestResponseObject sendRequest(String requestUrl, String requestMessage, Map<String, Object> callParameter, TestConfig config, Object httpclient) {
		DefaultHttpClient client = null;
		if (httpclient == null) {
			client = defaultClient;
		} else {
			client = (DefaultHttpClient) httpclient;
		}

		ClientTestResponseObject returnMap = new ClientTestResponseObject();
		returnMap.setStatusCode("false");
		returnMap.setMark("");
		Map<String, String> headers = null;
		Map<String, String> querys = null;
		//默认post方式
		String method = DEFAULT_HTTP_METHOD;
		String encType = ENC_CHARSET;
		String recEncType = REC_ENC_CHARSET;
		
		int connectTimeOut = config.getConnectTimeOut();
		int readTimeOut = config.getReadTimeOut();
		if (callParameter != null) {
			try {
				headers = (Map<String, String>) callParameter.get(MessageKeys.HTTP_PARAMETER_HEADER);	
				querys = (Map<String, String>) callParameter.get(MessageKeys.HTTP_PARAMETER_QUERYS);
				method = (String) callParameter.get(MessageKeys.PUBLIC_PARAMETER_METHOD);
				encType = (String) callParameter.get(MessageKeys.HTTP_PARAMETER_ENC_TYPE);
				recEncType = (String) callParameter.get(MessageKeys.HTTP_PARAMETER_REC_ENC_TYPE);
				
				if (PracticalUtils.isNumeric(callParameter.get(MessageKeys.PUBLIC_PARAMETER_CONNECT_TIMEOUT))) {
					connectTimeOut = Integer.parseInt((String) callParameter.get(MessageKeys.PUBLIC_PARAMETER_CONNECT_TIMEOUT));
				}
				
				if (PracticalUtils.isNumeric(callParameter.get(MessageKeys.PUBLIC_PARAMETER_READ_TIMEOUT))) {
					readTimeOut = Integer.parseInt((String) callParameter.get(MessageKeys.PUBLIC_PARAMETER_READ_TIMEOUT));
				}
				
			} catch (Exception e) {
				LOGGER.info("报文附加参数获取出错:" + callParameter.toString(), e);
			}
		}
		//请求超时
		client.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, connectTimeOut); 
		//读取超时
		client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, readTimeOut);
		
		HttpResponse response = null;
		long useTime = 0;
		HttpRequestBase request = null;	
    	Object[] returnInfo = null;
    	String errorMsg = "";
    	
    	//失败重试
    	boolean requestSuccessFlag = false;
    	int retryCount = 0;
    	while (!requestSuccessFlag && config.getRetryCount() > retryCount) {
    		try {			    			
    			if (HttpMethod.GET.name().equalsIgnoreCase(method)) {
    				returnInfo = doGet(requestUrl, headers, querys, requestMessage, client);
    			} else {
    				returnInfo = doPost(method, requestUrl, headers, querys, requestMessage, encType, client);
    			}
    			requestSuccessFlag = true;
    		} catch (Exception e) {
    			LOGGER.info("发送请求出错...重试次数..." + retryCount, e);
    			errorMsg = e.getMessage();   			
    		} finally {
    			retryCount++;
    		}
    	}
		
		if (!requestSuccessFlag) {
			returnMap.setMark("发送请求出错：\n" + errorMsg);
		}
    	
		if (returnInfo != null) {
			response = (HttpResponse) returnInfo[0];
			useTime = (long) returnInfo[1];
			request = (HttpRequestBase) returnInfo[2];			
		}		
		
		JSONObject headersObject = new JSONObject();
		headersObject.put("RequestHeader", new JSONObject());
		headersObject.put("ResponseHeader", new JSONObject());
		
		if (response != null) {							
			StringBuilder returnMsg = new StringBuilder();			
			//获取所有头信息
			parseHeaders(headersObject.getJSONObject("ResponseHeader"), response.getAllHeaders());
						
			try {
				InputStream is = response.getEntity().getContent();
				Scanner scan = new Scanner(is, (PracticalUtils.isNormalString(recEncType) ? recEncType : REC_ENC_CHARSET));
				while (scan.hasNext()) {
					returnMsg.append(scan.nextLine());
				}				
			} catch (Exception e) {
				LOGGER.info("解析返回出错", e);
				returnMap.setMark("解析返回内容出错：" + e.getMessage());
			}
			returnMap.setResponseMessage(returnMsg.toString());
			returnMap.setStatusCode(String.valueOf(response.getStatusLine().getStatusCode()));
		} 
		
		if (request != null) {
			parseHeaders(headersObject.getJSONObject("RequestHeader"), request.getAllHeaders());
			try {
				headersObject.put("RequestQuery", request.getURI().getQuery());
			} catch (Exception e) {
				
			}
			
			request.releaseConnection();
		}

		returnMap.setHeaders(headersObject.toString());
		returnMap.setUseTime(useTime);

		//if (client != defaultClient) availableClientPool.add(client);
		return returnMap;
	}

	@Override
	public void putBackTestClient(Object procotolClient) {
		
		if (procotolClient != null && procotolClient instanceof DefaultHttpClient) {
			availableClientPool.add((DefaultHttpClient) procotolClient);
		}
	}
	
	
	@Override
	public boolean testInterface(String requestUrl) {
		
		return false;
	}
	/**********************************************************************************************/
	/**
	 * 解析请求头或者响应头信息
	 * @param json
	 * @param headers
	 */
	private void parseHeaders(JSONObject json, Header[] headers) {
		if (headers != null) {
			for (Header h:headers) {
				if (json.get(h.getName()) != null) {
					String newValue = json.getString(h.getName());
					if (!newValue.endsWith(";")) newValue += ";";
					json.put(h.getName(), newValue + h.getValue());
				} else {
					json.put(h.getName(), h.getValue());
				}
				
			}
		}
	}
	
	/**
	 * get方式
	 * @param host
	 * @param headers
	 * @return
	 * @throws Exception
	 */
	public Object[] doGet(String host, Map<String, String> headers, Map<String, String> querys, String requestMessage, DefaultHttpClient client)
			throws Exception {	
		if (querys == null)  querys = new HashMap<String, String>();
		if (StringUtils.isNotEmpty(requestMessage) 
				&& MessageKeys.MessageType.URL.getParseUtil().messageFormatValidation(requestMessage)) {
			querys.putAll(URLMessageParse.parseUrlToMap(requestMessage, null));
		}
		
		HttpGet request = new HttpGet(buildUrl(host, querys));
		
		if (headers != null) {
			for (Map.Entry<String, String> e : headers.entrySet()) {
				request.addHeader(e.getKey(), PracticalUtils.replaceGlobalVariable(e.getValue(), null));
			}
		}
		long beginTime = System.currentTimeMillis();
		HttpResponse response = client.execute(request);
		long endTime = System.currentTimeMillis();
		
		//request.releaseConnection();

		return new Object[]{response, (endTime - beginTime), request};
	}
	
	/**
	 * post/put/delete方式
	 * @param method method
	 * @param host
	 * @param headers
	 * @param body
	 * @return
	 * @throws Exception
	 */
	private Object[] doPost(String method, String host, Map<String, String> headers, Map<String, String> querys, String body, String charSet, DefaultHttpClient client)
            throws Exception {
		HttpEntityEnclosingRequestBase request = null;

		if (HttpMethod.PUT.name().equalsIgnoreCase(method)) {
			request = new HttpPut(buildUrl(host, querys));
		} else if (HttpMethod.DELETE.name().equalsIgnoreCase(method)) {
			request = new HttpDeleteWithBody(buildUrl(host, querys));
		} else {
			//默认post
			request = new HttpPost(buildUrl(host, querys));
		}

    	if (StringUtils.isNotBlank(body)) {
        	request.setEntity(createHttpEntity(headers, body, charSet));
        }
    	
    	if (headers != null) {
    		for (Map.Entry<String, String> e : headers.entrySet()) {
            	request.addHeader(e.getKey(), PracticalUtils.replaceGlobalVariable(e.getValue(), null));
            }
    	} 
        
        long beginTime = System.currentTimeMillis();
        HttpResponse response = client.execute(request);
        long endTime = System.currentTimeMillis();
    	//request.releaseConnection();
    	
    	return new Object[]{response, (endTime - beginTime), request};
    }
	
	/**
	 * url拼接
	 * @param url 地址
	 * @param querys 查询参数即url中?后
	 * @return 完整的url
	 * @throws UnsupportedEncodingException
	 */
	private String buildUrl(String url, Map<String, String> querys) throws UnsupportedEncodingException {
    	StringBuilder sbUrl = new StringBuilder();
    	sbUrl.append(url);
    	if (null != querys) {
    		StringBuilder sbQuery = new StringBuilder();
        	for (Map.Entry<String, String> query : querys.entrySet()) {
        		if (0 < sbQuery.length()) {
        			sbQuery.append("&");
        		}
        		if (StringUtils.isBlank(query.getKey()) && !StringUtils.isBlank(query.getValue())) {
        			sbQuery.append(query.getValue());
                }
        		if (!StringUtils.isBlank(query.getKey())) {
        			sbQuery.append(query.getKey());
        			if (!StringUtils.isBlank(query.getValue())) {
        				sbQuery.append("=");
        				sbQuery.append(URLEncoder.encode(PracticalUtils.replaceGlobalVariable(query.getValue(), null), ENC_CHARSET));
        			}        			
                }
        	}
        	if (0 < sbQuery.length()) {
        		sbUrl.append("?").append(sbQuery);
        	}
        }
    	//LOGGER.info("最终发送URL地址为：" + sbUrl.toString());
    	return sbUrl.toString();
    }
	
	/**
	 * 根据contentType创建不同的请求体
	 * @param headers
	 * @param body
	 * @param charSet
	 * @return
	 * @throws Exception 
	 */
	private HttpEntity createHttpEntity(Map<String, String> headers, String body, String charSet) throws Exception {
		String contentTypeKey = null;
		if (headers != null) {
			for (String key:headers.keySet()) {
				if ("Content-type".equalsIgnoreCase(key)) {
					contentTypeKey = key;
				}
			}
		}
		HttpEntity entity = new StringEntity(body, (StringUtils.isNotBlank(charSet) ? charSet : ENC_CHARSET));
		if (contentTypeKey == null || StringUtils.isBlank(headers.get(contentTypeKey))) {
			return entity;
		}
		//multipart/form-data的方式提交
		//此时body体必须为url格式
		if ("multipart/form-data".equalsIgnoreCase(headers.get(contentTypeKey))) {
			headers.remove(contentTypeKey);
			if (!MessageKeys.MessageType.URL.getParseUtil().messageFormatValidation(body)) {
				throw new Exception("Content-Type=multipart/form-data时请将报文格式设定为URL格式!");
			}
			Map<String, String> bodyMap = URLMessageParse.parseUrlToMap(body, new String[]{});
			MultipartEntity requestEntity = new MultipartEntity();

			for (String key:bodyMap.keySet()) {
				requestEntity.addPart(key, new StringBody(bodyMap.get(key)));
			}
					
			return requestEntity;
		}

		//multipart/form-data的方式提交
		//此时body体必须为url格式
		if ("application/x-www-form-urlencoded".equalsIgnoreCase(headers.get(contentTypeKey))) {
			headers.remove(contentTypeKey);
			if (!MessageKeys.MessageType.URL.getParseUtil().messageFormatValidation(body)) {
				throw new Exception("Content-Type=application/x-www-form-urlencoded时请将报文格式设定为URL格式!");
			}
			Map<String, String> bodyMap = URLMessageParse.parseUrlToMap(body, new String[]{});
			List<NameValuePair> list = new ArrayList<>();
			for (String key:bodyMap.keySet()) {
				list.add(new BasicNameValuePair(key, bodyMap.get(key)));
			}

			UrlEncodedFormEntity requestEntity = new UrlEncodedFormEntity(list, StringUtils.isNotBlank(charSet) ? charSet : ENC_CHARSET);

			return requestEntity;
		}

		return entity;
	}	
}
