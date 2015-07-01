<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="sy.model.base.SessionInfo"%>
<%@ page import="sy.model.base.Syuser"%>
<%@ page import="sy.model.base.Syrole"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>index.jsp</title>
<jsp:include page="inc.jsp"></jsp:include>
<%
	out.print("------------");
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	if (sessionInfo != null) {
		if(sessionInfo.getUser()!=null){
			 Set<Syrole> roles=sessionInfo.getUser().getSyroles();
			 if(roles.size()==1){
				 Iterator<Syrole> it = roles.iterator();  
				 while (it.hasNext()) {  
				   Syrole str = it.next();  
				   if(str.getName().equals("Guest")){
					   request.getRequestDispatcher("/reg.jsp").forward(request, response); 
				   }
				 }  
			 }else{
				 request.getRequestDispatcher("/securityJsp/main.jsp").forward(request, response);
			 }
			 request.getRequestDispatcher("/securityJsp/main.jsp").forward(request, response);
		}
	} else {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}
	
%>
</head>
<body>
</body>
</html>