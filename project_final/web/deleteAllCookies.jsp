<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Collect cookie</title>
</head>
<body>
<%
   Cookie cookie = null;
   Cookie[] cookies = null;
   // get all cookies
   cookies = request.getCookies();
   if( cookies != null ){
      out.println("<h2> Collect cookies</h2>");
      for (int i = 0; i < cookies.length; i++){
         cookie = cookies[i];
         if((cookie.getName( )).compareTo("name") == 0 ){
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            out.print("Delete cookie: " + 
            cookie.getName( ) + "<br/>");
         }
         out.print("Parameter name : " + cookie.getName());
         out.print("<br>");
         out.print("Parameter value : " + URLDecoder.decode(cookie.getValue(), "utf-8") +" <br>");
         out.print("------------------------------------<br>");
      }
  }else{
      out.println("<h2>No cookie</h2>");
  }
%>
</body>
</html>
