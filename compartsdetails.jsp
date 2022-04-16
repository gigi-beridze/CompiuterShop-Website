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
	rs = st.executeQuery("select id,name,descr,amount,pid,itemid,cast(price as int) price from comcatsclient where userid="+userid+" order by ord");
        String T="<table class='w-100 p-5 mt-3'>";
        while(rs.next()){
            String Name=rs.getString("Name");
            String idx=rs.getString("id");
            String Description=rs.getString("descr");
            int amount=rs.getInt("amount");
            String pid=rs.getString("pid");
            String itemid=rs.getString("itemid");
            String price=rs.getString("price");
            if(!price.equals("0")) price="₾"+price; else price="";   
            String img="itemsimg/"+itemid+".jpg";
            if(itemid.equals("0")) {
                rs1 = st1.executeQuery("select img from comcats where id="+pid);
                if(rs1.next())  img= "images/"+rs1.getString("img")+".png";  
            }
            T+="<tr><td rowspan=3 valign=top align=left class='pr-5' style='padding:10px'><img style='width:150px' src="+img+"></td>";
            T+="<td class='HBPG' style='text-align:center;margin-bottom:20px;'><b>"+Name+"</b></td><td style='color:red;font-size:20px'>"+price+"</td></tr>";
            T+="<tr><td class='BPG'>"+Description+"<br></td><td></td></tr>";
   	    if(itemid.equals("0"))
                T+="<tr><td><button onclick=showlist("+pid+") class='p-1 rounded' style='border:1px solid gray';font-size: 14px;text-decoration: none;transition:all 2s ease 0s;outline:none!important;><i class='fas fa-plus p-1'></i>არჩევა</button><hr></td></tr>";
            else 
                T+="<tr><td><button onclick=showlist("+pid+") class='p-1 rounded' style='border:1px solid gray';font-size:14px;text-decoration: none;transition:all 2s ease 0s;outline:none!important;><i class='fas fa-retweet px-1'></i>შეცვლა</button><button onclick=deleteitems("+pid+") class='p-1 mr-1 rounded ml-2' style='border:1px solid gray';font-size:14px;text-decoration: none;transition:all 2s ease 0s;outline:none!important;><i class='fa fa-times px-1'></i>წაშლა</button><hr></td></tr>";  
        }
        T+="</table>";
        out.print(T);
        out.print("!!");
        String total="0";
        rs1 = st1.executeQuery("select cast(sum(price) as int) total from comcatsclient where userid="+userid);
        if(rs1.next())  total=rs1.getString("total");
        out.print("<span style='color:#0a756a;text-align:center;font-size:35px;'>სისტემის ფასი</span><br><span style='color:orange;font-size:30px;text-align: center'>₾</span><span style='color:gray;font-size:27px;'>"+total+"</span>");
%>
