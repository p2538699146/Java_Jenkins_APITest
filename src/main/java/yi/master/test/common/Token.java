package yi.master.test.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedMap;
import java.util.TreeMap;

public class Token {
	public static void main(String[] args) {
		SortedMap<String, String> map = new TreeMap<String, String>();
		map.put("eip_serv_id", "app.getLoginInfo");
		map.put("clientType", "android");
		String params = toParamStr(map).toString();
		params = params.substring(0, params.length() - 1);
		try {
			String token  = getMD5String(params+"&key=SD7B3L3P", "UTF-8");
			System.out.println(token);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private static StringBuilder toParamStr(Map<String, String> paramMap){
		StringBuilder sb = new StringBuilder();
		if(paramMap != null){
			for (Entry<String, String> e : paramMap.entrySet()) {
				String k = e.getKey();
				String v = e.getValue();
//				if(v != null && ! "".equals(v)){
					sb.append(k).append("=").append(v).append("&");
//				}
			}
		}
		return sb; 
	}
	
	private static String getMD5String(String plainText, String charset)
			throws UnsupportedEncodingException {
		StringBuffer buf = new StringBuffer("");
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes(charset));
			byte b[] = md.digest();
			int i;
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return buf.toString();
	}
}
