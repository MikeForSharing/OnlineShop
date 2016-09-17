<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>

<%@ include file="_SessionCheck.jsp" %>
<%
//TODO you should validate the id
int id = Integer.parseInt(request.getParameter("id"));
UserManager.deleteUser(id);
%>


<html>
	<head>
		<title>删除用户</title>
	</head>
	<body>
	删除成功
	<script language="javascript">
		<!--
		parent.main.reload(); 
		-->
	</script>
	</body>
</html>