 <%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.bjsxt.shopping.*, java.sql.*" %>


<%
response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-store");  //prevent http1.1
response.setHeader("Pragma", "no-cache");    //prevent http1.0
response.setDateHeader("Expires", 0);


String id = request.getParameter("id");
id = java.net.URLDecoder.decode(id,"utf-8");
//username=new String(username.getBytes("iso-8859-1"));
//System.out.println(id);

boolean b = false;
b = User.userExists(id);        

if(b) {
	response.getWriter().write("<msg>invalid</msg>");   //符合xml标准
} else {
	response.getWriter().write("<msg>valid</msg>");
}

%>