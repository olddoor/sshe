<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sy.model.base.Syuser"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="share.css">
<jsp:include page="../inc.jsp"></jsp:include>
<style type="text/css"></style><style>.cke{visibility:hidden;}</style><style type="text/css" id="holderjs-style"></style></head>
<%
	String id=(String)request.getParameter("vcard");
%>
 <script>
    
        $(function(){
        	 $.ajax({
                 type: "post",
                 url: sy.contextPath + "/base/syuser!doNotNeedSessionAndSecurity_qr.sy?vcard=<%=id%>" ,
                 success: function (data) {
                     var jsonobj=eval('('+data+')');//通过eval() 函数可以将JSON字符串转化为对象
                     $("#frame001").contents().find("#zzz1").html(jsonobj.name);
                     $("#frame001").contents().find("#zzz2").html(jsonobj.duty);
                     $("#frame001").contents().find("#zzz3").html("公司: "+jsonobj.company);
                     $("#frame001").contents().find("#zzz4").html("电话: "+jsonobj.cellPhone);
                     $("#frame001").contents().find("#zzz5").html("固话: "+jsonobj.cellPhone);
                     $("#frame001").contents().find("#zzz6").html("电邮: "+jsonobj.email);
                     $("#frame001").contents().find("#zzz7").html("传真: "+jsonobj.fax);
                     $("#frame001").contents().find("#zzz8").html("地址: "+jsonobj.company_address);
                 }
             });
        })
    </script>
<body class="handka navbar-fixed">
    <div class="main">
        <div class="banner">
        </div>
        <div class="phone">
            <div class="phone-inner">
                <iframe src="info2.htm" frameborder="0" id="frame001"></iframe>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="jquery-1.js"></script>
        <script type="text/javascript" src="ender-base.js"></script>
        <script type="text/javascript" src="ender-app.js"></script>
    <script>
    </script>
</body></html>