package yi.master.coretest.message.process.config;

/**
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/9/6 16:11
 */
public class AnHuiAppMsgProcessParameter {
    private String key;
    private String sensitiveInformation;
    private String publicKey;
    private String algorithmType;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getSensitiveInformation() {
        return sensitiveInformation;
    }

    public void setSensitiveInformation(String sensitiveInformation) {
        this.sensitiveInformation = sensitiveInformation;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getAlgorithmType() {
        return algorithmType;
    }

    public void setAlgorithmType(String algorithmType) {
        this.algorithmType = algorithmType;
    }
}
