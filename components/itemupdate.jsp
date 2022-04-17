<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null;
	java.sql.ResultSet rs=null;
        String userid=request.getParameter("userid");
	String itemid=request.getParameter("itemid");
        String pid=request.getParameter("pid");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        String name="", descr="",price="";
        rs=st.executeQuery("select name,descr,price from items where id="+itemid);
        if(rs.next()){
            name=rs.getString("name");
            descr=rs.getString("descr");
            price=rs.getString("price");
        }
        out.print("update comcatsclient set name=N'"+name+"',descr=N'"+descr+"',price='"+price+"',itemid="+itemid+" where pid="+pid+" and userid="+userid);
        st.executeUpdate("update comcatsclient set name=N'"+name+"',descr=N'"+descr+"',price='"+price+"',itemid="+itemid+" where pid="+pid+" and userid="+userid);
%>

