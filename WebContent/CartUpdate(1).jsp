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
if(cart == null) {
	System.out.println("���ﳵ��û����Ʒ");
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
<center>�޸ĳɹ�</center>
������֮���ض���

<script type="text/javascript">
<!--
	function go() {
		document.location.href="Cart.jsp";
	}
	setTimeout(go, 3000);
//-->
</script>


