<%@ page language="java" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@include file="pass.jsp" %>
<%@ page import="javax.sql.*" %>
<%
    String IP=request.getRemoteAddr();
    String UserID="0";
    String Username="";
    String Access="0";
    UserID=(String) session.getAttribute("UserID");  if(UserID==null) UserID="0";
    Username=(String) session.getAttribute("Username");  if(Username==null) Username="unknown";
    Access=(String) session.getAttribute("Access");  if(Access==null) Access="0";	
java.sql.Connection cox=null;
java.sql.Statement st=null;
java.sql.ResultSet rs=null;
java.sql.Statement st1=null;
java.sql.ResultSet rs1=null;
    try{
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		cox = java.sql.DriverManager.getConnection(url, id, pass);
		} catch(ClassNotFoundException cnfex){  cnfex.printStackTrace(); }
		st = cox.createStatement();
		st1 = cox.createStatement();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script src="main.js?v=6"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<link rel="stylesheet" href="css/datatables.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/bpg-mrgvlovani-caps.min.css"/>
        <link rel="stylesheet" href="css/bpg-nostalgia.min.css">
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
        <script src="js/datatables.min.js"></script>
        <link rel="stylesheet" href="my/login.css?v=1"/>
        <link rel="stylesheet" href="my/index.css?v=1"/>
        <!---<link rel="stylesheet" href="my/search.css"/>
        <link rel="stylesheet" href="my/mainmenu.css"/>
        <link rel="stylesheet" href="my/reg.css"/>
        --->
<style>  
    .ui-widget-content.ui-dialog{
        border:1px solid white;
    }
    .ui-button-icon{
        font-size: 24px;
        color: #0a756a;
    }
    .ui-dialog-titlebar{
        background-color:white;
        border:1px solid white;
    }            
    .login-page{
        background-color: white;
    }
    .ui-dialog-title{
        background-color: white;
        color:black;
        font-size: 22px;
    }
    .ui-button{
        color:gray;
        background-color:white;
    }
</style>
    <script>
    var selectedmodelid=0;
    var xht;
    var idx=0;
    var selectedprodid=0;
    <% out.print("var userid="+UserID+";"); %>
	function GetXmlHttpObject() {
		if (window.XMLHttpRequest)  {  return new XMLHttpRequest();  }
		if (window.ActiveXObject)   {  return new ActiveXObject('Microsoft.XMLHTTP');  }
		return null;
	}
	function avtorizacia(){
			$("#avto").dialog({  resizable: false,height: "auto",width: 400,
      			buttons: {
			"ავტორიზაცია": function(){
                                $("#authform").submit();
				},
       			გამოსვლა: function() {
         			$( this ).dialog( "close" );
       		}
     	}
   	});
	}
	function checkregister(){
		var login=$('#loginid').val();
		var password=$('#passid').val();
		var password1=$('#passid1').val();
		var name=$('#nameid').val();
		var email=$('#emailid').val();
		var  error="";
		if(login.length<3) error+="<li style='font-size:15px;font-style: italic;margin:3px;'>სახელის სიგრზე უნდა იყოს მინიმუმ 3!</li>";
		if(password.length<6) error+="<li style='font-size:15px;font-style: italic;margin:3px;'>პაროლის სიგრძე უნდა იყოს მინიმუმ 6!</li>";
		if(password1!=password) error+="<li style='font-size:15px;font-style: italic;margin:3px;'>პაროლი არ ემთხვევა</li>";
		if(name.length<5) error+="<li style='font-size:15px;font-style: italic;margin:3px;'>მოკლე სახელი და გვარია!</li>";
		$('#errorid').html("<ul class='mt-2'>"+error+"</ul>");
		if(error.length==0){		
			xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
			var url='checkregister.jsp?username='+login+'&email='+email;
			xht.onreadystatechange=checkregisterLoaded;
			xht.open('GET',url,true);
			xht.send(null);
		}
	}
	function checkregisterLoaded(){
		if (xht.readyState==4){
			var xd = xht.responseText.trim();
			if(xd=="OK") {
				$("#reg").dialog( "close");
				$('#regform').submit();	
			} else {
				$('#errorid').html("<ul class='mt-2'>"+xd+"</ul>");
			}
		}
	}
	function register(){
	$("#reg").dialog({  resizable: false,height: "auto",width:"auto",
            buttons: {
			"რეგისტრაცია": function() {
				checkregister();
				},
              		"გამოსვლა": function() {
             			$( this ).dialog( "close" );   }
                     }                    
   	});
	}    
        function showlist(A){
            xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
            var url='option.jsp?id='+A;
            xht.onreadystatechange=optionLoaded;
            xht.open('GET',url,true);
            xht.send(null);
        }
        function optionLoaded(){
            if (xht.readyState==4){
                $("#option").dialog({  resizable: false,height: "600",width:"800",             
                });
                $("#option").html(xht.responseText.trim());
            }
        }
        function deleteitems(A){
            xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
            var url='deleteitem.jsp?pid='+A;
            xht.onreadystatechange=itemdeleteLoaded;
            xht.open('GET',url,true);
            xht.send(null);
        }
        function itemdeleteLoaded(){
            if (xht.readyState==4){
                assembledetails();
                
            }
        }
                function additemLoaded(){
            if (xht.readyState==4){
                $("#additem").dialog({  resizable:false,height:"400",width:"400", 
                     buttons: {
			"შენახვა": function() {
				saveitem();
				},
              		"გამოსვლა": function() {
             			$( this ).dialog( "close" );   }
                     }      
                });
                $("#additem").html(xht.responseText.trim());
            }
        }
    </script>
    </head>
    <body onload=model(0)>
    <%
	String[] acc = Access.split(",");
	out.print("<div style='background-color:navy; height:40px; color:white; line-height:40px;'>");
   	rs = st.executeQuery("select id,namege name from menu where pid=0 order by id");
	while(rs.next()){
		String idd=rs.getString("id");
		String name=rs.getString("name");
		out.print("<div class='dropdown float-left px-2' style='background-color:navy !important'>");
		out.print("<button  class='btn dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' style='float:left; color:white;'>"+name+"</button>");
		out.print("<div class='dropdown-menu'>");
		rs1 = st1.executeQuery("select id,namege name from menu where pid="+idd+" order by id");
		while(rs1.next()){
			String idx=rs1.getString("id");
			String nam=rs1.getString("name");
			String dis="disabled";
			for(int i=0; i<acc.length; i++) if(idx.equals(acc[i])) { dis=""; break; }
                            out.print("<div class='dropdown-item "+dis+"'>"+nam+"</div>");
		}
		out.print("</div>");
		out.print("</div>");	
	}
	if(UserID.equals("0")){
	out.print("<a class='btn btn-primary float-right mr-2'  onclick=avtorizacia() href=# role=button>ავტორიზაცია</a>");
	out.print("<a class='btn btn-primary float-right mr-2'  onclick=register() href=# role=button>რეგისტრაცია</a>");
	}else{
                String camount="0";
                rs = st.executeQuery("select count(1) cnt from checkout where clientid="+UserID);
                if(rs.next())camount=rs.getString("cnt");
         	out.print("<a class='btn btn-secondary  float-right mr-2 ml-4'   href=logout.jsp role=button>გასვლა</a>");
                out.print("<i style='color:#fff; margin-top:10px;' class='far fa-user float-right'>&nbsp;"+Username+"</i>");
                out.print("<a class='btn btn-primary float-right mr-2'  role=button onclick=assemble()>კომპიუტერის აწყობა</a>");
                out.print("<span onclick=showbasket() class='mx-2 HBPG12w' style='cursor:pointer'><i class='fas fa-shopping-cart'></i>&nbsp;"+camount+"</span>");
        }
        out.print("</div></div>");
    %>
        <div class='row justify-content-left w-100'>
            <div class='col-2' style='background-color:#aac'>
<%    
    String options="";
        options+="<div class=panel-group id=accordion>";
	String in="in";
	rs = st.executeQuery("select id,NameGE menu from menu where pid=0");
	while(rs.next()) {
		String menu=rs.getString("menu");
		String idx=rs.getString("id");
		boolean active=false;
		options+="<div class='panel panel-default'>";
		options+="                    <div class=panel-heading>";
		options+="                        <h6 class=panel-title>";
		options+="                            <a data-toggle=collapse data-parent=#accordion href=#collapse"+idx+">";
		options+="			    <span class='glyphicon glyphicon-chevron-down pull-right'> </span>"+menu+"</a>";
		options+="                        </h6>";
		options+="                    </div>";
		options+="<div id=collapse"+idx+" class='panel-collapse collapse "+in+"'>";	//
		options+="<div class=panel-body>";
		options+="<table class=table>";
		in="";
		rs1 = st1.executeQuery("select id,icon,NameGE menu from menu where pid="+idx);
		while(rs1.next()) {
			//out.print(icon);
			String sid=rs1.getString("id");
			String submenu=rs1.getString("menu");
                        options+="<tr><td onclick=manageoptions("+sid+") style='cursor:pointer'>"+submenu+"</td></tr>";
		}
                options+="</table>";
                options+="</div>";
                options+="</div>";
                options+="</div>";
	}
         options+="</div>";
    out.print(options);
%>
        </div>
        <div id='D0' class='col-7'>
            <div id='D1' class='w-100'></div>
            <div id="D3" class="w-100"></div>
        </div>
            <div id='D2' align=center class='col-3' style='margin-top: 50px'></div>
        </div>
        <!-------------Start Main Menu----------------->	
	<!----------<div class="navigation-wrap bg-light start-header start-style">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="navbar navbar-expand-md navbar-light">
					
						<a class="navbar-brand" href="https://front.codes/" target="_blank"><img src="https://assets.codepen.io/1462889/fcy.png" alt=""></a>	
						<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav ml-auto py-4 py-md-0">
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4 active">
									<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Home</a>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="#">Action</a>
										<a class="dropdown-item" href="#">Another action</a>
										<a class="dropdown-item" href="#">Something else here</a>
										<a class="dropdown-item" href="#">Another action</a>
									</div>
								</li>
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4">
									<a class="nav-link" href="#">Portfolio</a>
								</li>
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4">
									<a class="nav-link" href="#">Agency</a>
								</li>
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4">
									<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Services</a>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="#">Action</a>
										<a class="dropdown-item" href="#">Another action</a>
										<a class="dropdown-item" href="#">Something else here</a>
										<a class="dropdown-item" href="#">Another action</a>
									</div>
								</li>
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4">
									<a class="nav-link" href="#">Journal</a>
								</li>
								<li class="nav-item pl-4 pl-md-0 ml-0 ml-md-4">
									<a class="nav-link" href="#">Contact</a>
								</li>
							</ul>
						</div>
					</nav>		
				</div>
			</div>
		</div>
	</div>
	<div class="section full-height">
		<div class="absolute-center">
			<div class="section">
				<div class="container">
					<div class="row">
						<div class="col-12">
						</div>	
					</div>		
				</div>		
			</div>
			<div class="section mt-5">
				<div class="container">
					<div class="row">
						<div class="col-12">
						</div>	
					</div>		
				</div>			
			</div>
		</div>
	</div>
	<div class="my-5 py-5">
	</div>
        <!------------END Main Menu-------------->
<!------------Start Register/Login----->
<div id="avto" title="ავტორიზაცია" style="display: none;">
    <table width='100%'>
        <div class="login-page">
            <div class="form">
                <form  action=login.jsp method=post id=authform class="login-form"/>
                    <input placeholder='სახელი' type='text' name='login'/>
                    <input placeholder='პაროლი' type='password' name='password'/>
                    <p class="message">არ ხართ რეგისტრირებული? <a href="#">რეგისტრაცის გავლა</a></p>
                </form>
            </div>
        </div>    
    </table>
</div>
<div id="reg" title="რეგისტრაცია" style="display: none;">
    <table width='100%'><form action=Register.jsp  id=regform method=post>
	<div class="login-page">
            <div class="form">
                <form class="register-form">
                    <input type="text" placeholder="სახელი" name=username id='loginid'/>
                    <input type="password" placeholder="პაროლი" name=password id='passid'/>
                    <input type="password" placeholder="გაიმეორეთ პაროლი" id='passid1'/>
                    <input type="text" placeholder="სახელი გვარი" name=name id='nameid'/>
                    <input type="text" placeholder="ელფოსტა" name=email id='emailid'/>
                    <p class="message">უკვე გაქვთ ექაუნთი? <a href="">ავტორიზაცის გავლა</a></p>
                </form>
            </div>
		<tr><td colspan=2  id=errorid class="mt-5"></td></tr>
    </form></table>
</div>
<!------------End Register/Login----->
<div id="option" title="აირჩიეთ სასურველი ნივთი" style="display: none;background-color:#F8F8FF"></div>
<div id="additem" title="დამატეთ ახალი ნივთი" style="display: none;background-color:#F8F8FF"></div>

    </body>
</html>