<%@ page language="java"  pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*" %>
<%@ page import="java.util.List" %> 
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
User u = (User)session.getAttribute("user");
if(u == null) {
	out.println("�����ڻ�û�е�¼����������������г��ۣ�<a href=register.jsp>ע��</a>����ѵ�<br>");
	//out.println("<a href=ConfromNormal.jsp>����</a><br>");
	out.println("<a href=Login.jsp>��¼</a>");
}
%>

<table border=1 align="center">
  <tr>
    <th>��Ʒ��</th>
    <td>��Ʒ����</td>
    <td>��Ʒ�۸�<%if(u == null) {out.print("(�г���)");}else{out.print("(��Ա��)");}  %></td>
    <td>��������</td>
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
	��<%= Math.round(cart.getTotalPrice()*100)/100.0 %>Ԫ <br>
	
	<%
	if(u != null) {
		%>
		��ӭ<%=u.getUsername() %>����ȷ�������ͻ���ַ<br>
		<%
//System.out.println(u.getAddr());
//System.out.println(u.getUsername());
//System.out.println(u.getPhone());
	}
	%>
	
	
<%
String addrr = "";
if(u == null) {
	addrr = "δ��¼�û�";
} else {
	addrr = u.getAddr();
}
 %>
	<form action="Order.jsp" method="post">
	�ͻ���ַ��<br>
	
	<textarea name="addr"><%=addrr %></textarea><br>
	<input type="submit" value="�µ�">
	</form>
</center>
