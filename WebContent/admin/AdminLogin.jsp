<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if( !username.equals("admin") || !password.equals("admin") ) {
		out.println("username or password not correct!");
		return;
	}
	session.setAttribute("admin" , "admin");
	response.sendRedirect("AdminIndex.jsp");
}
%>



<!DOCTYPE HTML>
<html dir="ltr" lang="en-US">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title>后台登陆界面</title>

	<!--- CSS --->
	<link rel="stylesheet" href="style.css" type="text/css" />


	<!--- Javascript libraries (jQuery and Selectivizr) used for the custom checkbox --->

	<!--[if (gte IE 6)&(lte IE 8)]>
		<script type="text/javascript" src="jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="selectivizr.js"></script>
		<noscript><link rel="stylesheet" href="fallback.css" /></noscript>
	<![endif]-->

	</head>

	<body>
		<div id="container">
			<form action="AdminLogin.jsp" method="post" >
			<input type="hidden" name="action" value="login"/>
				<div class="login">LOGIN</div>
				<div class="username-text">用户名:</div>
				<div class="password-text">密码:</div>
				<div class="username-field">
					<input type="text" name="username" />
				</div>
				<div class="password-field">
					<input type="password" name="password"  />
				</div>
				<input type="checkbox" name="remember-me" id="remember-me" /><label for="remember-me">Remember me</label>
				<div class="forgot-usr-pwd">Forgot <a href="#">username</a> or <a href="#">password</a>?</div>
				<input type="submit" name="submit" value="登陆" />
			</form>
		</div>
		<div id="footer">
			
		</div>
	</body>
</html>
