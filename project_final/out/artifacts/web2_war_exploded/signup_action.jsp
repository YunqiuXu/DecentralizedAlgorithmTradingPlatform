<%@ page language="java" import="java.util.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%
    // [Yunqiu Xu] Finished checking
    // check the cookie
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    System.out.println("Page signup_action.jsp");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>sign up action</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta http-equiv="description" content="This is my page">
</head>

<body>
<%
    // Table : username - psw
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");
    String userName1=(String)request.getParameter("u");
    String passWord1=(String)request.getParameter("p");
    String passWord2=(String)request.getParameter("rep");
    String address = (String)request.getParameter("addr");

    System.out.println("-----");
    System.out.println("Username : " + userName1 + "     Password : " + passWord1 + "      UserAddr : " + address);

    if(!passWord1.equals(passWord2)){
        response.sendRedirect("index.jsp");
    }
    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        @SuppressWarnings("deprecation")
        DB db = mongoClient.getDB( "test" );
        DBCollection coll = db.getCollection("site");
        System.out.println("Collection userInfo selected successfully");
        DBObject user = new BasicDBObject();
        user.put("name", userName1);
        user.put("password", passWord1);
        coll.insert(user);
    }
    catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }
%>

</body>
</html>
<script type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="Buyer_submit_sol_Buyer_abi.js"></script>
<script language="javascript" type="text/javascript" src="Buyer_submit_sol_Buyer_bin.js"></script>
<script language="javascript" type="text/javascript" src="Seller_submit_sol_Seller_abi.js"></script>
<script language="javascript" type="text/javascript" src="Seller_submit_sol_Seller_bin.js"></script>
<script language="javascript" type="text/javascript" src="./Client_submit_sol_Client_abi.js"></script>
<script language="javascript" type="text/javascript" src="./Client_submit_sol_Client_bin.js"></script>
<script language="javascript" type="text/javascript" src="./Freelancer_submit_sol_Freelancer_abi.js"></script>
<script language="javascript" type="text/javascript" src="./Freelancer_submit_sol_Freelancer_bin.js"></script>

<script type="text/javascript">
    // Get user address
    let userAddr = "<%=address%>";
    console.log("User's address : " + userAddr);
    // Connect to web3
    if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    } else {
        web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
    }
    // Insert ABIs
    let SellerABI = JSON.parse(Seller_abi_content_generation);
    let BuyerABI = JSON.parse(Buyer_abi_content_generation);
    let ClientABI = JSON.parse(Client_abi_content_generation);
    let FreelancerABI = JSON.parse(Freelancer_abi_content_generation);
    // Insert BINs
    let byteCodeHead = '0x';
    let SellerByteCode = byteCodeHead + Seller_bin_content_generation;
    let BuyerByteCode = byteCodeHead + Buyer_bin_content_generation;
    let ClientByteCode = byteCodeHead + Client_bin_content_generation;
    let FreelancerByteCode = byteCodeHead + Freelancer_bin_content_generation;
    // Set flags
    var already1 = false;
    var already2 = false;
    var already3 = false;
    var already4 = false;
    // build seller contract
    let sellerContract = web3.eth.contract(SellerABI, null, {
        from: userAddr,
        gas: 3000000,
        data: SellerByteCode
    });
    // deploy seller contract
    sellerContract.new({
        from: userAddr,
        gas: 3000000,
        data: SellerByteCode
    }, function(error, newSellerInstance){
        if(!error){
            if(typeof(newSellerInstance.address) != "undefined") {
                already2 = true;
                addCookie("sellerContractAddrCookie",newSellerInstance.address,1000);
                if (already1 && already2 && already3 && already4){
                    window.location.href=("index.jsp");
                }
                console.log("Seller contract : " + newSellerInstance.address);
            }
        }
    });

    // build buyer contract
    let buyerContract = web3.eth.contract(BuyerABI, null, {
        from: userAddr,
        gas: 3000000,
        data: BuyerByteCode
    });
    // deploy buyer contract
    buyerContract.new({
        from: userAddr,
        gas: 3000000,
        data: BuyerByteCode
    }, function(error, newBuyerInstance){
        if(!error){
            if(typeof(newBuyerInstance.address) != "undefined") {
                addCookie("buyerContractAddrCookie",newBuyerInstance.address,1000);
                already1 = true;
                console.log("Buyer contract : " + newBuyerInstance.address);
                if (already1 && already2 && already3 && already4){
                    window.location.href=("index.jsp");
                }
            }
        }
    });

    // build client contract
    let clientContract = web3.eth.contract(ClientABI, null, {
        from: userAddr,
        gas: 3000000,
        data: ClientByteCode
    });
    // deploy client contract
    clientContract.new({
        from: userAddr,
        gas: 3000000,
        data: ClientByteCode
    }, function(error, newClientInstance){
        if(!error){
            if(typeof(newClientInstance.address) != "undefined") {
                addCookie("clientContractDeployed",newClientInstance.address,1000);
                already3 = true;
                console.log("Client contract : " + newClientInstance.address);
                if (already1 && already2 && already3 && already4){
                    window.location.href=("index.jsp");
                }
            }
        }
    });

    // build freelancer contract
    let freelancerContract = web3.eth.contract(FreelancerABI, null, {
        from: userAddr,
        gas: 3000000,
        data: FreelancerByteCode
    });
    // deploy freelancer contract
    freelancerContract.new({
        from: userAddr,
        gas: 3000000,
        data: FreelancerByteCode
    }, function(error, newFreelancerInstance){
        if(!error){
            if(typeof(newFreelancerInstance.address) != "undefined") {
                addCookie("freelancerContractDeployed",newFreelancerInstance.address,1000);
                already4 = true;
                console.log("Freelancer contract : " + newFreelancerInstance.address);
                if (already1 && already2 && already3 && already4){
                    window.location.href=("index.jsp");
                }
            }
        }
    });

    // Add cookie
    function addCookie(objName,objValue,objHours){
        let str = objName + "=" + escape(objValue);
        if(objHours > 0){
            var date = new Date();
            var ms = objHours*3600*1000;
            date.setTime(date.getTime() + ms);
            str += "; expires=" + date.toGMTString();
        }
        str += "; path=/;";
        document.cookie = str;
    }
    // Add cookie: user address
    addCookie("buyerAddrCookie",userAddr,1000);
    // Add cookie: user name
    addCookie("userNameCookie", "<%=userName1%>", 1000);

</script>
