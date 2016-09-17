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

int pageNo = 1;
String strPageNo = request.getParameter("pageno");
if(strPageNo != null && !strPageNo.trim().equals("")) {
	pageNo = Integer.parseInt(strPageNo);
}

String strCategoryIdQuery = "";

	
//处理简单搜索2
	keyword = request.getParameter("keyword");
	String[] strCategoryIds = request.getParameterValues("categoryid");
	int[] idArray;
	if (strCategoryIds == null || strCategoryIds.length == 0) {
		idArray = null;
	} else {
		for(int i=0; i<strCategoryIds.length; i++) {
//System.out.println(strCategoryIds[i]);
			strCategoryIdQuery += "&categoryid=" + strCategoryIds[i];	 
	  	}
	  //	out.println(strCategoryIdQuery);
		idArray = new int[strCategoryIds.length];
		for(int i=0; i<strCategoryIds.length; i++) {
			idArray[i] = Integer.parseInt(strCategoryIds[i]);
			 
	  	} 
		//products = new ArrayList<Product>();
		//System.out.println(products);
		
		pageCount = ProductMgr.getInstance().findProducts(products, idArray, keyword, -1, -1, -1, -1, null, null, pageNo, 3);
	  }

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
		&keyword=<%=keyword %>&pageno=<%=pageNo+1%><%=strCategoryIdQuery%>">下一页</a>
	</center>
<!-- 显示处理结果结束 -->
