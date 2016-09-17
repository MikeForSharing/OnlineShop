<%@ page language="java" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>

<%

List<Category> categories = Category.getCategories();
%>


<html> 
<head>
<title>��Ʒ����б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
	<table border="1", align="center">
		<tr>
			<td>ID</td>
			<td>name</td>
			<td>pid</td>
			<td>grade</td>
			<td>����</td>
			
		</tr>
		<%
		for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
			Category c = it.next();
			String preStr = "";
			for(int i=1; i<c.getGrade(); i++) {
				preStr += "----";
			}
		%>
			<tr>
			<td><%=c.getId() %></td>
			<td><%=preStr + c.getName() %></td>
			<td><%=c.getPid() %></td>
			<td><%=c.getGrade() %></td>
			<td>
				<a href="CategoryAdd.jsp?pid=<%=c.getId() %>">��������</a>
				&nbsp;
				<%if(c.isLeaf()) { %>
				
				<a href="ProductAdd.jsp?categoryid=<%=c.getId() %>">�ڸ�������������Ʒ</a>
				
				<%} %>
			</td>
			</tr>
		
		
		<% 
		}
		%>
	</table>
</body>
</html>
