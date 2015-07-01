<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.css">
    <link rel="stylesheet" href="static/css/ui-input-replace.css" />
    <link rel="stylesheet" href="static/css/commonCss.css" />
    <link rel="stylesheet" href="static/css/loginCss.css" />
    <script src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.js"></script>
</head>
<title>系统登录</title>
<jsp:include page="inc.jsp"></jsp:include>
	<script type="text/javascript">
	  function regUser(){
		  var username=$("#user-inp").val();
		  var pwd=$("#lock-inp").val();
		  if(username==""){ 
			  $.messager.alert('填写有误','用户名不能为空');
	            return false;   
	      }
		  if(pwd==""){
			  $.messager.alert('填写有误','密码不能为空');          
	            return false;   
	      }
		  
		  if(!isStr($("#user-inp").val())){
			  return false;
		  }
		  if(!isStr($("#lock-inp").val())){
			  return false;
		  }
		  $.post(sy.contextPath + '/base/syuser!doNotNeedSessionAndSecurity_reg2.sy', 
				  { 
			  		loginName: $("#user-inp").val(),
			  		pwd: $("#lock-inp").val()
				  },
			function(result) {
				if (result.success) {
						location.replace(sy.contextPath + '/reg.jsp');
				} else {
						$.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
	  }
	  
	  function submit(){
		  var username=$("#user-inp").val();
		  var pwd=$("#lock-inp").val();
		  if(username==""){ 
			  $.messager.alert('填写有误','用户名不能为空');
	            return false;   
	      }
		  if(pwd==""){
			  $.messager.alert('填写有误','密码不能为空');          
	            return false;   
	      }
		  
		  if(!isStr($("#user-inp").val())){
			  return false;
		  }
		  if(!isStr($("#lock-inp").val())){
			  return false;
		  }
		  //check end 开始提交
		  $.post(sy.contextPath + '/base/syuser!doNotNeedSessionAndSecurity_login2.sy', 
				  { 
			  		loginName: $("#user-inp").val(),
			  		pwd: $("#lock-inp").val()
				  },
				  function(result) {
				if (result.success) {
					if(result.msgDetail=='admin'){
						location.replace(sy.contextPath + '/securityJsp/main.jsp');
					}else{
						location.replace(sy.contextPath + '/reg.jsp');
					}
				} else {
					$.messager.alert('提示', result.msg, 'error', function() {
						
					});
				}
			}, 'json');
	  }
	  
	  function isStr(obj){
		  console.log(" console.log(obj);");
		  console.log(obj);
		  reg= /^[A-Za-z0-9]+$/;  //字母和数字^[A-Za-z0-9]+$ 
	        if(!reg.test(obj)){
	        	 $.messager.alert('填写有误','只允许输入字母和数字');
	        	 $("#user-inp").html(""); 
	        	 return false;
	         }
		  return true;
	  }
	</script>
<body>
<div class="phonebg"></div>
<div data-role="page" id="pageId1" class="pagebox">
    <div class="login" data-role="content" data-position="fixed">
      
        <div class="loginlist fixed">
            <ul>
                <li><div class="item"></div> <div class="ico"><em class="user">
                	</em></div>
                		<div class="inp">
                			<input type="text" data-role="none" id="user-inp" 
                				placeholder="请输入用户名" >
                		</div></li>
                <li><div class="item"></div> 
                		<div class="ico"><em class="lock"></em></div><div class="inp">
                		<input type="password" data-role="none" id="lock-inp" 
                		placeholder="请输入密码" ></div></li>
            </ul>
        </div>
       <!-----footer----->
    <div class="loginbtn ftclear" >
        <div class="wrap">
        <div class="btndiv"><input class="btn orange" name="data.loginname"  data-role="none" type="button" id="page1-btn-cancel" value="注册" onclick="regUser();"></div>
        <div class="btndiv"><input class="btn blue" name="data.pwd" data-role="none" type="button" id="page1-btn-Submit" value="提交" onclick="submit();"></div>
            </div>
    </div>
    <!--footer-end-->
    </div>
</div>
</body>
</html>