package sy.action.base;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;

import sy.action.BaseAction;
import sy.model.base.SessionInfo;
import sy.model.base.Syorganization;
import sy.model.base.Syrole;
import sy.model.base.Syuser;
import sy.model.easyui.Grid;
import sy.model.easyui.Json;
import sy.model.easyui.msgStr;
import sy.service.BaseServiceI;
import sy.service.base.SyroleServiceI;
import sy.service.base.SyuserServiceI;
import sy.util.base.BeanUtils;
import sy.util.base.ConfigUtil;
import sy.util.base.HqlFilter;
import sy.util.base.IpUtil;
import sy.util.base.MD5Util;

/**
 * 用户
 * 
 * action访问地址是/base/syuser.sy
 * 
 * @author 孙宇
 * 
 */
@Namespace("/base")
@Action
public class SyuserAction extends BaseAction<Syuser> {

	/**
	 * 注入业务逻辑，使当前action调用service.xxx的时候，直接是调用基础业务逻辑
	 * 
	 * 如果想调用自己特有的服务方法时，请使用((TServiceI) service).methodName()这种形式强转类型调用
	 * 
	 * @param service
	 */
	@Autowired
	public void setService(SyuserServiceI service) {
		this.service = service;
	}
	
//	protected BaseServiceI<Syrole> roleservice;// 业务逻辑
//	@Autowired
//	public void setService(SyroleServiceI roleservice) {
//		this.roleservice = roleservice;
//	}
	

	/**
	 * 注销系统
	 */
	public void doNotNeedSessionAndSecurity_logout() {
		if (getSession() != null) {
			getSession().invalidate();
		}
		Json j = new Json();
		j.setSuccess(true);
		writeJson(j);
	}
	
	/**
	 * 对已经注册的进行提示.未注册的进行update
	 */
	synchronized public void doNotNeedSessionAndSecurity_reg2(){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String loginName=request.getParameter("loginName");
		String pwd=request.getParameter("pwd");
		Json json = new Json();
		HqlFilter hqlFilter = new HqlFilter();
		hqlFilter.addFilter("QUERY_t#loginname_S_EQ", loginName);
		Syuser user = service.getByFilter(hqlFilter);
		if (user != null) {
			json.setMsg("用户名已存在！");
			writeJson(json);
		} else {
			Syuser t = new Syuser();
//			BeanUtils.copyNotNullProperties(data, t, new String[] { "createdatetime" });
			t.setLoginname(loginName);
			t.setPwd(MD5Util.md5(pwd));
			t.setQrmoban(2);
//			service.save(t);
			((SyuserServiceI) service).saveUser(t);
		//	this.createQRcodeOne(t.getLoginname());
			doNotNeedSessionAndSecurity_login2();
		}
	
	}

	/**
	 * 注册
	 */
	synchronized public void doNotNeedSessionAndSecurity_reg() {
		Json json = new Json();
		HqlFilter hqlFilter = new HqlFilter();
		hqlFilter.addFilter("QUERY_t#loginname_S_EQ", data.getLoginname());
		Syuser user = service.getByFilter(hqlFilter);
		if (user != null) {
			json.setMsg("用户名已存在！");
			writeJson(json);
		} else {
			Syuser t = new Syuser();
			BeanUtils.copyNotNullProperties(data, t, new String[] { "createdatetime" });
			t.setLoginname(data.getLoginname());
			t.setPwd(MD5Util.md5(data.getPwd()));
			t.setQrmoban(2);
//			service.save(t);
			((SyuserServiceI) service).saveUser(t);
			this.createQRcodeOne(t.getLoginname());
			doNotNeedSessionAndSecurity_login();
		}
	}
	
	public void doNotNeedSessionAndSecurity_qr(){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String loginName=request.getParameter("vcard");
		Syuser user=null;
		if(loginName!=null){
			 user=((SyuserServiceI)service).getByHql(" from Syuser where loginname='"+loginName+"'");
			 request.setAttribute("user", user);
		}
		
		writeJson(user);
//		return "SUCCESS";
	}

	@Action(value = "/qrqrurl", results = { 
	@Result(name = "moban1",  type="redirect",location = "/moban1.jsp"),
	@Result(name = "moban2", type="redirect",location = "/moban2.jsp"),  
	@Result(name = "moban3", type="redirect",location = "/moban3.jsp"),  
	@Result(name = "moban4", type="redirect",location = "/moban4.jsp"),  
	@Result(name = "err", type="redirect",location = "/error/404.jsp") }) 
	public String qrcode_qrurl(){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String loginName=request.getParameter("vcard");
		Syuser user=null;
		if(loginName!=null){
			 user=((SyuserServiceI)service).getByHql(" from Syuser where loginname='"+loginName+"'");
			 request.getSession().setAttribute("user", user);
			 if(user.getQrmoban()!=null){
				 String moban=user.getQrmoban().toString();
				 if(moban.equals("1")){
					 return "moban1";
				 }else if(moban.equals("2")){
					 return "moban2";
				 }else if(moban.equals("3")){
					 return "moban3";
				 }else if(moban.equals("4")){
					 return "moban4";
				 }
			 }
		}
//		writeJson(user);
		return "err";
	}
	
	
	/**
	 * 封装删除用户
	 */
	public void deleteUser() {
		Json json = new Json();
		json.setSuccess(true);
		if (!StringUtils.isBlank(id)) {
			Syuser t = service.getById(id);
			if(t.getLoginname().contains("admin")){
				json.setSuccess(false);
				json.setMsg("admin不可删除！");
			}else{
				service.delete(t);
				json.setMsg("删除成功！");
			}
		}
		writeJson(json);
	}
	
	/**
	 * diy登录给名片使用
	 */
	public void doNotNeedSessionAndSecurity_login2(){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String loginName=request.getParameter("loginName");
		String pwd=request.getParameter("pwd");
		HqlFilter hqlFilter = new HqlFilter();
		hqlFilter.addFilter("QUERY_t#loginname_S_EQ", loginName);
		hqlFilter.addFilter("QUERY_t#pwd_S_EQ", MD5Util.md5(pwd));
		Syuser user = service.getByFilter(hqlFilter);
		msgStr msg=new msgStr();
		if (user != null) {
			msg.setSuccess(true);
			SessionInfo sessionInfo = new SessionInfo();
			Hibernate.initialize(user.getSyroles());
			Hibernate.initialize(user.getSyorganizations());
			msg.setMsgDetail("guest");
			for (Syrole role : user.getSyroles()) {
				if(role.getName().contains("超管")||role.getName().contains("admin")||role.getName().contains("管理员")){
					msg.setMsgDetail("admin");
				}
				Hibernate.initialize(role.getSyresources());
			}
			for (Syorganization organization : user.getSyorganizations()) {
				Hibernate.initialize(organization.getSyresources());
			}
			user.setIp(IpUtil.getIpAddr(getRequest()));
			sessionInfo.setUser(user);
			getSession().setAttribute(ConfigUtil.getSessionInfoName(), sessionInfo);
		} else {
			msg.setSuccess(false);
			msg.setMsg("用户名或密码错误！");
		}
		writeJson(msg);
	}
	
	/**
	 * 登录
	 */
	public void doNotNeedSessionAndSecurity_login() {
		HqlFilter hqlFilter = new HqlFilter();
		hqlFilter.addFilter("QUERY_t#loginname_S_EQ", data.getLoginname());
		hqlFilter.addFilter("QUERY_t#pwd_S_EQ", MD5Util.md5(data.getPwd()));
		Syuser user = service.getByFilter(hqlFilter);
		Json json = new Json();
		if (user != null) {
			json.setSuccess(true);

			SessionInfo sessionInfo = new SessionInfo();
			Hibernate.initialize(user.getSyroles());
			Hibernate.initialize(user.getSyorganizations());
			for (Syrole role : user.getSyroles()) {
				Hibernate.initialize(role.getSyresources());
			}
			for (Syorganization organization : user.getSyorganizations()) {
				Hibernate.initialize(organization.getSyresources());
			}
			user.setIp(IpUtil.getIpAddr(getRequest()));
			sessionInfo.setUser(user);
			getSession().setAttribute(ConfigUtil.getSessionInfoName(), sessionInfo);
		} else {
			json.setMsg("用户名或密码错误！");
		}
		writeJson(json);
	}
	

	/**
	 * 修改自己的密码
	 */
	public void doNotNeedSecurity_updateCurrentPwd() {
		SessionInfo sessionInfo = (SessionInfo) getSession().getAttribute(ConfigUtil.getSessionInfoName());
		Json json = new Json();
		Syuser user = service.getById(sessionInfo.getUser().getId());
		user.setPwd(MD5Util.md5(data.getPwd()));
		user.setUpdatedatetime(new Date());
		service.update(user);
		json.setSuccess(true);
		writeJson(json);
	}

	/**
	 * 修改用户角色
	 */
	public void grantRole() {
		Json json = new Json();
		((SyuserServiceI) service).grantRole(id, ids);
		json.setSuccess(true);
		writeJson(json);
	}

	/**
	 * 修改用户机构
	 */
	public void grantOrganization() {
		Json json = new Json();
		((SyuserServiceI) service).grantOrganization(id, ids);
		json.setSuccess(true);
		writeJson(json);
	}

	/**
	 * 统计用户注册时间图表
	 */
	public void doNotNeedSecurity_userCreateDatetimeChart() {
		writeJson(((SyuserServiceI) service).userCreateDatetimeChart());
	}

	/**
	 * 新建一个用户
	 */
	synchronized public void save() {
		Json json = new Json();
		try {
			if (data != null) {
				HqlFilter hqlFilter = new HqlFilter();
				hqlFilter.addFilter("QUERY_t#loginname_S_EQ",
						data.getLoginname());
				Syuser user = ((SyuserServiceI) service).getByFilter(hqlFilter);
				if (user != null) {
					json.setMsg("新建用户失败，用户名已存在！");
				} else {
					data.setPwd(MD5Util.md5("123456"));
					data.setQrmoban(2);
//					service.save(data);
					((SyuserServiceI) service).saveUser(data);
					this.createQRcodeOne(data.getLoginname());
					json.setMsg("新建用户成功！默认密码：123456");
					json.setSuccess(true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		writeJson(json);
	}
	
	@Action(value = "/qrqr", results = { 
	@Result(name = "moban1",  type="redirect",location = "/moban1.jsp"),
	@Result(name = "moban2", type="redirect",location = "/moban2.jsp"),
	@Result(name = "moban3", type="redirect",location = "/moban3.jsp"), 
	@Result(name = "moban4", type="redirect",location = "/moban4.jsp"), 
	@Result(name = "err", type="redirect",location = "/moban1.html") }) 	
	synchronized public String update2() {
		HttpServletRequest request = ServletActionContext.getRequest();
		msgStr json = new msgStr();
		json.setSuccess(true);
		json.setMsg("更新成功！");
		try {
			Syuser t = service.getById(data.getId());
			BeanUtils.copyNotNullProperties(data, t, new String[] { "createdatetime","pwd" });
			service.update(t);
			this.createQRcodeOne(data.getLoginname());
			//update结束进行跳转
			request.getSession().setAttribute("user", t);
			 if(t.getQrmoban()!=null){
			 String moban=t.getQrmoban().toString();
			 if(moban.equals("1")){
				 return "moban1";
			 }else if(moban.equals("2")){
				 return "moban2";
			 }else if(moban.equals("3")){
				 return "moban3";
			 }else if(moban.equals("4")){
				 return "moban4";
			 }
		 }
			
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("操作失败");
			json.setMsgDetail(e.getMessage());
		}
//		writeJson(json);
		request.setAttribute("error", json);
		return "err";
	}
	
	/**
	 * 更新一个用户
	 */
	synchronized public void update() {
		Json json = new Json();
		json.setMsg("更新失败！");
		if (data != null && !StringUtils.isBlank(data.getId())) {
			HqlFilter hqlFilter = new HqlFilter();
			hqlFilter.addFilter("QUERY_t#id_S_NE", data.getId());
			hqlFilter.addFilter("QUERY_t#loginname_S_EQ", data.getLoginname());
			Syuser user = service.getByFilter(hqlFilter);
			if (user != null) {
				json.setMsg("更新用户失败，用户名已存在！");
			} else {
				Syuser t = service.getById(data.getId());
				BeanUtils.copyNotNullProperties(data, t, new String[] { "createdatetime","pwd" });
				service.update(t);
				this.createQRcodeOne(data.getLoginname());
				json.setSuccess(true);
				json.setMsg("更新成功！");
			}
		}
		writeJson(json);
	}

	/**
	 * 用户登录页面的自动补全
	 */
	public void doNotNeedSessionAndSecurity_loginNameComboBox() {
		HqlFilter hqlFilter = new HqlFilter();
		hqlFilter.addFilter("QUERY_t#loginname_S_LK", "%%" + StringUtils.defaultString(q) + "%%");
		hqlFilter.addSort("t.loginname");
		hqlFilter.addOrder("asc");
		writeJsonByIncludesProperties(service.findByFilter(hqlFilter, 1, 10), new String[] { "loginname" });
	}

	/**
	 * 用户登录页面的grid自动补全
	 */
	public void doNotNeedSessionAndSecurity_loginNameComboGrid() {
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		hqlFilter.addFilter("QUERY_t#loginname_S_LK", "%%" + StringUtils.defaultString(q) + "%%");
		grid.setTotal(service.countByFilter(hqlFilter));
		grid.setRows(service.findByFilter(hqlFilter, page, rows));
		writeJson(grid);
	}
	
	
	
	public void createQRcode(){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String webParentPath = new File(request.getSession().getServletContext().getRealPath("/")).getParent();// 当前WEB环境的上层目录
		String realPath = webParentPath + ConfigUtil.get("uploadPath") + "/qrcodePhoto";// 文件上传到服务器的真实路径
		String path = ConfigUtil.get("uploadPath");
		Json json = new Json();
		//创建qrcode
		((SyuserServiceI)service).saveQRcode(path,realPath);
		json.setSuccess(true);
		json.setMsg("操作完成！");
		writeJson(json);
	}
	
	public void createQRcodeOne(String loginname){
		HttpServletRequest request = ServletActionContext.getRequest(); 
		String webParentPath = new File(request.getSession().getServletContext().getRealPath("/")).getParent();// 当前WEB环境的上层目录
		String realPath = webParentPath + ConfigUtil.get("uploadPath") + "/qrcodePhoto";// 文件上传到服务器的真实路径
		String path = ConfigUtil.get("uploadPath");
		//创建qrcode
		((SyuserServiceI)service).saveQRcodeOne(loginname,path,realPath);
	}

}
