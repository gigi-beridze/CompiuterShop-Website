<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null,st1=null;
        java.sql.ResultSet rs=null,rs1=null;
        String pid=request.getParameter("pid");
        String userid=request.getParameter("userid");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        rs = st.executeQuery("select name,descr from comcats where id="+pid);
        if(rs.next()){
            String name=rs.getString("name");
            String descr=rs.getString("descr");
            st.executeUpdate("update comcatsclient set name=N'"+name+"',descr=N'"+descr+"',itemid=0,price=0 where pid="+pid);
        }
%>


