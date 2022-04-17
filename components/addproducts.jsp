<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.net.URLDecoder" %>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null, st1=null;
	java.sql.ResultSet rs=null, rs1=null;
        request.setCharacterEncoding("UTF8");
        String[] par=URLDecoder.decode(request.getQueryString(), "UTF-8").split("&",-1);
        String idx=par[0].trim().split("=",-1)[1];
        String name=par[1].trim().split("=",-1)[1];
        String cat=par[2].trim().split("=",-1)[1];	
        String price=par[3].trim().split("=",-1)[1];
        String manufacturer=par[4].trim().split("=",-1)[1];
        String instock=par[5].trim().split("=",-1)[1];
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        if(idx.equals("0")) st.executeUpdate("insert into items (name,cat,price,manufacturer,instock) values (N'"+name+"',"+cat+",'"+price+"','"+manufacturer+"',"+instock+")");
        else st.executeUpdate("update items set name=N'"+name+"',cat=N'"+cat+"',instock=N'"+instock+"',price=N'"+price+"',manufacturer=N'"+manufacturer+"' where id="+idx);

%>



