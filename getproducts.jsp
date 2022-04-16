<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null, st1=null;
	java.sql.ResultSet rs=null, rs1=null;
        String idd=request.getParameter("id");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        st1 = con.createStatement();
	rs = st.executeQuery("select id,name,cat,descr,instock,price,manufacturer from items order by price");
        String T="<table id=mtable class='w-100'>";
        T+="<thead class='HBPG12'>";
        T+="<tr class='bg-primary' style='height:32px'><th >ID</th><th>დასახელება</th><th>კატეგორია</th><th>თანხა</th><th>მწარმოებელი</th><th>მარაგშია</th></tr>";
        T+="</thead>";
        T+="<tbody>";
        while(rs.next()){
            String name=rs.getString("name");
            String idx=rs.getString("id");
            String Description=rs.getString("descr");
            String instock=rs.getString("instock");
            String price=rs.getString("price");
            String cat=rs.getString("cat");
            String category="";
            rs1 = st1.executeQuery("select name from comcats where id="+cat);
            if(rs1.next()) category=rs1.getString("name");
            String manufacturer=rs.getString("manufacturer");
        T+="<tr style='cursor:pointer'><td title="+idx+">"+idx+"</td><td title='"+Description+"'>"+name+"</td><td align=center>"+category+"</td><td align=center>"+price+"</td><td align=center>"+manufacturer+"</td><td align=center>"+instock+"</td></tr>";
        }
        T+="</tbody>";
        T+="</table>";
        out.print(T);
%>


