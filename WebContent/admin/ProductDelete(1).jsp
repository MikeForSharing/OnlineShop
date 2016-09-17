<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>

<%@ include file="_SessionCheck.jsp" %>
<%
//TODO you should validate the id
int categoryid = 0;
int id = 0;
if(request.getParameter("id") == null ) {
	categoryid = Integer.parseInt(request.getParameter("categoryid"));
	ProductMgr.getInstance().deleteProductByCategoryId(categoryid);
} else {
	
	id = Integer.parseInt(request.getParameter("id"));
	ProductMgr.getInstance().deleteProductById(id);
	
}
	 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
	删除成功
	 
	<script language="javascript">
		<!--
		parent.main.reload();
		-->
	</script>
	
</body>
</html>