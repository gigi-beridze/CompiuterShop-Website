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
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
try{
Class.forName("net.sourceforge.jtds.jdbc.Driver");
cox = java.sql.DriverManager.getConnection(url, id, pass);
}catch(ClassNotFoundException cnfex){  cnfex.printStackTrace(); }
try{
 	st = cox.createStatement();
	st.executeUpdate("insert into operators(username,password,name,email)values('"+username+"','"+password+"','"+name+"','"+email+"')");
	rs=st.executeQuery("select id from operators where username='"+username+"'");
	if(rs.next()) {
		String UserID=rs.getString("ID");
		session.setAttribute("UserID",UserID);
		session.setAttribute("Username",username);
	}	
	response.sendRedirect("?");

} catch(Exception e){e.printStackTrace();}
%>