<%@ page language="java" import="java.util.*,com.mongodb.*,com.mongodb.MongoClient" pageEncoding="UTF-8"%>
<%
    // [Yunqiu Xu] finished checking
    // set basepath
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    // get all cookies
    Cookie[] cookies = request.getCookies();
    // get all information
    String buyerAddrCookie = "";
    String userNameCookie = "";
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";
    String freelancerContractDeployed = "";
    String clientContractDeployed = "";
    System.out.println("Page login_action.jsp");
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
    <title>login_action</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
</head>

<body>
<%
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");
    String userName=(String)request.getParameter("u");
    String passWord=(String)request.getParameter("p");
    boolean login_test = false;
    boolean new_user = false;

    String toname = "";
    String topassword = "";

    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        DB db = mongoClient.getDB( "test" );
        DBCollection coll = db.getCollection("address");
        DBCursor cursor = coll.find();
        while (cursor.hasNext()) {
            DBObject show = cursor.next();
            System.out.println(show);
            Map show1 = show.toMap();
            toname = (String)show1.get("name");
            topassword = (String)show1.get("password");
            // Generate cookie
            if(toname.equals(userName) && topassword.equals(passWord)){
                Cookie Addr1 = new Cookie("buyerAddrCookie", (String)show1.get("buyerAddrCookie"));
                Addr1.setMaxAge(60 * 60 * 24 * 1000);
                Cookie Addr2 = new Cookie("buyerContractAddrCookie", (String)show1.get("buyerContractAddrCookie"));
                Addr2.setMaxAge(60 * 60 * 24 * 1000);
                Cookie Addr3 = new Cookie("sellerContractAddrCookie", (String)show1.get("sellerContractAddrCookie"));
                Addr3.setMaxAge(60 * 60 * 24 * 1000);
                Cookie Addr4 = new Cookie("freelancerContractDeployed", (String)show1.get("freelancerContractDeployed"));
                Addr4.setMaxAge(60 * 60 * 24 * 1000);
                Cookie Addr5 = new Cookie("clientContractDeployed", (String)show1.get("clientContractDeployed"));
                Addr5.setMaxAge(60 * 60 * 24 * 1000);
                Cookie Addr6 = new Cookie("userNameCookie", (String)show1.get("name"));
                Addr6.setMaxAge(60 * 60 * 24 * 1000);
                Thread.sleep(1000);

                response.addCookie(Addr1);
                response.addCookie(Addr2);
                response.addCookie(Addr3);
                response.addCookie(Addr4);
                response.addCookie(Addr5);
                response.addCookie(Addr6);

                new_user = true;
                response.sendRedirect("start.jsp");
            }
        }
    }catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }

    // not a new user
    if (!new_user) {
        try {
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            DB db = mongoClient.getDB("test");
            DBCollection coll = db.getCollection("site");
            System.out.println("Collection userInfo selected successfully");
            DBCursor cursor = coll.find();
            int i = 1;
            while (cursor.hasNext()) {
                DBObject show = cursor.next();
                System.out.println("userInfo Document: " + i + "    " + show);
                Map show1 = show.toMap();
                toname = (String) show1.get("name");
                topassword = (String) show1.get("password");
                if (toname.equals(userName) && topassword.equals(passWord)) {
                    System.out.println("Log in successfully " + "username:" + toname + "  password:" + topassword);
                    login_test = true;
                }
                i++;
            }
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        if (login_test) {
            try {
                MongoClient mongoClient = new MongoClient("localhost", 27017);
                @SuppressWarnings("deprecation")
                DB db = mongoClient.getDB("test");
                DBCollection coll = db.getCollection("address");
                DBObject user = new BasicDBObject();
                user.put("name", toname);
                user.put("password", topassword);
                user.put("buyerAddrCookie", buyerAddrCookie.toLowerCase());
                user.put("buyerContractAddrCookie", buyerContractAddrCookie);
                user.put("sellerContractAddrCookie", sellerContractAddrCookie);
                user.put("freelancerContractDeployed", freelancerContractDeployed);
                user.put("clientContractDeployed", clientContractDeployed);
                System.out.println(buyerAddrCookie + "     " + buyerContractAddrCookie + "      " + sellerContractAddrCookie +  "      " +freelancerContractDeployed +  "      " +clientContractDeployed);
                System.out.println("Insert into DB successfully");
                coll.insert(user);
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
            response.sendRedirect("start.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
%>
</body>
</html>