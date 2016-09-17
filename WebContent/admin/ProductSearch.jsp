<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="_SessionCheck.jsp" %>


<% 
List<Category> categories = Category.getCategories();
request.setCharacterEncoding("GB18030");
String action = request.getParameter("action");


if(action != null && action.equals("complexsearch")) {
	%>
	<jsp:forward page="ComplexSearchResult.jsp"></jsp:forward>
	<%
}

if(action != null && action.equals("simplesearch2")) {
%>
	<<jsp:forward page="SimpleSearch2Result.jsp"></jsp:forward> 
<%
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<html>
	<head>
		<title>添加商品类别</title>
		
<script type="text/javascript">        //如何在myeclipse中引入和运用JavaScript
		function checkdata() {
			with(document.complex["complex"]) {
				if(lownormalprice.value == null || lownormalprice.value == "") {
					lownormalprice.vlaue = -1;
				}
				
				if(highnormalprice.value == null || highnormalprice.value == "") {
					highnormalprice.vlaue = -1;
				}
				
				if(lowmemberprice.value == null || lowmemberprice.value == "") {
					lowmemberprice.vlaue = -1;
				}
				
				if(highmemberprice.value == null || highmemberprice.value == "") {
					highmemberprice.vlaue = -1;
				}
			}
		}
	
</script>
	</head>
	<body>
	
	
	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   	
	
	
<%--	 <center>简单搜索</center>--%>
<%--	<form action="ProductSearch.jsp" method="post">--%>
<%--		<input type="hidden" name="action" value="simplesearch">--%>
<%--		类别：<select></select>--%>
<%--		关键字：<input type="text" name="name">--%>
<%--		<input type="submit" value="搜索">--%>
<%--	</form>--%>
	
	<center>简单搜索</center>
	<form action="ProductSearch.jsp" method="post">
		<input type="hidden" name="action" value="simplesearch2">
		类别：<br>
			<%
			for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
				Category c = it.next();	
						
				if(c.isLeaf()) { 
				%>
					<input type = "checkbox" name="categoryid" value="<%=c.getId()%>"> <%=c.getName() %>  <br>
				<%
				} else {
				%>
					<%=c.getName() %><br>
				<%
				
				}
			}
			
			%>
		关键字：<input type="text" name="name">
		<input type="submit" value="搜索">
	</form>

	
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
	  
	
	<center>复杂搜索</center>
	<form action="ProductSearch.jsp" method="post" onsubmit="checkdata()" name="complex">
		<input type="hidden" name="action" value="complexsearch">
		<table>
			<tr>   
				<td>category</td>
				<td>	
					<select name="categoryid">
					<option value="0">所有类别</option>
						<%
						for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
							Category c = it.next();
							String prestr = "";
							for(int i=1; i<c.getGrade(); i++) {
								prestr += "---";
							}
							%>
							<option value="<%=c.getId()%>"><%=prestr + c.getName() %></option>
							<%
						}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>关键字</td>
				<td><input type="text" name="keyword"></td>
			</tr>
			
			<tr>
				<td>市场价</td>
				<td>
				From:<input type = "text" name="lownormalprice">
				To:<input type = "text" name="highnormalprice">
				</td>
			</tr>
			
			<tr>
				<td>会员价</td>
				<td>
				From:<input type = "text" name="lowmemberprice">
				To:<input type = "text" name="highmemberprice">
				</td>
			</tr>
			
			<tr>
				<td>日期</td>
				<td>
				From:<input type = "text" name="startdate">
				To:<input type = "text" name="enddate">
				</td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="搜索">
			</tr>
			
		</table>
	</form>

	</body>
</html>