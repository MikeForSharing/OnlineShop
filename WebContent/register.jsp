<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.bjsxt.shopping.*, java.sql.*" %>
    
<%
request.setCharacterEncoding("GB18030");
String action = request.getParameter("action");
if(action != null && action.equals("register")) {
	String username = request.getParameter("username");
	String password = request.getParameter("pwd");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	User u = new User();
	u.setAddr(addr);
	u.setRdate(new Timestamp(System.currentTimeMillis()));
	u.setPassword(password);
	u.setPhone(phone);
	u.setUsername(username);
	u.save();
	out.println("register successfully");
	//return;
	  
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>表单</title>


<script type="text/javascript">
	var req;
	function validate() {
		var idField = document.getElementById("userid");
	    var url = "Validate.jsp?id=" + idField.value;
	    url =  encodeURI(url);
        url =  encodeURI(url);
		//alert(url);
		if(window.XMLHttpRequest) {  //用于跨浏览器
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		req.open("GET", url, true);   //true表示为异步监视
		req.onreadystatechange = callback;  //
		req.send(null);    //真正把请求提交到服务器了
	    
	}
	
	function callback() {  //在callback里面接收服务器传过来的数据
		if(req.readyState == 4) {
			if(req.status == 200) {  //反馈正常
				var msg = req.responseXML.getElementsByTagName("msg")[0];
				//alert(msg.childNodes[0].nodeValue);
				setMsg(msg.childNodes[0].nodeValue);
			}
		}
	}
	
	function setMsg(msg) {
		//alert(msg);
		if(msg == "invalid") {
			document.getElementById("usermsg").innerHTML = "<font color='red'>用户名已存在，不可以注册</font>"
			setTimeout('window.location.reload()',1800);
			//window.location.reload();
		} else if(msg == "valid") {
			document.getElementById("usermsg").innerHTML = "<font color='green'>用户名不存在，可以注册</font>"
		}
	}
</script>


<script type="text/javascript" src="script/RegCheckData.js"></script>

</head>
<body> 
<form name="form" action="register.jsp" method="post" onSubmit="return checkdata()"> 
	<input type="hidden" name=action value=register> 
	<table width="750" align="center" border="0" cellspacing="2" cellpadding="0">
		<tr>
			<td bgcolor="#D2E9FF" colspan="2" align="center"><font size="6" color="#004B97"><b>用户注册</b></td>
		</tr>
		<tr>
			<td bgcolor="#D2E9FF">用户名：</td>    
			<td bgcolor="#D2E9FF">
				<input type=text name="username" id="userid" size="30" maxlength="10" onblur="validate()">
				<span id="usermsg"></span>
			</td>
		</tr>
		<tr>
			<td bgcolor="#D2E9FF">密码：</td>
			<td bgcolor="#D2E9FF">
				<input type=password name="pwd" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
			<td bgcolor="#D2E9FF">密码确认</td>
			<td bgcolor="#D2E9FF">
				<input type=password name="pwd2" size="15" maxlength="12">
			</td>
		</tr>
		
		<tr>
			<td bgcolor="#D2E9FF">电话</td>
			<td bgcolor="#D2E9FF">
				<input type="text" name="phone">
			</td>
		</tr>
		
		<tr>
			<td bgcolor="#D2E9FF">送货地址</td>
			<td bgcolor="#D2E9FF"><textarea rows="12" cols="80" name="addr"></textarea></td>
		</tr>
		
		<tr>
			<td bgcolor="#D2E9FF"></td>
			<td bgcolor="#D2E9FF">
				<input type="submit" value="提交">
				<input type="reset" value="重置">
			</td>
		</tr>
			
		</table>
	</form>
</body>
</html>