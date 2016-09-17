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

%>
<center>������һ�������Ʒ</center>
<form action="CartUpdate.jsp" method="post">
<table border=1 align="center">
  <tr>
    <th>��Ʒ��</th>
    <td>��Ʒ����</td>
    <td>��Ʒ�۸�</td>
    <td>��������</td>
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
	��<%= Math.round(cart.getTotalPrice()*100)/100.0 %>Ԫ <br>
	<input type="submit" value="�޸�����">
	<input type="button" value="ȷ�϶���" onclick="document.location.href='Confirm.jsp'">
</center>
</form>