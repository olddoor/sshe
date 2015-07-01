<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sy.model.base.SessionInfo"%>
<%@ page import="sy.model.base.Syuser"%>
<%@ page import="sy.util.base.StringUtil"%>
<%@ page import="sy.model.easyui.msgStr"%>
<%
	String contextPath = request.getContextPath();
	String id=null;
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	Syuser u=null;
	if (sessionInfo != null) {
		u=sessionInfo.getUser();
		id=sessionInfo.getUser().getId();
	}
	if (id == null) {
		id = "";
	}
	msgStr msg=(msgStr)request.getAttribute("msg");
	String err="false";
	if(msg!=null&&msg.isSuccess()==false){
		err="true";
	}
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>用户信息</title>
    <jsp:include page="inc.jsp"></jsp:include>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.css">
    <link rel="stylesheet" href="static/css/ui-input-replace.css" />
    <link rel="stylesheet" href="static/css/commonCss.css" />
   <link rel="stylesheet" href="static/css/content.css" />
    <script src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.js"></script>
</head>
<body>
<script type="text/javascript">
	$(function() {
		if(<%=err%>){
			showlog();
		}
	});
	
	function showlog(){
		$.messager.alert('提示', "操作失败", 'error', function() {
		});
	}
	function submit(){
		$.post(sy.contextPath + '/base/syuser!update2.sy', 
				  { 
				    id:$("#uid").val(),
				    loginName:$("#loginName").val(),
					name: $("#name").val(),
					company: $("#company").val(),
					duty: $("#duty").val(),
					cellPhone: $("#cellPhone").val(),
					phone: $("#phone").val(),
					email: $("#email").val(),
					zipCode: $("#zipCode").val(),
					company_address: $("#company_address").val(),
					qrmoban: $("#qrmoban").val()
			});
	}
</script>
<div class="phonebg"></div>
<div data-role="page" id="pageId1" class="pagebox">
	 <input type="hidden" id="uid" value=<%=id %>>
	  <input type="hidden" id="loginName" value=<%=u.getLoginname()%>>
     <div data-role="content" class="preview" data-position="fixed">
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">姓名</p></div>
     <div class="inp"><input type="text" data-role="none" id="name" placeholder="请输入您的姓名" value="<%=StringUtil.blanknull(u.getName())%>"></div>
     </div>
     </div>
     
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">公司名称</p></div>
     <div class="inp"><input type="text" data-role="none" id="company" placeholder="请输入您的公司名称" value="<%=StringUtil.blanknull(u.getCompany())%>"></div>
     </div>
     </div>
     
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">公司职位</p></div>
     <div class="inp"><input type="text" data-role="none" id="duty" placeholder="请输入您的职位" value="<%=StringUtil.blanknull(u.getDuty())%>"></div>
     </div>
     </div>
     
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">移动电话</p></div>
     <div class="inp"><input type="text" data-role="none"  id="cellPhone" placeholder="请输入您的电话号码" value="<%=StringUtil.blanknull(u.getCellPhone())%>"></div>
     </div>
     </div>
 
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">联系电话</p></div>
     <div class="inp"><input type="text" data-role="none" id="phone"  placeholder="请输入您的电话号码" value="<%=StringUtil.blanknull(u.getPhone())%>"></div>
     </div>
     </div>
     
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">邮箱地址</p></div>
     <div class="inp"><input type="text" data-role="none" id="email" placeholder="请输入您的电子邮箱" value="<%=StringUtil.blanknull(u.getEmail())%>"></div>
     </div>
     </div>
 
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">邮编</p></div>
     <div class="inp"><input type="text" data-role="none"  id="zipCode" placeholder="请输入您的邮政编码" value="<%=StringUtil.blanknull(u.getZipCode())%>"></div>
     </div>
     </div>
     
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">地址</p></div>
     <div class="inp"><input type="text" data-role="none"  id="company_address" placeholder="请输入您的联系地址" value="<%=StringUtil.blanknull(u.getQrmoban().toString())%>"></div>
     </div>
     </div>
    
     <div class="listbox">
     <div class="wrap">
     <div class="til"><p class="t">模板</p></div>
     <div class="inp">
        <select class="ftclear" name="templet" data-role='none'  id="qrmoban"> 
         <option value="1" <%="1".equals(u.getQrmoban())?"selected":"" %>>模板1</option>
         <option value="2" <%="2".equals(u.getQrmoban())?"selected":"" %>>模板2</option>
         <!-- <option value="3">模板3</option>
         <option value="4">模板4</option> -->
        </select>
     </div>
     </div>
     </div>
     
  <!-----footer----->
    <div class="btnbox ftclear" >
        <div class="btndiv"><input class="btn blue" data-role="none" type="button" id="page1-btn-Submit" value="预览" onclick="submit();"></    </div>
    <!--footer-end-->
     </div>
</div>
</body>
</html>