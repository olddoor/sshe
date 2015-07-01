package sy.model.easyui;

/**
 * 
 * JSON模型
 * 
 * 用户后台向前台返回的JSON对象
 * 
 * @author 孙宇
 * 
 */
public class msgStr implements java.io.Serializable {

	private boolean success = true;//状态

	private String msg = "操作成功"; //提示信息

	private Object obj = null;
	
	private String msgDetail;//error info

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		if(success){
			this.msg="操作成功";
		}else{
			this.msg="操作失败";
		}
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public String getMsgDetail() {
		return msgDetail;
	}

	public void setMsgDetail(String msgDetail) {
		this.msgDetail = msgDetail;
	}

}
