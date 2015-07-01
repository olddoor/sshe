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
    <link rel="stylesheet" href="<%=contextPath%>//static/css/ui-input-replace.css" />
    <link rel="stylesheet" href="<%=contextPath%>/static/css/commonCss.css" />
   <link rel="stylesheet" href="<%=contextPath%>/static/css/content.css" />
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
           <a style="text-align:center;" href="<%=QRURL%><%=u.getLoginname()%>" class="t"><%=QRURL%><%=u.getLoginname()%></a>
      </div>
      </div>
        <div class="closebtn">
      <a href="javascript:void(0)" class="close">关闭</a>
      </div>
    </div>
  </div>
</div>
<!-----dialog-end------> 
     <div data-role="content" class="show">
     <div class="header">
     <div id="share123" class="share"><em></em></div>
     <div class="headwrap">
     <div class="head"></div>
     </div>
     <h4 class="name"><%=u.getName() %></h4>
     <p class="job"><%=u.getDuty()%></p>
     </div>
     <div class="showbox fixed">
     <ul>  
         <li>
         <a href="javascript:void(0)" class="company">
         <div class="ico">
         <em class="i"></em>
         </div>
         <div class="txt"><%=u.getCompany()%></div>
         </a>
         </li>
         <li>
         <a href="javascript:void(0)" class="phone">
         <div class="ico">
         <em class="i"></em>
         </div>
          <div class="txt"><%=u.getPhone()%></div>
         </a>
         </li>

         <li>
         <a href="javascript:void(0)" class="tel">
         <div class="ico">
         <em class="i"></em>
         </div>
          <div class="txt"><%=u.getZipCode()%></div>
         </a>
         </li>

         <li>
         <a href="javascript:void(0)" class="email">
         <div class="ico">
         <em class="i"></em>
         </div>
          <div class="txt"><%=u.getEmail()%></div>
         </a>
         </li>
         <li>
         <a href="javascript:void(0)" class="code">
         <div class="ico">
         <em class="i"></em>
         </div>
          <div class="txt"><%=u.getZipCode()%></div>
         </a>
         </li>

         <li>
         <a href="javascript:void(0)" class="address">
         <div class="ico">
         <em class="i"></em>
         </div>
          <div class="txt"><%=u.getCompany_address()%></div>
         </a>
         </li>
     </ul>     
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