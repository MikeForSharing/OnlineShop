<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*"  %>
    
<%
User u = (User)session.getAttribute("user");
if(u == null) {
	out.println("�㻹û�е�½");
	return;
}
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<a href="UserModify.jsp">�޸ĸ�����Ϣ</a>
</body>
</html>