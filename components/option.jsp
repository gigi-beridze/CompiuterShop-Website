<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null;
	java.sql.ResultSet rs=null;
        String idd=request.getParameter("id");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
	rs = st.executeQuery("select id,name,cat,descr,instock,price from items where cat="+idd+" order by price");
        String T="<table class='w-75 p-5 mt-3'>";
        while(rs.next()){
            String name=rs.getString("Name");
            String idx=rs.getString("id");
            String Description=rs.getString("descr");
            String instock=rs.getString("instock");
            String price=rs.getString("price");
            String img="itemsimg/"+idx+".jpg";
            T+="<tr><td valign=top align=left class='pr-5' style='padding:20px'><img style='width:130px' src="+img+"></td>";
            T+="<td style='text-align:center;color:gray;font-family:'BPG Nostalgia',sans-serif'><b><span style='color:black;font-family:'BPG Mrgvlovani Caps',sans-serif;'>"+name+"</span></b><br><br><span style='font-family:'BPG Nostalgia',sans-serif;'>"+Description+"</span></td>";
            T+="<td><span style='color:red;text-align:center;display:block;margin-left:100%;font-size:20px;'>₾"+price+"</span><br><br><button onclick=additem("+idx+","+idd+") class='p-1 rounded' style='border:1px solid gray;margin-left:100%;background-color: #ffb200; letter-spacing: 2px;color: #fff;display: block;transition: all .5s ease-in-out;margin-top:-30px;'>დამატება</button></td></tr>";
        }
        T+="</table>";
        out.print(T);
%>

