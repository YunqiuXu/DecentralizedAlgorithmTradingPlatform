<%@ page language="java" import="java.util.*, javax.servlet.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%
    // [Yunqiu Xu] Finished checking
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    class combo{
        String buyerAddrCookie = "";
        String sellerContractAddrCookie = "";
    }
    // Note: different from other pages, here "buyerAddrCookie" is not the user addr of admin user!
    String buyerAddrCookie = "";
    String sellerContractAddrCookie = "";
    ArrayList<combo> container = new ArrayList<combo>();
    try{
        MongoClient mongoClient3 = new MongoClient( "localhost" , 27017 );
        DB db3 = mongoClient3.getDB( "test" );
        DBCollection coll3 = db3.getCollection("address");
        DBCursor cursor3 = coll3.find();
        while (cursor3.hasNext()) {
            combo c = new combo();
            DBObject show3 = cursor3.next();
            Map show4 = show3.toMap();
            buyerAddrCookie = (String)show4.get("buyerAddrCookie");
            sellerContractAddrCookie = (String)show4.get("sellerContractAddrCookie");
            c.buyerAddrCookie = buyerAddrCookie;
            c.sellerContractAddrCookie = sellerContractAddrCookie;
            container.add(c);
        }
    }catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }
    String searchPattern = (String)request.getParameter("search"); // this is search pattern, if pattern == "", show all models

    System.out.println("Page shopping.jsp");
    String userNameCookie = "";
    String userAddrAdmin = "";
    String buyerContractAddrCookie = "";
    Cookie[] cookies = request.getCookies();
    for (int i = 0; i < cookies.length; i++) {
        if ("userNameCookie".equals(cookies[i].getName())) {
            userNameCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user name : " + userNameCookie);
        }
        if ("buyerAddrCookie".equals(cookies[i].getName())) {
            userAddrAdmin = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("user address : " + userAddrAdmin);
        }
        if ("buyerContractAddrCookie".equals(cookies[i].getName())) {
            buyerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("buyer contract address : " + buyerContractAddrCookie);
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>shopping</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Poppins:400,600" rel="stylesheet">
    <link rel="shortcut icon" href="assets/images/favicon.png" >
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/fontAwesome.css">
    <link rel="stylesheet" href="css/hero-slider.css">
    <link rel="stylesheet" href="css/owl-carousel.css">
    <link rel="stylesheet" href="css/tempo1.css">
    <link rel="stylesheet" href="css/lightbox.css">
    <link href="assets/css/theme.css" rel="stylesheet">
    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    <script src="js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="js/cartmain.js"></script> <!-- Resource jQuery -->
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" href="css/cartstyle.css">
</head>
<body class="">


<div class="header">
    <div class="container">
        <nav class="navbar navbar-inverse" role="navigation">
            <div class="navbar-header">
                <a class="navbar-brand"><em>M</em>UD</a>
            </div>
            <div id="main-nav" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a style="font-size: 16px;">Welcome <%=userNameCookie%></a></li>
                    <li><a style="font-size: 16px;" id="my_balance"></a></li>
                    <li><a style="font-size: 16px;" href="#" type="button" class="scroll-top">Switch</a></li>
                    <li><a style="font-size: 16px;" href="#" type="button" class="logout" data-id="logout">Logout</a></li>
                </ul>
            </div>
        </nav>
    </div>
</div>


<div class="parallax-content baner-content" id="home">
    <div class="container">
        <div class="text-content">
            <h2>Decentralized <span>Algorithm</span> Trading <em>Website</em></h2>
        </div>
    </div>
</div>


<section id="home-property-listing">
    <header class="section-header home-section-header text-center">
        <div class="container">
            <h2 class="wow slideInRight">Search result</h2>
            <a style="font-size: 18px;" type="button" href="buyermainpage.jsp">Go back</a>
        </div>
    </header>
    <div class="container">
        <div class="row" id="mapping_things" style="">
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-12">
                COMP9900 2018S1
            </div>
            <div class="col-md-4 col-sm-12">
                Playing with Mud
            </div>
        </div>
    </div>
</footer>


<a href="#top" id="scroll-top"><i class="fa fa-angle-up"></i></a>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.migrate.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="http://ditu.google.cn/maps/api/js?key=AIzaSyD2MtZynhsvwI2B40juK6SifR_OSyj4aBA&libraries=places"></script>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="SellerABI.js"></script>
<script language="javascript" type="text/javascript" src="BuyerABI.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.scroll-link').on('click', function(event){
            event.preventDefault();
            var t = $(window).scrollTop();
            $('body,html').animate({'scrollTop':t+900},1000)
        });
        viewAllModelsMultiSeller();
        // scroll to top action
        $('.scroll-top').on('click', function(event) {
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        // mobile nav toggle
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
        });
        $('.logout').on('click', function(event){
            event.preventDefault();
            window.location.href=("login.jsp");
        });
    });
    if (typeof console === "undefined") {
        console = {
            log: function() { }
        };
    }

    // add my balance
    if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    } else {
        web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
    }
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=userAddrAdmin%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");

    // Note that this is search result
    function viewAllModelsMultiSeller() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let SellerABI = web3.eth.contract(SellerABIContent);
        let BuyerABI = web3.eth.contract(BuyerABIContent);
        // get all sellers and their contracts
        var allSellers = [];
        <%for(int i=0;i<container.size();i++){%>
            allSellers.push("<%= container.get(i).buyerAddrCookie%>");
        <%}%>
        var allSellerContracts = [];
        <%for(int i=0;i<container.size();i++){%>
            allSellerContracts.push("<%= container.get(i).sellerContractAddrCookie%>");
        <%}%>
        // Check seller address and seller contract address
        console.log("All sellers address: " + allSellers);
        console.log("All seller contracts address: " + allSellerContracts);
        $("#mapping_things").empty();
        for (let j = 0; j < allSellers.length; j++){
            // Get access to this seller's contract
            web3.eth.defaultAccount = allSellers[j];
            console.log("Current seller : " + web3.eth.defaultAccount);
            let Seller_contract = SellerABI.at(allSellerContracts[j]);
            // Get model count in this seller's contract
            let modelCount = Seller_contract.getModelCount.call({from: web3.eth.defaultAccount});
            // Show all models of this seller
            for(let i = 0; i < modelCount; i++){
                try {
                    // get information
                    let result = Seller_contract.getModelByIndex.call(i, {from: web3.eth.defaultAccount});
                    let currentName = result[1].toLowerCase();
                    console.log("Current model name : " + currentName);
                    let searchPattern = "<%=searchPattern%>".toLowerCase();
                    // check whether I've bought this model
                    web3.eth.defaultAccount = "<%=userAddrAdmin%>";
                    console.log("Admin address : " + web3.eth.defaultAccount);
                    console.log("Admin buyer address : " + "<%=buyerContractAddrCookie%>");
                    let Buyer_contract = BuyerABI.at("<%=buyerContractAddrCookie%>");
                    let repeatResult = Buyer_contract.checkRepeat.call(result[3], {from: web3.eth.defaultAccount, gas: 30000000});
                    web3.eth.defaultAccount = allSellers[j];
                    console.log("Go back to seller : " + web3.eth.defaultAccount);
                    console.log("-----");
                    if (searchPattern == "") { // show all models
                        // check whether it's my own model
                        if (allSellers[j].toLowerCase() == "<%=userAddrAdmin%>".toLowerCase()) {
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px">' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#008CFD;font-size:16px;margin-left:190px">Model status : my own model</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr>'+
                                '</ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        else if (repeatResult){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px">' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#E67E22;font-size:16px;margin-left:190px">Model status : already bought</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr>'+
                                '</ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        else{
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Model status : available</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li><br>' +
                                '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " class="add_to_shopping_cart">Add to shopping cart</a>'+
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                    }
                    else if(currentName.match(searchPattern)){ // only show matched models
                        // check whether it's my own model
                        if (allSellers[j].toLowerCase() == "<%=userAddrAdmin%>".toLowerCase()) {
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px">' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#008CFD;font-size:16px;margin-left:190px">Model status : my own model</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr>'+
                                '</ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        else if (repeatResult){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px">' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#E67E22;font-size:16px;margin-left:190px">Model status : already bought</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr>'+
                                '</ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        else {
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Model status : available</h3>' + '<br><br><br>'+
                                '<li hidden class="seller_addr">' + result[0] + '</li>' + // seller address (hidden on html)
                                '<li hidden class="seller_contract_addr">' + allSellerContracts[j] + '</li>' + // seller contract address (hidden on html)
                                '<li hidden class="model_index">' + result[6] + '</li>' + // index (hidden on html)
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name</a> : ' + result[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description</a> : ' + result[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether)</a> : ' + web3.fromWei(result[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time</a> : ' + new Date(Number(result[5])) + '</li><br>' +
                                '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " class="add_to_shopping_cart">Add to shopping cart</a>'+
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                    }
                }
                catch (error){
                    console.log("Error : " + error);
                    break;
                }
            }
            console.log("=====");
        }
        // add to shopping cart
        $("body").on("click",".add_to_shopping_cart", function() {
            let sellerAddr = $(this).parent().find(".seller_addr").text();
            let sellerContractAddr = $(this).parent().find(".seller_contract_addr").text();
            let modelIndex = $(this).parent().find(".model_index").text();
            console.log("sellerAddr : " + sellerAddr);
            console.log("sellerContractAddr : " + sellerContractAddr);
            console.log("modelIndex : " + modelIndex);
            // send data to shopping_action.jsp --> store in DB
            $.ajax({
                url: 'shopping_action.jsp',
                type: 'POST',
                data: {sellerAddr:sellerAddr, sellerContractAddr:sellerContractAddr, modelIndex:modelIndex},
                success: function (data) {
                    console.log("Add to shopping cart successfully");
                    alert('succeed!');
                },
                error: function (returndata) {
                    console.log("Failed");
                    alert('failed!');
                }
            });
        });
    }
</script>

</body>
</html>


