<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*, java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>

<%
//get all the users
List<User> users = User.getUsers();
%>


<html>
<head>
<title>��Ա�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
	<table border="1", align="center">
		<tr>
			<td>ID</td>
			<td>�û���</td>
			<td>�绰</td>
			<td>��ַ</td>
			<td>����</td>
			<td>����</td>
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
				<a href="UserDelete.jsp?id=<%=u.getId() %>" target="detail" >ɾ���û�</a>
			</td>
		</tr>
		
		<% 
		}
		%>
	</table>
</body>
</html>
