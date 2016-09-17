<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    
<%@ page import="com.bjsxt.shopping.*"  %>
    
<%
User u = (User)session.getAttribute("user");
if(u == null) {
	out.println("你还没有登陆");
	return;
}
%>
 
<%
request.setCharacterEncoding("GB18030");
String action = request.getParameter("action");
if(action != null && action.equals("modify")) {
	String username = request.getParameter("username");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	u.setAddr(addr);
	u.setPhone(phone);
	u.setUsername(username);
	u.update();             
	out.println("修改成功");
	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<form name="form" action="UserModify.jsp" method="post">
	<input type="hidden" name=action value=modify>
	<table width="750" align="center" border="2">
		<tr>
			<td colspan="2" align="center">用户修改</td>
		</tr>
		<tr>
			<td>用户名</td>
			<td>
				<input type=text name="username" id="userid" size="30" maxlength="10" value=<%=u.getUsername()%>>
				<div id=usermsg></div>
			</td>
		</tr>
		<!--
		<tr>
			<td>密码：</td>
			<td>
				<input type=password name="password" size="15" maxlength="12">
			</td>
		</tr>
		  -->
		
		<tr>
			<td>电话</td>
			<td>
				<input type="text" name="phone" value=<%=u.getPhone()%>>
			</td>
		</tr>
		
		<tr>
			<td>送货地址</td>
			<td><textarea rows="12" cols="80" name="addr"><%=u.getAddr()%></textarea></td>
		</tr>
		
		<tr>
			<td></td>
			<td>
				<input type="submit" value="提交">
				<input type="reset" value="重置">
			</td>
		</tr>
			
		</table>
	</form>
</body>
</html>