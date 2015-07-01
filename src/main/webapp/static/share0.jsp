<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>分享</title>
    <meta name="renderer" content="webkit">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="share.css">
<jsp:include page="../inc.jsp"></jsp:include>
<style type="text/css"></style><style>.cke{visibility:hidden;}</style><style type="text/css" id="holderjs-style"></style></head>
<%
	String qrmoban=(String)request.getParameter("qrmoban");
	String id=(String)request.getParameter("vcard");
	
%>
    <script>
    	$(function(){
       	 $.ajax({
                type: "post",
                newUrl:"",
                url: sy.contextPath + "/base/syuser!doNotNeedSessionAndSecurity_qr.sy?vcard=<%=id%>" ,
                success: function (data) {
                    var jsonobj=eval('('+data+')');//通过eval() 函数可以将JSON字符串转化为对象
                    if(jsonobj.qrmoban==1){
                    	newUrl="share1";
                    }else{
                    	newUrl="share2";
                	}
                    newUrl=newUrl +'.jsp?vcard=<%=id%>';
                    window.location.href=newUrl ; 
                }
            });
       })
    </script>
    
<body class="handka navbar-fixed">
</body>
</html>