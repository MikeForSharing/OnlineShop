<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="_SessionCheck.jsp" %>






<% 
request.setCharacterEncoding("GBK");
String action = request.getParameter("action");
//List<Category> categories = Category.getCategories();
List<Product> products = new ArrayList<Product>();
int pageCount = 0;
String keyword = null;
double lowNormalPrice = -1;
double highNormalPrice = -1;
double lowMemberPrice = -1;
double highMemberPrice = -1;
int categoryId = 0;
int pageNo = 1;
String strPageNo = request.getParameter("pageno");
if(strPageNo != null && !strPageNo.trim().equals("")) {
	pageNo = Integer.parseInt(strPageNo);
}
Timestamp startDate = null;
Timestamp endDate = null;
String strStartDate = null;
String strEndDate = null;
//int[] idArray; 

	
keyword = request.getParameter("keyword");
lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
categoryId = Integer.parseInt(request.getParameter("categoryid"));
int[] idArray; 
if(categoryId == 0) {
	idArray = null;
} else {
	idArray = new int[1]; 
	idArray[0] = categoryId;
}

strStartDate = request.getParameter("startdate");
if(strStartDate == null || strStartDate.trim().equals("")) {
	startDate = null;
} else {
	startDate = Timestamp.valueOf(request.getParameter("startdate"));
}

strEndDate = request.getParameter("enddate");
if(strEndDate == null || strEndDate.trim().equals("")) {
	endDate = null;
} else {
	endDate = Timestamp.valueOf(request.getParameter("enddate"));
}

//products = new ArrayList<Product>();
pageCount = ProductMgr.getInstance().findProducts(products, 
				idArray, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate,
					 pageNo, 3);
%>




<!-- 显示处理结果开始 -->
<center>搜索结果</center>
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
			<td><%=p.getCategoryID() %></td>
			<td>
				<a href="ProductDelete.jsp?categoryid=<%=p.getCategoryID()%>" target="detail" >删除整类</a>
				&nbsp;
				<a href="ProductDelete.jsp?id=<%=p.getId()%>" target="detail" >删除单个</a>
				&nbsp;
				<a href="ProductModify.jsp?id=<%=p.getId()%>" target="detail" >修改</a>
			</td>
		</tr>
		
		<% 
		}
		%>
	</table>
	<center>
	共<%=pageCount %>页
	&nbsp;
	
		<a href="ProductSearch.jsp?action=<%=action%>
		&keyword=<%=keyword %>&lownormalprice=<%=lowNormalPrice %>
		&highnormalprice=<%=highNormalPrice %>&lowmemberprice=<%=lowMemberPrice %>
		&highmemberprice=<%=highMemberPrice %>&startdate=<%=strStartDate %>&categoryid=<%=categoryId %>&enddate=<%=strEndDate %>
		&pageno=<%=pageNo+1 %>">下一页</a>
	</center>
<!-- 显示处理结果结束 -->
