<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
//���session���Ƿ���cart
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
ci.setPrice(p.getNormalPrice()); //��Ҫ����û��Ƿ��½������
ci.setProductId(id);
cart.add(ci);

response.sendRedirect("Cart.jsp");
%>

