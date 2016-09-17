<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.List" %> 
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
	out.println("您现在还没有登录，如果继续购买则按市场价，<a href=register.jsp>注册</a>是免费的<br>");
	//out.println("<a href=ConfromNormal.jsp>继续</a><br>");
	out.println("<a href=Login.jsp>登录</a>");
}
%>

<table border=1 align="center">
  <tr>
    <th>商品号</th>
    <td>商品名称</td>
    <td>商品价格<%if(u == null) {out.print("(市场价)");}else{out.print("(会员价)");}  %></td>
    <td>购买数量</td>
    <td></td>
  </tr>
  <%
  List<CartItem> items = cart.getItems();
  for(int i=0; i<items.size(); i++) {
  	CartItem ci = items.get(i);
  	Product p = ProductMgr.getInstance().loadById(ci.getProductId());
  %>
    <tr>
	    <th><%=ci.getProductId() %></th>
	    <td><%=p.getName() %></td>
	    <td><%=(u==null) ? p.getNormalPrice() : p.getMemberPrice() %></td>
	    <td>
	    	<%=ci.getCount() %>
		</td>
	    <td></td>
  	</tr>
  <%
  }
  %>
</table>

<center>
	共<%= Math.round(cart.getTotalPrice()*100)/100.0 %>元 <br>
	
	<%
	if(u != null) {
		%>
		欢迎<%=u.getUsername() %>，请确认您的送货地址<br>
		<%
//System.out.println(u.getAddr());
//System.out.println(u.getUsername());
//System.out.println(u.getPhone());
	}
	%>
	
	
<%
String addrr = "";
if(u == null) {
	addrr = "未登录用户";
} else {
	addrr = u.getAddr();
}
 %>
	<form action="Order.jsp" method="post">
	送货地址：<br>
	
	<textarea name="addr"><%=addrr %></textarea><br>
	<input type="submit" value="下单">
	</form>
</center>
