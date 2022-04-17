<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null, st1=null;
	java.sql.ResultSet rs=null, rs1=null;
        String idx=request.getParameter("id");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        st1 = con.createStatement();
        String name="";
        String cat="";
        String instock="";
        String price="";
        String manufacturer="";
        rs = st.executeQuery("select id,name,cat,instock,price,manufacturer from items where id="+idx);
        if(rs.next()){
            name=rs.getString("name");
            cat=rs.getString("cat");
            instock=rs.getString("instock");
            price=rs.getString("price");
            manufacturer=rs.getString("manufacturer");
        }
        String T="<table>";
            T+="<tr><td>დასახელება</td><td><input type='text' id=name value='"+name+"'</td></tr>";
            T+="<tr><td>კატეგორია</td><td><select id=cat>";
            rs = st.executeQuery("select id,name from comcats order by id");
            while(rs.next()){
                String idd=rs.getString("id");
                String name1=rs.getString("name");
                T+="<option value="+idd;
                if(idd.equals(cat)) T+=" selected";
                T+=">"+name1+"</option>";
            }
            T+="</select></td></tr>";
            T+="<tr><td>თანხა</td><td><input type='text' id=price value='"+price+"'</td></tr>";
            T+="<tr><td>მწარმოებელი</td><td><input type='text'id=manufacturer value='"+manufacturer+"'</td></tr>";
            T+="<tr><td>მარაგშია</td><td><input type='text' id=instock value='"+instock+"'</td></tr>";
        T+="</table>";
        out.print(T);
%>



