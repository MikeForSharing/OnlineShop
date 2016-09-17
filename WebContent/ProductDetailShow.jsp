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
		<title>添加商品类别</title>
	</head>
	<body>
	<center>产品展示</center>
		<img alt=<%=p.getName()%> src="admin/images/product/<%=p.getId() %>.jpg" height=90 width=90 border=1>
		<br>
		商品名字：<%=p.getName() %><br><br>
		商品详情：<%=p.getDescr() %><br><br>
		会员价格：<%=p.getMemberPrice() %><br><br>
		平常价格：<%=p.getNormalPrice() %><br><br>
		<a href="Buy.jsp?id=<%=id %>">购买</a>
	</body>
</html>