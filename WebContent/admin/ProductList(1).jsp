<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*, java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>


<%!
private static final int PAGE_SIZE = 3; 
%>


<%
String strPageNo = request.getParameter("pageno");
int pageNo = 1;
if(strPageNo != null) {
	try {
		pageNo = Integer.parseInt(strPageNo);
	
	} catch (NumberFormatException e) {
		e.printStackTrace();
	} 
} 

if(pageNo < 1) {
	pageNo = 1; 
}

%>


<%
List<Product> products = new ArrayList<Product>();
int pageCount  = ProductMgr.getInstance().getProducts(products, pageNo, PAGE_SIZE);

if(pageNo > pageCount) {
	pageNo = pageCount;
}
%>


<html>
<head>
<title>产品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
	<table border="1", align="center">
		<tr>
			<td>ID</td>
			<td>产品名称</td>
			<td>产品描述</td>
			<td>普通价格</td>
			<td>会员价格</td>
			<td>生产日期</td>
			<td>categoryID</td>
			<td>处理</td>
		</tr>
		<%
		for(Iterator<Product> it = products.iterator(); it.hasNext();) {
			Product p = it.next();
		%>
			<tr>
			<td><%=p.getId() %></td>
			<td><%=p.getName() %></td>
			<td><%=p.getDescr() %></td>
			<td><%=p.getNormalPrice() %></td>
			<td><%=p.getMemberPrice() %></td>
			<td><%=p.getPdate() %></td>
			<td><%=p.getCategory().getName() %></td>
			<td>
				<a href="ProductDelete.jsp?categoryid=<%=p.getCategoryID()%>" target="detail" >删除整类</a>
				&nbsp;
				<a href="ProductDelete.jsp?id=<%=p.getId()%>" target="detail" >删除单个</a>
				&nbsp;
				<a href="ProductModify.jsp?id=<%=p.getId()%>" target="detail" >修改</a>
				&nbsp;
				<a href="ProductImageUp.jsp?id=<%=p.getId()%>" target="detail" >上传图片</a>
			</td>
		</tr>
		
		<% 
		}
		%>
	</table>
	
	<center>
		第<%=pageNo %>页
		&nbsp;
		共<%=pageCount %>页
		&nbsp;
		<a href="ProductList.jsp?pageno=<%=pageNo-1 %>">上一页</a>
		&nbsp;
		<a href="ProductList.jsp?pageno=<%=pageNo+1 %>">下一页</a>
		&nbsp;
		
		<a href="ProductList.jsp?pageno=<%=pageCount %>">最后一页</a>
	</center>
</body>
</html>
