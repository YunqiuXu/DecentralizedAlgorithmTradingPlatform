<%@ page language="java" import="java.util.*,com.mongodb.*,com.mongodb.MongoClient,java.io.*" pageEncoding="UTF-8"%>
<%
    // [Yunqiu Xu] finished checking
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
    System.out.println("Page submitModel.jsp");
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


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    <title>submit model</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/demo.css" rel="external nofollow" >
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/fontAwesome.css">
    <link rel="stylesheet" href="css/hero-slider.css">
    <link rel="stylesheet" href="css/owl-carousel.css">
    <link rel="stylesheet" href="css/templatemo-style.css">
    <link rel="stylesheet" href="css/lightbox.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
</head>

<%
    response.setContentType("text/html;charset=utf-8");
    // get information from request
    request.setCharacterEncoding("utf-8");
    // here only seller's address, seller contract's address and model's index
    String freelancerRequestIndex =(String)request.getParameter("freelancerRequestIndex");
    String clientAddr =(String)request.getParameter("clientAddr");
    String clientContAddr =(String)request.getParameter("clientContAddr");
    String clientRequestIndex =(String)request.getParameter("clientRequestIndex");

    System.out.println("freelancerRequestIndex : " + freelancerRequestIndex);
    System.out.println("clientAddr : " + clientAddr);
    System.out.println("clientContAddr : " + clientContAddr);
    System.out.println("clientRequestIndex : " + clientRequestIndex);

    // Set root path
    String serverName = request.getServerName();
    String realPath = request.getRealPath(serverName);
    realPath = realPath.substring(0,realPath.lastIndexOf("/"));
    // Set parameter path
    String modelPath0 = freelancerContractDeployed + "/model_" + freelancerRequestIndex + ".py";
    String modelPath = realPath + "/upload/" + modelPath0;
    String testcodePath = realPath + "/upload/" + clientContAddr + "/testcode_" + clientRequestIndex + ".py";
    String run1Path = realPath + "/OJ_test/run_oj_part1.py";
    String run2Path = realPath + "/OJ_test/run_oj_part2.py";
    String resultPath = realPath + "/OJ_test/result.txt";

    // Part 1: run 'run_oj_part1.py' to write information in 'run_oj_part2.py'
    String[] args1 = new String[] { "python", run1Path, modelPath, testcodePath, run2Path};
    Process pr1 = Runtime.getRuntime().exec(args1);

    // Part 2: run 'run_oj_part2.py' to get result, then write result into resultPath
    String[] args2 = new String[] { "python", run2Path, resultPath};
    Process pr2 = Runtime.getRuntime().exec(args2);
    // Print test result
    BufferedReader in = new BufferedReader(new InputStreamReader(pr2.getInputStream()));
    String line;
    while ((line = in.readLine()) != null) {
        System.out.println("Test result : " + line);
    }
    in.close();
    pr2.waitFor();
    // Part 3: delete run2Path
    File file = new File(run2Path);
    if(file.delete()){
        System.out.println("Delete run2path successful!");
    }
    else{
        System.out.println("Delete run2path failed!");
    }
%>
<body>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="ClientABI.js"></script>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
</body>