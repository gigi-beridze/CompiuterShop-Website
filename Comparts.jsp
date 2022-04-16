<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null;
	java.sql.ResultSet rs=null;
        String userid=request.getParameter("userid");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        st.executeUpdate("delete from comcatsclient where userid="+userid);
        st.executeUpdate("insert into comcatsclient(pid,name,descr,amount,price,userid,ord,itemid) select id,name,descr,0,0,"+userid+",ord,0 from comcats order by ord");
%>
