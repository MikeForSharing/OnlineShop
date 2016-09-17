<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*, java.sql.*" %>
<%@ page import="java.util.*" %>



<%
List<Product> latestProducts = ProductMgr.getInstance().getLatestProducts(10);
List<Category> categories = Category.getCategories();
List<Category> topCategories = new ArrayList<Category>();

for(int i=0; i<categories.size(); i++) {
	Category c = categories.get(i);
	if(c.getGrade() == 1) {
		topCategories.add(c);
		//System.out.println(getSecondCategoryStr(categories, c));
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<%
User u = (User)session.getAttribute("user");
%>




<table border="1">
<tr><td>欢迎您：
<%=
u.getUsername()
%>
</td></tr>
<tr><td><a href="register.jsp">新用户注册</td></tr>
<tr><td><a href="SelfService.jsp">用户自服务</a></td></tr>
</table>



<script type="text/javascript">
	var req;
	function changeCategory() {
		var id = document.form1.category1.options[document.form1.category1.selectedIndex];
	    var url = "GetChildCategory.jsp?id=" + escape(id.value);
		if(window.XMLHttpRequest) {
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		req.open("GET", url, true);
		req.onreadystatechange = callback;
		req.send(null);
	}
	
	function callback() {
		if(req.readyState == 4) {
			if(req.status == 200) {
				//alert(req.responseText);
				//System.out.println(req.responseText);
				parse(req.responseText);				
			}
		}
	}
	
	function parse(msg) {
	
		if(msg == null || new String(msg) == "") {
			document.form1.category2.length = 1;
			document.form1.category2.selectedIndex = 0;
			document.form1.category2.options[0].text = "请选择二级目录";
			document.form1.category2.options[0].value = -1;
		}
		var categories = msg.split("-"); 
		
		document.form1.category2.length = categories.length + 1;
		document.form1.category2.selectedIndex = 0;
		document.form1.category2.options[0].text = "请选择二级目录";
		document.form1.category2.options[0].value = -1;
		for(var i=0; i<categories.length; i++) {
			var categorykv = categories[i].split(",");
			var id = categorykv[0];
			var name = categorykv[1];
			document.form1.category2.options[i+1].text = name;
			document.form1.category2.options[i+1].value = id;
		}
	}
</script>

<table>
<form name="form1" method="post">
<select name="category1" onchange="changeCategory()">
<option value=0 selected>查询一级目录</option>
<%
	for(int i=0; i<topCategories.size(); i++) {
		Category c = topCategories.get(i);
		%>
		<option value=<%=c.getId()%>><%=c.getName() %></option>
		<%
	}
%>
</select>

<select name="category2">
<option value=0 selected>查询二级目录</option>

</select>

</form>
</table>





<table width="99%" align=center border=1>
<tbody>
	<tr>
		<td valign=top height=10></td>
	</tr>
<tr>
<%
//从这里开始插入最新的商品
for(int i=0; i<latestProducts.size(); i++) {
	Product p = latestProducts.get(i);
%>

	<td>
	 <table height=137 width=110 align=center border=1>
	  <tbody>
	  <tr>
	    <td width=110 height=95>
	     <div align=center>
	      <table height=90 width=90 align=center bgColor=#e1e1e1 border=1 >
	       <tbody>
	       <tr>
	         <td align=middle width=90 bgColor=#ffffff height=90>
	          <a href="ProductDetailShow.jsp?id=<%=p.getId() %>">
	          <img alt=<%=p.getName()%> src="admin/images/product/<%=p.getId() %>.jpg" height=90 width=90 border=1>
	          </a>
	         </td>
	       </tr>
	       </tbody>
	      </table>
	     </div>
	    </td>
	  </tr>
	  <tr>
	   <td valign=center height=18>
	    <div align=center>
	     <a href="ProductDetailShow.jsp?id=<%=p.getId() %>"><%=p.getName()%>
	     </a>
	    </div>
	   </td>
	  </tr>
	  <tr>
	   <td valign=bottom height=13>
	    <table width="98%" border=1>
	     <tbody>
	     <tr>
	      <td height=18>
	       <div align=center>
	       <font>会员价：<%=p.getMemberPrice() %></font>
	       </div>      
	      </td>
	     </tr>
	     </tbody>
	    </table>
	   </td>
	  </tr>
	  </tbody>
	 </table>
	</td>
	   	<%
	if((i+1)%5 == 0) {
		out.println("</tr><tr>");
	}
	%>
<%
} 
//从这里结束插入最新的商品
%>
</tr></tbody></table>
</body>
</html>