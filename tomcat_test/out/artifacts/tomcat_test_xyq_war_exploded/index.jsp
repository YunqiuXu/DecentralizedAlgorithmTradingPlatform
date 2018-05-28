<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
  <title>Simple test</title>
</head>
<body>

<%!
  private int initVar=0;
  private int serviceVar=0;
  private int destroyVar=0;
%>

<%!
  public void jspInit(){
    initVar++;
  }
  public void jspDestroy(){
    destroyVar++;
  }
%>

<%
  serviceVar++;

  String content1="Num1 : "+initVar;
  String content2="Num2 : "+serviceVar;
  String content3="NUm3 : "+destroyVar;
%>
<h1>Hi JSP</h1>
<p><%=content1 %></p>
<p><%=content2 %></p>
<p><%=content3 %></p>

<h3>For example</h3>
<%! int fontSize; %>
<%for ( fontSize = 1; fontSize <= 8; fontSize++){ %>
<font color="green" size="<%= fontSize %>">
  This is Yunqiu
</font><br />
<%}%>


</body>
</html>
