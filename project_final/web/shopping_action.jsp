<%@ page language="java" import="java.util.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%
    // set basepath
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    // get all cookies
    Cookie[] cookies = request.getCookies();
    // get all address
    String buyerAddrCookie = "";
    String userNameCookie = "";
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";
    String freelancerContractDeployed = "";
    String clientContractDeployed = "";
    System.out.println("Page shopping_action.jsp");
    for (int i = 0; i < cookies.length; i++) {
        if ("buyerAddrCookie".equals(cookies[i].getName())) {
            buyerAddrCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user address : " + buyerAddrCookie);
        }
        if ("userNameCookie".equals(cookies[i].getName())) {
            userNameCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user name : " + userNameCookie);
        }
        if ("buyerContractAddrCookie".equals(cookies[i].getName())) {
            buyerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("buyer contract address : " + buyerContractAddrCookie);
        }
        if ("sellerContractAddrCookie".equals(cookies[i].getName())) {
            sellerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("seller contract address : " + sellerContractAddrCookie);
        }
        if ("freelancerContractDeployed".equals(cookies[i].getName())) {
            freelancerContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("freelancer contract address : " + freelancerContractDeployed);
        }
        if ("clientContractDeployed".equals(cookies[i].getName())) {
            clientContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("client contract address : " + clientContractDeployed);
        }
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>My JSP 'register_action.jsp' starting page</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta http-equiv="description" content="This is my page">
</head>

<body>
<%
    response.setContentType("text/html;charset=utf-8");
    // get infomation from request
    request.setCharacterEncoding("utf-8");
    // here only seller's address, seller contract's address and model's index
    String sellerAddr =(String)request.getParameter("sellerAddr");
    String sellerContractAddr =(String)request.getParameter("sellerContractAddr");
    String modelIndex =(String)request.getParameter("modelIndex");

    System.out.println("sellerAddr : " + sellerAddr);
    System.out.println("sellerContractAddr : " + sellerContractAddr);
    System.out.println("modelIndex : " + modelIndex);

    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        @SuppressWarnings("deprecation")
        DB db = mongoClient.getDB("test");
        DBCollection coll = db.getCollection("shopping");
        System.out.println("Collection userInfo selected successfully");
        DBObject user = new BasicDBObject();
        user.put("buyerMetaAddr", buyerAddrCookie);
        user.put("buyerContraAddr", buyerContractAddrCookie);
        user.put("sellerMetaAddr", sellerAddr);
        user.put("sellerContraAddr", sellerContractAddr);
        user.put("modelIndSeller", modelIndex);
        coll.insert(user);
        response.sendRedirect("shopping.jsp");
    }
    catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }
%>
</body>
</html>