<%
	session.removeAttribute("Username"); 
	session.removeAttribute("UserID"); 
	response.sendRedirect("?");
%>
