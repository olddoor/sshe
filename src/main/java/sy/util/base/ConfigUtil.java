package sy.util.base;

import java.util.ResourceBundle;

/**
 * 项目参数工具类
 * 
 * @author 孙宇
 * 
 */
public class ConfigUtil {
	/**
	 * ResourceBundle这个类的作用就是读取资源属性文件（properties），然后根据.properties文件的名称信息（本地化信息），
	 * 匹配当前系统的国别语言信息（也可以程序指定），然后获取相应的properties文件的内容。
	 */
	private static final ResourceBundle bundle = java.util.ResourceBundle.getBundle("config");

	/**
	 * 获得sessionInfo名字
	 * 
	 * @return
	 */
	public static final String getSessionInfoName() {
		return bundle.getString("sessionInfoName");
	}

	/**
	 * 通过键获取值
	 * 
	 * @param key
	 * @return
	 */
	public static final String get(String key) {
		return bundle.getString(key);
	}
	
	public static final String getQRURL(){
		return bundle.getString("qrurl");
	}

}
