<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="_SessionCheck.jsp" %>
 
<%
request.setCharacterEncoding("GB18030");
int id = Integer.parseInt(request.getParameter("id"));
//System.out.println(id);
Product p = ProductMgr.getInstance().loadById(id); 
String action = request.getParameter("action");
if(action != null && action.equals("modify")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice")); 
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	int categoryId = Integer.parseInt(request.getParameter("categoryid"));
	
	Category c = Category.loadById(categoryId);
	if(!c.isLeaf()) {
		out.println("��Ҷ�ӽڵ㲻���޸�");
		return;
	}
	
	p.setName(name);
	p.setDescr(descr);
	p.setNormalPrice(normalPrice);
	p.setMemberPrice(memberPrice);
	p.setCategoryID(categoryId);
	ProductMgr.getInstance().updateProduct(p);
%>
<script type="text/javascript">
<!--
	window.parent.main.location.reload();
-->
</script>

<%
	out.println("�޸ĳɹ�");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>

<script type="text/javascript">
	var arrLeaf = new Array();
	
	function checkdata() {
		if(arrLeaf[document.form.categoryid.selectedIndex] != 'leaf') {
			alert("����ѡ���Ҷ�ӽڵ�");
			document.form.categoryid.focus();
			return false;
		}
		return true;
	}

</script>
</head>
<body>
	<center>�޸Ĳ�Ʒ</center>
	<form action="ProductModify.jsp" method="post" onSubmit="return checkdata()" name="form">
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=id %>">

		<table>
			<tr>
				<td>��Ʒ����</td>
				<td><input type = "text" name="name" value="<%=p.getName()%>"></td>
			</tr>
			<tr>
				<td>��Ʒ����</td>
				<td><textarea name="descr"><%=p.getDescr() %></textarea></td>
			</tr>
			
			<tr>
				<td>�г���</td>
				<td><input type = "text" name="normalprice" value="<%=p.getNormalPrice()%>"></td>
			</tr>
			
			<tr>
				<td>��Ա��</td>
				<td><input type = "text" name="memberprice" value="<%=p.getMemberPrice()%>"></td>
			</tr>
			
			<tr>
				<td>�������</td>
				<td>
				<select name="categoryid">
					<option value="0">�������</option>
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
						<option value="<%=c.getId()%>" <%=c.getId() == p.getCategoryID() ? "selected" : "" %>><%=prestr + c.getName() %></option>
						<%
						index ++;
						} 
						%>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="�ύ">
			</tr>
			
		</table>
	</form>
</body>
</html>