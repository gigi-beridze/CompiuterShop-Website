<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="javax.sql.*"%>
<%@ include file="pass.jsp"%>
<%
	java.sql.Connection con=null;
	java.sql.Statement st=null,st1=null;
	java.sql.ResultSet rs=null,rs1=null;
        String userid=request.getParameter("userid");
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con = java.sql.DriverManager.getConnection(url,id,pass);
	st = con.createStatement();
        st1 = con.createStatement();
        rs = st.executeQuery("select itemid,amount from checkout where clientid="+userid);
        String T = "";
        T+="<table>";
        while(rs.next()){
            String itemid=rs.getString("itemid");
            String amount=rs.getString("amount");
            rs1 = st1.executeQuery("select name,price,descr,img from Model where id="+itemid);
            if(rs1.next()){
                String name=rs1.getString("name");
                String price=rs1.getString("price");
                String descr=rs1.getString("descr");
                String img=rs1.getString("img");
                String image="modelimage/"+img+".jpg";
                T+="<tr><td width=80% ><img style='width:100px' src="+image+"></td><td width=20% >რაოდენობა<input style='width=50px !important' value="+amount+" type='number'></td></tr>";
                T+="<tr><td colspan=2><span style='color:black;font-size:16px;'>"+name+"</span></td></tr>";
                T+="<tr><td colspan=2><span style='color:gray;font-size:12px;'>"+descr+"</span></td></tr>";
                T+="<tr><td colspan=2><span style='color:red;font-size:12px;'>₾"+price+"</span></td></tr>";
            }
        }
        T+="</table><hr>";
        out.print(T);
%>




