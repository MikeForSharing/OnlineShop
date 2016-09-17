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
List<SalesOrder> orders = new ArrayList<SalesOrder>();
int pageCount  = OrderMgr.getInstance().getOrders(orders, pageNo, PAGE_SIZE);

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
			<td>下单人姓名</td>
			<td>送货地址</td>
			<td>下单时间</td>
			<td>订单状态</td>
			<td>处理</td>
		</tr>
		<%
		for(Iterator<SalesOrder> it = orders.iterator(); it.hasNext();) {
			SalesOrder so = it.next();
		%>
			<tr>
			<td><%=so.getId() %></td>
			<td><%=so.getUser().getUsername()%></td>
			<td><%=so.getAddr()%></td>
			<td><%=so.getoDate() %></td>
			<td><%=so.getStatus()%></td>
			<td>
				
				<a href="OrderDetailShow.jsp?id=<%=so.getId()%>" target="detail" >订单明细</a>
				<a href="OrderModify.jsp?id=<%=so.getId()%>" target="detail" >订单状态修改</a>
				
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
		<a href="OrderList.jsp?pageno=<%=pageNo-1 %>">上一页</a>
		&nbsp;
		<a href="OrderList.jsp?pageno=<%=pageNo+1 %>">下一页</a>
		&nbsp;
		
		<a href="OrderList.jsp?pageno=<%=pageCount %>">最后一页</a>
	</center>
</body>
</html>
