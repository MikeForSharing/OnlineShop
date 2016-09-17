<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %> 
    
<%
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	User u = null;
	try {
		u = User.validate(username, password);
		
	} catch (UserNotFoundException e) {
		out.println("用户名不对");
		return;
		//response.sendRedirect("Login.jsp");
	} catch (PasswordNotCorrectException e) {
		out.println("密码不对");
		return; 
	}
	
	session.setAttribute("user", u);
	User check = (User)session.getAttribute("user");
	
	if(check == null) {
		out.println("用户没有登录！");
	} else {
		response.sendRedirect("LoginSucceed.jsp");
	}
}
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<form action="Login.jsp" method="post" >
	<input type="hidden" name="action" value="login"/>
<table border="1" align="center">
	<tr>
		<td clospan="2" align="center">用户登陆</td>
	</tr>
	<tr>
		<td>用户名:</td>
		<td><input type="text" size="10" name="username"/></td>
	</tr>
	<tr>
		<td>密码:</td>
		<td><input type="password" size="10" name="password"/></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="登陆"/><input type="reset" value="重置"/></td>
	</tr>
</table>
</form>
</body>
</html>