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
		out.println("�û�������");
		return;
		//response.sendRedirect("Login.jsp");
	} catch (PasswordNotCorrectException e) {
		out.println("���벻��");
		return; 
	}
	
	session.setAttribute("user", u);
	User check = (User)session.getAttribute("user");
	
	if(check == null) {
		out.println("�û�û�е�¼��");
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
		<td clospan="2" align="center">�û���½</td>
	</tr>
	<tr>
		<td>�û���:</td>
		<td><input type="text" size="10" name="username"/></td>
	</tr>
	<tr>
		<td>����:</td>
		<td><input type="password" size="10" name="password"/></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="��½"/><input type="reset" value="����"/></td>
	</tr>
</table>
</form>
</body>
</html>