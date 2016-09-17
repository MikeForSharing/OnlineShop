<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.bjsxt.shopping.*, java.sql.*, java.util.*"%>


<%
int id = Integer.parseInt(request.getParameter("id"));
//System.out.println(id);
Category parent = Category.loadById(id);
//System.out.println(parent.getId());
List<Product> childrenproduct = ProductMgr.getInstance().getChildrenProduct(parent);
//System.out.println(childrenproduct.size());
StringBuffer buf = new StringBuffer();
for(int i=0; i<childrenproduct.size(); i++) {
	Product p = childrenproduct.get(i);
//System.out.println(p.getId());
	buf.append(p.getId() + "," + p.getName() + "-");
}

if(childrenproduct.size() > 0) {
	buf.deleteCharAt(buf.length() - 1);
}
//System.out.println(buf);

response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-store");  //prevent http1.1
response.setHeader("Pragma", "no-cache");    //prevent http1.0
response.setDateHeader("Expires", 0);
response.getWriter().write(buf.toString());   //·ûºÏxml±ê×¼

%>