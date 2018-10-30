package yi.master.test.common;

import java.security.Key;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

import org.apache.axis.encoding.Base64;

public class RSA {
	/** 指定加密算法为RSA */
	private static String ALGORITHM = "RSA";

	private static String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfRTdcPIH10gT9f31rQuIInLwe"  
							+ "\r" + "7fl2dtEJ93gTmjE9c2H+kLVENWgECiJVQ5sonQNfwToMKdO0b3Olf4pgBKeLThra" + "\r"  
							+ "z/L3nYJYlbqjHC3jTjUnZc0luumpXGsox62+PuSGBlfb8zJO6hix4GV/vhyQVCpG" + "\r"  
							+ "9aYqgE7zyTRZYX9byQIDAQAB" + "\r";  
//	
//	private static String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfRTdcPIH10gT9f31rQuIInLwe"  
//            + "\r" + "7fl2dtEJ93gTmjE9c2H+kLVENWgECiJVQ5sonQNfwToMKdO0b3Olf4pgBKeLThra" + "\r"  
//            + "z/L3nYJYlbqjHC3jTjUnZc0luumpXGsox62+PuSGBlfb8zJO6hix4GV/vhyQVCpG" + "\r"  
//            + "9aYqgE7zyTRZYX9byQIDAQAB" + "\r";  
//	
	private static String PRIVATE_KEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJ9FN1w8gfXSBP1/"
			+ "\r" + "fWtC4gicvB7t+XZ20Qn3eBOaMT1zYf6QtUQ1aAQKIlVDmyidA1/BOgwp07Rvc6V/" + "\r"
			+ "imAEp4tOGtrP8vedgliVuqMcLeNONSdlzSW66alcayjHrb4+5IYGV9vzMk7qGLHg" + "\r"
			+ "ZX++HJBUKkb1piqATvPJNFlhf1vJAgMBAAECgYA736xhG0oL3EkN9yhx8zG/5RP/" + "\r"
			+ "WJzoQOByq7pTPCr4m/Ch30qVerJAmoKvpPumN+h1zdEBk5PHiAJkm96sG/PTndEf" + "\r"
			+ "kZrAJ2hwSBqptcABYk6ED70gRTQ1S53tyQXIOSjRBcugY/21qeswS3nMyq3xDEPK" + "\r"
			+ "XpdyKPeaTyuK86AEkQJBAM1M7p1lfzEKjNw17SDMLnca/8pBcA0EEcyvtaQpRvaL" + "\r"
			+ "n61eQQnnPdpvHamkRBcOvgCAkfwa1uboru0QdXii/gUCQQDGmkP+KJPX9JVCrbRt" + "\r"
			+ "7wKyIemyNM+J6y1ZBZ2bVCf9jacCQaSkIWnIR1S9UM+1CFE30So2CA0CfCDmQy+y" + "\r"
			+ "7A31AkB8cGFB7j+GTkrLP7SX6KtRboAU7E0q1oijdO24r3xf/Imw4Cy0AAIx4KAu" + "\r"
			+ "L29GOp1YWJYkJXCVTfyZnRxXHxSxAkEAvO0zkSv4uI8rDmtAIPQllF8+eRBT/deD" + "\r"
			+ "JBR7ga/k+wctwK/Bd4Fxp9xzeETP0l8/I+IOTagK+Dos8d8oGQUFoQJBAI4Nwpfo" + "\r"
			+ "MFaLJXGY9ok45wXrcqkJgM+SN6i8hQeujXESVHYatAIL/1DgLi+u46EFD69fw0w+" + "\r" + "c7o0HLlMsYPAzJw="
			+ "\r";


//	private static String PRIVATE_KEY = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJPOQOCnbtknroGVHe0LUJqstVeuPXgJrTmHO8bdojED56bcEKYxpZ7sW6sM/qcMPm7YRlFP2CZUR7eSFesc4MspUU4Z1j3LoMGs7oSLHloouHgLd4LBb7l24l0olPZJmuzeHzG91CuDIMsznY/veC7JZSGg2VISYMujowzptEfPAgMBAAECgYB6OLbbTnjSJwcdbmJVruKTVLeL7rAzv8S3aoVat9EzuOfoydcWpr0uwoI22sME/ZHu9PaIrH6vi0fWm312cuXKtk05RjALGCzJQi7bbbTZZTJiHYqWCDiStkGZeMPi81zp/XpVxNhMqwxe2JlgG1kVzU9HzHjsiZpZT0rq3kWICQJBANe4BlJyvloTC7mtBCmy6ogW6mI0w08tm44LrAV9eSue01t6isez+oRG4TmzZ0qIuMMNHYBcmq7hjz/BxwdI0UUCQQCvZ8krCD7o8K7WE3gmH99sC89yKvSuLXNFOykEdLJOfDkhRgNlowVa2SFb30zNTy4KcGLQJSZxrbbfPNqIrcQDAkEAnnmxG0z0jpPDX2q9ziyEo+nB0tfUTAzDZH0qqPXe2K7bsy65WbDc7+RqfctQrK74nUK7U5u0f5lxdXNUVgOmyQJAIQelLRJHbmvsMGnIJT25P8pVjQUjwCzU2QOT7L/g18CyrV5Ww2vYVUwv6PH6r2qqm9Kf+NwWCjAREKaP7E70awJBAI+WlpttALEyVmnWlIWBHn3+1ihIO8i+6SzR9moVnCMInvbylxUycFJzqgzA5E/MLJ127VZGZ6hMV79cTNc99pU=";

	public static void main(String[] args) throws Exception {
		String source = "643230";// 要加密的字符串
		String cryptograph = encrypt(source);// 生成的密文
		System.out.println("111>>" + cryptograph + "<<<");
//		cryptograph = cryptograph.replaceAll("\\r|\\n", "");
//		System.out.println("222>>" + cryptograph + "<<<");
		String target = decrypt(cryptograph);// 解密密文

		System.out.println(target);
	}

	/**
	 * 从字符串中加载公钥
	 * 
	 * @param publicKeyStr
	 *            公钥数据字符串
	 * @throws Exception
	 *             加载公钥时产生的异常
	 */
	public static PublicKey loadPublicKeyByStr(String publicKeyStr)
			throws Exception {
		try {
			byte[] buffer = RSABase64Utils.decode(publicKeyStr);
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
//			PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
			X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
			return (RSAPublicKey) keyFactory.generatePublic(keySpec);
		} catch (NoSuchAlgorithmException e) {
			throw new Exception("无此算法");
		} catch (InvalidKeySpecException e) {
			throw new Exception("公钥非法");
		} catch (NullPointerException e) {
			throw new Exception("公钥数据为空");
		}
	}

	/**
	 * 从字符串中加载私钥<br>
	 * RSA用 加载时使用的是PKCS8EncodedKeySpec（PKCS#8编码的Key指令）。
	 * 
	 * @param privateKeyStr
	 * @return
	 * @throws Exception
	 */
	private static PrivateKey loadPrivateKey(String privateKeyStr)
			throws Exception {
		try {
			byte[] buffer = RSABase64Utils.decode(privateKeyStr);
			// X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
			PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			return (RSAPrivateKey) keyFactory.generatePrivate(keySpec);
		} catch (NoSuchAlgorithmException e) {
			throw new Exception("无此算法");
		} catch (InvalidKeySpecException e) {
			throw new Exception("私钥非法");
		} catch (NullPointerException e) {
			throw new Exception("私钥数据为空");
		}
	}

	/**
	 * 加密方法 source： 源数据
	 */
	public static String encrypt(String source) throws Exception {
		Key key = loadPublicKeyByStr(PUBLIC_KEY);
		/** 得到Cipher对象来实现对源数据的RSA加密 */
		Cipher cipher = Cipher.getInstance(ALGORITHM,bouncyCastleProvider);
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] b = source.getBytes();
		/** 执行加密操作 */
		byte[] b1 = cipher.doFinal(b);
		return Base64.encode(b1).replaceAll("\\r|\\n", "");
	}

	/**
	 * 解密算法 cryptograph:密文
	 */
	
	private static org.bouncycastle.jce.provider.BouncyCastleProvider bouncyCastleProvider = new org.bouncycastle.jce.provider.BouncyCastleProvider();

	public static String decrypt(String cryptograph) throws Exception {
		Key key = loadPrivateKey(PRIVATE_KEY);
		/** 得到Cipher对象对已用公钥加密的数据进行RSA解密 */
		Cipher cipher = Cipher.getInstance(ALGORITHM,bouncyCastleProvider);
		cipher.init(Cipher.DECRYPT_MODE, key);
		byte[] b1 = Base64.decode(cryptograph);
		/** 执行解密操作 */
		byte[] b = cipher.doFinal(b1);
		return new String(b);
	}
}