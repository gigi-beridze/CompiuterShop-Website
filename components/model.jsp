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
        String T = "";
        if(idd.equals("0")){
            rs = st.executeQuery("select id,name,price,descr,img from Model order by id");
            while(rs.next()){
                String idx=rs.getString("id");
                String name=rs.getString("name");
                String price=rs.getString("price");
                String descr=rs.getString("descr");
                String img=rs.getString("img");
                String image="modelimage/"+img+".jpg";
                T+="<div class='float-left p-2'><table>";
                T+="<tr><td><img width=200 src="+image+"></td></tr>";
                T+="<tr><td style='font-size:16px;font-align:center;width:70px;color:gray;'>"+name+"</td></tr>";
                T+="<tr><td style='color:red;font-size:30px;text-align:center;'>₾"+price+"</td></tr>";
                T+="<tr><td align=center><button onclick=model("+idx+") class='p-1 mr-1 rounded ml-2' style='border:1px solid gray';font-size:14px;text-decoration: none;transition:all 2s ease 0s;outline:none!important;>დაწვრილებით</button></td></tr>";
                T+="</table></div>";
            }
        }else{
            rs = st.executeQuery("select id,name,price,descr,img from Model where id="+idd);
            if(rs.next()){
                String idx=rs.getString("id");
                String name=rs.getString("name");
                String price=rs.getString("price");
                String descr=rs.getString("descr");
                String img=rs.getString("img");
                String image="modelimage/"+img+".jpg";
                T+="<div class='float-left p-2'><table>";
                    T+="<tr><td width=50% valign=top ><img style='border:5px double #cccccc' width=300 src="+image+"><br>"+descr+"</td>";  
                    T+="<td width=50% valign=top><table><tr><td><span style='font-size:20px;margin-left:30px;font-align:center;width:500px;text-transform: none;text-color:black;font-weight:300px;'>"+name+"</span></td></tr>";
                    T+="<tr><td><span style='color:red;font-size:30px;margin:30px;'>₾"+price+"</span></td></tr>";
                    T+="<tr><td><i class='fas fa-award' style='color:#4c75a3;font-size:32px;margin-left:30px'><span style='margin:3px;font-size:20px;color:gray;'>მოქმედებს 1 წლიანი გარანტია საუკეთესო პირობებით</span></i></td></tr>";
                    T+="<tr><td><i class='fas fa-calendar-alt' style='color:#4c75a3;font-size:32px;margin-left:30px'><span style='margin:3px;font-size:20px;color:gray;'> შეგიძლიათ ისარგებლოთ განვადებით</span></i></td></tr>";
                    T+="<tr><td align=left'><button onclick=addbasket("+idx+") class='p-1 mr-1 rounded ml-2 m-5' style='border:1px solid gray';font-size:14px;text-decoration:none;transition:all 2s ease 0s;outline:none!important;><i class='fas fa-shopping-cart'>კალათაში დამატება</i></button></td></tr>";
                    T+="</table></td>";
                T+="</table></div>";
            }
        }
        out.print(T);
%>



