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
	String OK="OK";
 	st = cox.createStatement();
	rs=st.executeQuery("select id from operators where username='"+username+"'");
	if(rs.next()) {
		OK="ასეთი მომხმარებელი უკვე არსებობს!";
	}
	rs=st.executeQuery("select id from operators where email='"+email+"'");
	if(rs.next()) {
		OK="ასეთი ელფოსტა უკვე არსებობს!";
	}	
	out.print(OK);
} catch(Exception e){e.printStackTrace();}
%>