<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("GB18030");
int id = Integer.parseInt(request.getParameter("id"));
//System.out.println(id);
Product p = ProductMgr.getInstance().loadById(id);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<html>
	<head>
		<title>�����Ʒ���</title>
	</head>
	<body>
	<center>��Ʒչʾ</center>
		<img alt=<%=p.getName()%> src="admin/images/product/<%=p.getId() %>.jpg" height=90 width=90 border=1>
		<br>
		��Ʒ���֣�<%=p.getName() %><br><br>
		��Ʒ���飺<%=p.getDescr() %><br><br>
		��Ա�۸�<%=p.getMemberPrice() %><br><br>
		ƽ���۸�<%=p.getNormalPrice() %><br><br>
		<a href="Buy.jsp?id=<%=id %>">����</a>
	</body>
</html>