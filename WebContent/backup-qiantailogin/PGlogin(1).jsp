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


<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>

        <meta charset="utf-8">
        <title>Fullscreen Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
        <link rel="stylesheet" href="assets/css/reset.css">
        <link rel="stylesheet" href="assets/css/supersized.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

    </head>

    <body>

        <div class="page-container">
            <h1>Login</h1>
            <form action="PGlogin.jsp" method="post">
            <input type="hidden" name="action" value="login"/>
                <input type="text" name="username" class="username" placeholder="Username">
                <input type="password" name="password" class="password" placeholder="Password">
                <button type="submit">Sign me in</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect">
                <p>Or connect with:</p>
                <p>
                    <a class="facebook" href=""></a>
                    <a class="twitter" href=""></a>
                </p>
            </div>
        </div>
        <div align="center"></div>

        <!-- Javascript -->
        <script src="assets/js/jquery-1.8.2.min.js"></script>
        <script src="assets/js/supersized.3.2.7.min.js"></script>
        <script src="assets/js/supersized-init.js"></script>
        <script src="assets/js/scripts.js"></script>

    </body>

</html>

