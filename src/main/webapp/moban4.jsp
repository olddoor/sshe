<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sy.model.base.SessionInfo"%>
<%@ page import="sy.model.base.Syuser"%>
<%@ page import="sy.util.base.StringUtil"%>
<%@ page import="sy.util.base.ConfigUtil"%>

<%
	String contextPath = request.getContextPath();
	Syuser u=(Syuser)request.getSession().getAttribute("user");
	String QRURL=ConfigUtil.getQRURL();
	if(u!=null){
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/static/css2/ui-input-replace.css" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css2/commonCss.css" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css2/content.css" />
   <style type="text/css">
   @media only screen and (min-width :1025px){
	body{ background: url(<%=contextPath%>/static/images2/bodybg_c_1.jpg) center center no-repeat !important; background-size: cover;}
}
   </style>    
   <script src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
   <script src="http://apps.bdimg.com/libs/jquerymobile/1.4.2/jquery.mobile.min.js"></script>
   
 
</head>
<body>
<div class="phonebg"></div>
<div data-role="page" id="pageId1" class="pagebox">

<!----------dialog---------->
<div class="dialpage" id="share" style="display:none;">
 <div class="maskbox"></div>
 <div class="dialbox size-m">
   <div class="dialwrap">  
    <div class="dialframe">
      <div class="shareimg"><img src="<%=contextPath%>/<%=u.getQrPhoto() %>"  alt=""/></div>
      <div class="sharetxt">
          <a href="<%=QRURL%><%=u.getLoginname()%>" class="t"><%=QRURL%><%=u.getLoginname()%></a>
      </div>
    
      
      </div>
      
        <div class="closebtn">
      <a href="javascript:void(0)" class="close">关闭</a>
      </div>
      
      
    </div>
  </div>
</div>
<!-----dialog-end------> 


     <div data-role="content" class="show show_bg1">
     
     <div class="show_c_top">
     <div id="share123" class="share"><em></em></div>
     <p class="company_b"><%=u.getCompany()%></p>
     </div>
     
     <div class="show_c_con fixed">
     <div class="wrap">
     <div class="head_b"><div class="head_img_b"><img src="<%=contextPath%>/static/images2/head_img_b.jpg" width="200" height="200"  alt=""/></div></div>
     <div class="info_b_1">
     <ul>
     <li><span class="name_b"><%=u.getName()%></span><span class="job_b"><%=u.getDuty()%></span></li>
     <li><span class="phone_icon_b"></span><span class="phone_b"><%=u.getCellPhone()%></span></li>
     </ul>
     </div>
     
     <div class="info_b_2">
     <ul>
     
      <li><em class="tel_b"></em><span class="text_b"><%=u.getPhone()%></span></li>
      <li><em class="email_b"></em><span class="text_b"><%=u.getEmail()%></span></li>
      <li><em class="code_b"></em><span class="text_b"><%=u.getZipCode()%></span></li>
      <li><em class="address_b"></em><span class="text_b"><%=u.getCompany_address()%></span></li>
     </ul>
     </div>
     
     </div>
     </div>
     
     
     
     </div>
</div>
  <script src="<%=contextPath%>/js/jquery.ua2.js" type="text/javascript" charset="utf-8"></script>
  <script>
   var is_MobleTyte=$.ua().isMobile ;
     		
$(document).on("pageinit","#pageId1",function(){
  //控制id="dialpage"(“号码弹框”)弹出代码；------------------------------------------
  $(".share").on("tap",function(){
  $("#share").show();
  });
  $(".closebtn a").on("tap",function(){
    $(this).parents(".dialpage").hide();
  });
})
	if(is_MobleTyte){
		 $("#share123").hide();
	}
</script>
</body>
</html>
<% }
	else{
		response.sendRedirect("login.jsp");
	}
%>