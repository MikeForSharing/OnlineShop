<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="_SessionCheck.jsp" %>


<%
request.setCharacterEncoding("GB18030");
String action = request.getParameter("action");

String strCategoryId = request.getParameter("categoryid");
int categoryId = 0;
if(strCategoryId != null && !strCategoryId.trim().equals("")) {
	categoryId = Integer.parseInt(strCategoryId);
}

if(action != null && action.equals("add")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	
	Category c = Category.loadById(categoryId);
	if(!c.isLeaf()) {
		out.println("不能再非叶子节点下添加商品");
		return;
	}
	
	
	Product p = new Product(); 
	p.setId(-1);
	p.setCategoryID(categoryId);
	p.setDescr(descr);
	p.setMemberPrice(memberPrice);
	p.setName(name); 
	p.setNormalPrice(normalPrice);
	p.setPdate(new Timestamp(System.currentTimeMillis()));
	
	ProductMgr.getInstance().addProduct(p);
	out.println("产品添加成功");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<html>
	<head>
		<title>添加商品类别</title>
		<script type="text/javascript">
		var arrLeaf = new Array();
		
		function checkdata() {
			if(arrLeaf[document.form.categoryid.selectedIndex] != 'leaf') {
				alert("不能选择非叶子节点");
				document.form.categoryid.focus();
				return false;
			}
			return true;
		}
		
		</script>
	</head>
	<body>
	<center>添加根类别</center>
	<form action="ProductAdd.jsp" method="post" onsubmit="checkdata()" name="form">
		<input type="hidden" name="action" value="add">

		<table>
			<tr>
				<td>产品名称</td>
				<td><input type = "text" name="name"></td>
			</tr>
			<tr>
				<td>产品描述</td>
				<td><textarea name="descr" rows="8" cols="40"></textarea></td>
			</tr>
			
			<tr>
				<td>市场价</td>
				<td><input type = "text" name="normalprice"></td>
			</tr>
			
			<tr>
				<td>会员价</td>
				<td><input type = "text" name="memberprice"></td>
			</tr>
			
			<tr>
				<td>所有类别</td>
				<td>
				<select name="categoryid">
					<option value="0">所有类别</option>
						<script type="text/javascript">
							arrleaf[0] = "noleaf";
						</script>
						<%
						List<Category> categories = Category.getCategories();
						int index = 1;
						for(Iterator<Category> it = categories.iterator(); it.hasNext();) {
							Category c = it.next();
							String prestr = "";
							for(int i=1; i<c.getGrade(); i++) {
								prestr += "---";
							}
						%>
						<script type="text/javascript">
							arrLeaf[<%=index%>] = '<%=c.isLeaf() ? "leaf" : "notleaf" %>';
						</script>
						<option value="<%=c.getId()%>" <%=c.getId() == categoryId ? "selected" : "" %>><%=prestr + c.getName() %></option>
						<%
						index ++;
						} 
						%>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="提交">
			</tr>
			
		</table>
	</form>

	</body>
</html>