package yi.master.util.cache;

import cn.hutool.core.io.FileUtil;
import org.apache.commons.lang3.StringUtils;
import yi.master.util.FrameworkUtil;

import javax.servlet.ServletContext;
import java.io.File;

/**
 * 自定义配置变量
 * @author xuwangcheng
 * @version 1.0.0
 * @description
 * @date 2019/12/10 16:26
 */
public class CustomSettingVariable {
    public static String GLOBAL_VARIABLE_FILE_SAVE_PATH = FrameworkUtil.getProjectPath() + File.separator + ".." + File.separator + "variableFileResources";

    public static void setSettingVariable (ServletContext context) {
        Object str = context.getAttribute("globalVariableFileSavePath");
        if (str != null && StringUtils.isNotBlank(str.toString())) {
            GLOBAL_VARIABLE_FILE_SAVE_PATH = str.toString();
        }
        if (!FileUtil.exist(GLOBAL_VARIABLE_FILE_SAVE_PATH)) {
            FileUtil.mkdir(GLOBAL_VARIABLE_FILE_SAVE_PATH);
        }

    }
}
