<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>

<%@ include file="_SessionCheck.jsp" %>


<%
request.setCharacterEncoding("GB18030");
String strPid = request.getParameter("pid");
int pid = 0;
if(strPid != null) {
	pid = Integer.parseInt(strPid);
}
String action = request.getParameter("action");
if(action != null && action.equals("add")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	if(pid == 0) {
		Category.addTopCategory(name, descr);
	} else {
		//Category.addChildCategory(pid, name, descr);
		Category parent = Category.loadById(pid);
		Category child = new Category();
		//child.setId(-1);
		child.setName(name); 
		child.setDescr(descr);
		parent.addChild(child);
	}
	out.println("��Ʒ�����ӳɹ�");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  
<html>
	<head>
		<title>�����Ʒ���</title>
	</head>
	<body>
	<center>��Ӹ����</center>
	<form action="CategoryAdd.jsp" method="post">
<%--	ȷ�����ύ�����Ļ������ӹ�����--%>
		<input type="hidden" name="action" value="add">  
		<input type="hidden" name="pid" value="<%=pid %>">
		<table>
			<tr>
				<td>�������</td>
				<td><input type = "text" name="name"></td>
			</tr>
			<tr>
				<td>�������</td>
				<td><textarea name="descr" rows="8" cols="40"></textarea></td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="�ύ">
			</tr>
		</table>
	</form>

	</body>
</html>