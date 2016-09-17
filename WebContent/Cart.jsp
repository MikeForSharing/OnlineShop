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

%>
<center>这是您一共买的商品</center>
<form action="CartUpdate.jsp" method="post">
<table border=1 align="center">
  <tr>
    <th>商品号</th>
    <td>商品名称</td>
    <td>商品价格</td>
    <td>购买数量</td>
    <td></td>
  </tr>
  <%
  List<CartItem> items = cart.getItems();
  for(int i=0; i<items.size(); i++) {
  	CartItem ci = items.get(i);
  %>
    <tr>
	    <th><%=ci.getProductId() %></th>
	    <td><%=ProductMgr.getInstance().loadById(ci.getProductId()).getName() %></td>
	    <td><%=ci.getPrice() %></td>
	    <td>
	    	<input type="text" size=1 name=<%="p" + ci.getProductId() %> value="<%=ci.getCount() %>">
		</td>
	    <td></td>
  	</tr>
  <%
  }
  %>
</table>

<center>
	共<%= Math.round(cart.getTotalPrice()*100)/100.0 %>元 <br>
	<input type="submit" value="修改数量">
	<input type="button" value="确认订单" onclick="document.location.href='Confirm.jsp'">
</center>
</form>