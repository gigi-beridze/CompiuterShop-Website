<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null;
	java.sql.ResultSet rs=null;
        String itemid=request.getParameter("itemid");
        String userid=request.getParameter("UserID");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        rs = st.executeQuery("select id from checkout where itemid="+itemid+" and ClientID="+userid);
        if(rs.next()){
            st.executeUpdate("update checkout set amount=amount+1 where itemid="+itemid+" and ClientID="+userid);
        }else{
            st.executeUpdate("insert into checkout(amount,itemid,clientid) values (1,"+itemid+","+userid+")");
        }
%>


