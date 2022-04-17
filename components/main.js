var todo = 0;
//Start Menu Script//
(function($) { "use strict";
	$(function() {
		var header = $(".start-style");
		$(window).scroll(function() {    
			var scroll = $(window).scrollTop();
			if (scroll >= 10) {
			header.removeClass('start-style').addClass("scroll-on");
			} else {
			header.removeClass("scroll-on").addClass('start-style');
			}
		});
	});		
	//Animation
	$(document).ready(function() {
		$('body.hero-anime').removeClass('hero-anime');
	});
	//Menu On Hover	
	$('body').on('mouseenter mouseleave','.nav-item',function(e){
			if ($(window).width() > 750) {
				var _d=$(e.target).closest('.nav-item');_d.addClass('show');
				setTimeout(function(){
				_d[_d.is(':hover')?'addClass':'removeClass']('show');
				},1);
			}
	});	
	//Switch light/dark
	$("#switch").on('click', function () {
		if ($("body").hasClass("dark")) {
			$("body").removeClass("dark");
			$("#switch").removeClass("switched");
		}
		else {
			$("body").addClass("dark");
			$("#switch").addClass("switched");
		}
	});  
  })(jQuery); 
//End Menu Script//
//Start PC Build Script//
function assemble() {
    	xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
	var url='Comparts.jsp?userid='+userid;
	xht.onreadystatechange=assembleLoaded;
	xht.open('GET',url,true);
	xht.send(null);    
}
function assembleLoaded(){
	if (xht.readyState==4){
            assembledetails();
            $("#D0").removeClass('col-10').addClass('col-7');
            $("#D2").show();
	}
}
function assembledetails() {
    	xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
	var url='compartsdetails.jsp?userid='+userid;
	xht.onreadystatechange=cpdetailsLoaded;
	xht.open('GET',url,true);
	xht.send(null);    
}
function cpdetailsLoaded(){
	if (xht.readyState==4){
            var xd = xht.responseText.trim();
            var yd = xd.split('!!');
            $("#D1").html(yd[0]);
            $("#D1").show();
            $("#D2").html(yd[1]);
            $("#D2").show();
	}
}
function additem(A,B) {
    	xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
	var url='itemupdate.jsp?userid='+userid+'&pid='+B+'&itemid='+A;
	xht.onreadystatechange=addelementLoaded;
	xht.open('GET',url,true);
	xht.send(null);    
}
function addelementLoaded(){
	if (xht.readyState==4){
            $("#option").dialog("close");
            assembledetails();
	}
}
function manageoptions(A) {
    switch (A) {
        case 6: showproducts(); break;
    }
}
function showproducts() {
    	xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
	var url='getproducts.jsp';
	xht.onreadystatechange=getproductsLoaded;
	xht.open('GET',url,true);
	xht.send(null);
}
function getproductsLoaded(){
	if (xht.readyState==4){
            $("#D1").html(xht.responseText.trim());
            $("#D0").removeClass('col-7').addClass('col-10');
            $("#D2").hide();
            stable = $('#mtable').DataTable( {
         responsive: true, select: true, stateSave: true, pageLength:10, dom: 'f<"toolbar">pti'
            });
         $('#mtable tbody').on( 'click', 'tr', function () {
                stable.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
                selectedprodid = stable.cell('.selected',0).node().title;
            } );
            var T="<button onclick=additems(0) class='ml-3 mt-0 rounded' style='border:1px solid gray'><i class='fa fa-plus fa-lg'></i></button>";
            T+="<button onclick=additems(1) class='ml-3 mt-0 rounded' style='border:1px solid gray'><i class='fa fa-edit fa-lg'></i></button>";
            T+="<button onclick=deleteproducte() class='ml-3 mt-0 rounded' style='border:1px solid gray'><i class='fa fa-trash fa-lg'></i></button>";
            T+=$("div.toolbar").html(T);
            $("div.toolbar").css('float','left');
	}
}
//End Pc build script//
        function deleteproducte(A){
            	xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
		var url='delete01.jsp?id='+selectedprodid;
		xht.onreadystatechange=delete01Loaded;
		xht.open('GET',url,true);
		xht.send(null);
        }
        function delete01Loaded(){
            if (xht.readyState==4){
                showproducts();
            }
    	}
//Start Add Item script//
        function additems(A){
            todo=A;
            if(todo==1)A=selectedprodid;
            xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
            var url='addproduct.jsp?id='+A;
            xht.onreadystatechange=additemLoaded;
            xht.open('GET',url,true);
            xht.send(null);
        }
//End Add Item script//
        function saveitem(){
            selected=selectedprodid;
            if(todo==0)selected=0;
            xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
            var url='addproducts.jsp?'+encodeURIComponent('id='+selected+'&name='+$("#name").val()+'&cat='+$("#cat").val()+'&price='+$("#price").val()+'&manufacturer='+$("#manufacturer").val()+'&instock='+$("#instock").val());	
            xht.onreadystatechange=edititemLoaded;
            xht.open('GET',url,true);
            xht.send(null);
        }
        function edititemLoaded(){
            if(xht.readyState==4){
               $("#additem").dialog( "close" );     
               showproducts();
            }
        }
        function model(A){
                selectedmodelid=A;
                xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
		var url='model.jsp?id='+A;
		xht.onreadystatechange=modelLoaded;
		xht.open('GET',url,true);
		xht.send(null);
        }
        function modelLoaded(){
            if(xht.readyState==4){
               $("#D3").html(xht.responseText.trim());
            }
        }
        function addbasket(A){
                xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
		var url='addbascket.jsp?itemid='+A+'&UserID='+userid;
		xht.onreadystatechange=addbasketLoaded;
		xht.open('GET',url,true);
		xht.send(null);
        }
        function addbasketLoaded(){
            if(xht.readyState==4){
                window.location="";
            }
        }
        function showbasket(){
                xht=GetXmlHttpObject(); if(xht==null) { alert ('Browser does not support HTTP Request');  return; }
		var url='showbasket.jsp?userid='+userid;
		xht.onreadystatechange=showbasketLoaded;
		xht.open('GET',url,true);
		xht.send(null);
        }
        function showbasketLoaded(){
            if(xht.readyState==4){
                $("#D1").html(xht.responseText.trim());
            }
        }
        
