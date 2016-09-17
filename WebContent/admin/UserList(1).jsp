<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*, java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>

<%
//get all the users
List<User> users = User.getUsers();
%>


<html>
<head>
<title>会员列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
	<table border="1", align="center">
		<tr>
			<td>ID</td>
			<td>用户名</td>
			<td>电话</td>
			<td>地址</td>
			<td>日期</td>
			<td>处理</td>
		</tr>
		<%
		for(Iterator<User> it = users.iterator(); it.hasNext();) {
			User u = it.next();
		%>
			<tr>
			<td><%=u.getId() %></td>
			<td><%=u.getUsername() %></td>
			<td><%=u.getPhone() %></td>
			<td><%=u.getAddr() %></td>
			<td><%=u.getRdate() %></td>
			<td>
				<a href="UserDelete.jsp?id=<%=u.getId() %>" target="detail" >删除用户</a>
			</td>
		</tr>
		
		<% 
		}
		%>
	</table>
</body>
</html>
