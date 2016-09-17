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
if(cart == null) {
	System.out.println("购物车中没有商品");
	return;
}

List<CartItem> items = cart.getItems();
for(int i=0; i<items.size(); i++) {
	CartItem ci = items.get(i);
	String strCount = request.getParameter("p" + ci.getProductId());
	if(strCount != null && !strCount.trim().equals("")) {
		ci.setCount(Integer.parseInt(strCount));
	}
}
%>
<center>修改成功</center>
三秒钟之后重定向

<script type="text/javascript">
<!--
	function go() {
		document.location.href="Cart.jsp";
	}
	setTimeout(go, 3000);
//-->
</script>


