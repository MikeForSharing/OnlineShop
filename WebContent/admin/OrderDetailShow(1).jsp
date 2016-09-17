<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*, java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>



<%
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id); 
%>

<script type="text/javascript">

	function showProductInfo(descr) {
		document.getElementById("productInfo").innerHTML="<font size=3 color=red>" + descr + "</font>";
	}

</script>



<center>
	<td>下单人姓名：</td><%=so.getUser().getUsername() %><br>
	明细：<br>
	<table border=1 align="center">
	  <tr>
	    <td>商品名称</td>
	    <td>商品价格</td>
	    <td>购买数量</td>
	    <td></td>
	  </tr>
	  <%
	  List<SalesItem> items = so.getItems();
	  for(int i=0; i<items.size(); i++) {
	  	SalesItem si = items.get(i);
	  %>
	    <tr>
		    <td onmouseover="showProductInfo('<%=si.getProduct().getDescr()%>')"><%=si.getProduct().getName() %></td>
		    <td><%=si.getUnitPrice() %></td> 
		    <td><%=si.getCount() %></td>
		    <td></td>
	  	</tr>
	  <%
	  }
	  %>
	</table>



<div style="margin-top: 30pt;">商品细节描述</div>
<div style="border:5px double purple;width:400;" id="productInfo"></div>

</center>




