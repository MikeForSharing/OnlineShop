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
out.println("�޸ĳɹ�");
 %>



<center>
	<td>�µ���������</td><%=so.getUser().getUsername() %><br>
	<form name="form" action="OrderModify.jsp" method="post">
		<input type="hidden" name="action" value="modify">
		<input type="hidden" name="id" value="<%=id%>">
		<select name="status">
			<option value="0">δ����</option>
			<option value="1">�Ѵ���</option>
			<option value="2">�ϵ�</option>
		</select>
		<br>
		<input type="submit" value="�ύ">
	</form>
</center>

<script type="text/javascript">
<!--
	for(var option in doucment.forms("form").status.options) {  //�ѵ��ӵ�ֵ��option��ֵ���Ƚϣ�һ����ѡ��
		if(option.value = <%=so.getStatus()%>) {
			document.forms("form").status.selectedIndex = option.index;
		}
	}
-->
</script>


