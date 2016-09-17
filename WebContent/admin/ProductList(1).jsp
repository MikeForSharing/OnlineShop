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
<title>��Ʒ�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
	<table border="1", align="center">
		<tr>
			<td>ID</td>
			<td>��Ʒ����</td>
			<td>��Ʒ����</td>
			<td>��ͨ�۸�</td>
			<td>��Ա�۸�</td>
			<td>��������</td>
			<td>categoryID</td>
			<td>����</td>
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
				<a href="ProductDelete.jsp?categoryid=<%=p.getCategoryID()%>" target="detail" >ɾ������</a>
				&nbsp;
				<a href="ProductDelete.jsp?id=<%=p.getId()%>" target="detail" >ɾ������</a>
				&nbsp;
				<a href="ProductModify.jsp?id=<%=p.getId()%>" target="detail" >�޸�</a>
				&nbsp;
				<a href="ProductImageUp.jsp?id=<%=p.getId()%>" target="detail" >�ϴ�ͼƬ</a>
			</td>
		</tr>
		
		<% 
		}
		%>
	</table>
	
	<center>
		��<%=pageNo %>ҳ
		&nbsp;
		��<%=pageCount %>ҳ
		&nbsp;
		<a href="ProductList.jsp?pageno=<%=pageNo-1 %>">��һҳ</a>
		&nbsp;
		<a href="ProductList.jsp?pageno=<%=pageNo+1 %>">��һҳ</a>
		&nbsp;
		
		<a href="ProductList.jsp?pageno=<%=pageCount %>">���һҳ</a>
	</center>
</body>
</html>
