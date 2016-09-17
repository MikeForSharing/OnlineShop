<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.sql.*" %>


<%
//检查session中是否有cart
Cart cart = (Cart)session.getAttribute("cart");
if(cart == null) {
	cart = new Cart();
	session.setAttribute("cart", cart);
}
%>



<%
User u = (User)session.getAttribute("user");
if(u == null) {
	u = new User();
	u.setId(-1);
}
%>

<%
if(cart == null) {
	System.out.println("购物车中没有商品");
	return;
}
%>

<%
String addr = (String)request.getParameter("addr");

//System.out.println(addr);

SalesOrder so = new SalesOrder();
so.setCart(cart);
so.setAddr(addr);
so.setUser(u);
so.setoDate(new Timestamp(System.currentTimeMillis()));
//System.out.println(new Timestamp(System.currentTimeMillis()));
so.setStatus(0);
//System.out.println(so.getAddr());


so.save();
//OrderMgr.getInstance().saveOrder(so);


//System.out.println(so.getAddr());
//System.out.println(so.getUser().getUsername());

//session.removeAttribute("cart");
%>


<center>
购物成功！
</center>

