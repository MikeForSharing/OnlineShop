<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%@ page import="java.sql.*, com.bjsxt.shopping.*, java.util.*" %>
<%@ include file="_SessionCheck.jsp" %>



<%
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id); 

String action = request.getParameter("action");
if(action != null && action.equals("modify")) {
	int status = Integer.parseInt(request.getParameter("status"));
	so.setStatus(status);
	so.updateStatus();
}
%>

<script type="text/javascript">
<!--
	window.parent.main.location.reload();
-->
</script>

<%
out.println("修改成功");
 %>



<center>
	<td>下单人姓名：</td><%=so.getUser().getUsername() %><br>
	<form name="form" action="OrderModify.jsp" method="post">
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=id%>">
		<select name="status">
			<option value="0">未处理</option>
			<option value="1">已处理</option>
			<option value="2">废单</option>
		</select>
		<br>
		<input type="submit" value="提交">
	</form>
</center>

<script type="text/javascript">
<!--
	for(var option in doucment.forms("form").status.options) {  //把单子的值与option的值做比较，一样就选中
		if(option.value = <%=so.getStatus()%>) {
			document.forms("form").status.selectedIndex = option.index;
		}
	}
-->
</script>


