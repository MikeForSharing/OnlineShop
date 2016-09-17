<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
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
request.setCharacterEncoding("GB18030");
int id = Integer.parseInt(request.getParameter("id"));
CartItem ci = new CartItem();
Product p = ProductMgr.getInstance().loadById(id);
ci.setCount(1);
ci.setPrice(p.getNormalPrice()); //需要检查用户是否登陆进来了
ci.setProductId(id);
cart.add(ci);

response.sendRedirect("Cart.jsp");
%>

