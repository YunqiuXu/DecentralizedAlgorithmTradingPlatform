<%@ page language="java" import="java.util.*,com.mongodb.*" pageEncoding="UTF-8"%>
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
    System.out.println("Page shopping_cart.jsp");
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
<%
    class info
    {
        String sellerMetaAddr;
        String sellerContraAddr;
        String modelIndSeller;
    }

    ArrayList<info> result = new ArrayList<info>();
    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        DB db = mongoClient.getDB( "test" );
        DBCollection coll = db.getCollection("shopping");
        System.out.println("Collection userInfo selected successfully");
        DBCursor cursor = coll.find();

        int i=1;
        while (cursor.hasNext()) {
            info in = new info();
            System.out.println("userInfo Document: "+i);
            DBObject show = cursor.next();
            System.out.println(show);
            Map show1 = show.toMap();
            String buyerMetaAddr = (String)show1.get("buyerMetaAddr");
            if(buyerMetaAddr.equals(buyerAddrCookie)){
                String sellerMetaAddr = (String)show1.get("sellerMetaAddr");
                String sellerContraAddr = "";
                try{
                    MongoClient mongoClient3 = new MongoClient( "localhost" , 27017 );
                    DB db3 = mongoClient3.getDB( "test" );
                    DBCollection coll3 = db3.getCollection("address");
                    DBCursor cursor3 = coll3.find();
                    while (cursor3.hasNext()) {
                        DBObject show3 = cursor3.next();
                        Map show4 = show3.toMap();
                        System.out.println(show4);
                        String tobuyerAddrCookie = (String)show4.get("buyerAddrCookie");
                        tobuyerAddrCookie = tobuyerAddrCookie.toLowerCase();
                        if(tobuyerAddrCookie.equals(sellerMetaAddr.toLowerCase())){
                            sellerContraAddr = (String)show4.get("sellerContractAddrCookie");
                        }
                    }
                }
                catch(Exception e){
                    System.err.println( e.getClass().getName() + ": " + e.getMessage() );
                }
                String modelIndSeller = (String)show1.get("modelIndSeller");
                in.sellerMetaAddr = sellerMetaAddr;
                in.sellerContraAddr = sellerContraAddr;
                in.modelIndSeller = modelIndSeller;
                result.add(in);
            }
            i++;
        }
    }
    catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>shopping cart</title>
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
            <h2 class="wow slideInRight">My shopping cart</h2>
            <a style="font-size: 18px;" type="button" href="buyermainpage.jsp">Go back</a>
        </div>
    </header>
    <div class="container">
        <div class="row" id="mapping_things">
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
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
        });
        // scroll to top action
        $('.scroll-top').on('click', function(event) {
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        $('.logout').on('click', function(event) {
            event.preventDefault();
            window.location.href=("login.jsp");
        });
        showShoppingCart();
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
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=buyerAddrCookie%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");

    // show models in shopping cart, and buy model
    function showShoppingCart() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let SellerABI = web3.eth.contract(SellerABIContent);
        let BuyerABI = web3.eth.contract(BuyerABIContent);
        // Define buyerAddr and buyerContAddr
        let buyerAddr = "<%=buyerAddrCookie%>";
        let buyerContAddr = "<%=buyerContractAddrCookie%>";
        $("#mapping_things").empty();
        // Loop infos from DB begin
        <%for (int i = 0; i < result.size(); i++) {
            info details = result.get(i);
        %>
        // get info
        var sellerAddr = '<%=details.sellerMetaAddr%>';
        var sellerContAddr = '<%=details.sellerContraAddr%>';
        var modelIndexSeller = '<%=details.modelIndSeller%>';
        // get access to seller's contract
        web3.eth.defaultAccount = sellerAddr;
        var Seller_contract = SellerABI.at(sellerContAddr);
        // get information of this model
        var result = Seller_contract.getModelByIndex.call(modelIndexSeller, {from: web3.eth.defaultAccount});
        // check repeat
        web3.eth.defaultAccount = buyerAddr;
        var Buyer_contract = BuyerABI.at(buyerContAddr);
        var repeatResult = Buyer_contract.checkRepeat.call(result[3], {from: web3.eth.defaultAccount, gas: 30000000});
        web3.eth.defaultAccount = sellerAddr;
        if (!repeatResult) {
            // display result, note that for buyer model address should not be given before buying
            var newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                '<ul style="margin-left:230px">' +
                '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Model in shopping cart</h3>' + '<br><br><br>'+
                '<li hidden class="seller_address_buy_model">' + sellerAddr + '</li>' +              // hidden on html
                '<li hidden class="seller_contract_address_buy_model">' + sellerContAddr + '</li>' + // hidden on html
                '<li hidden class="model_index_buy_model">' + result[6] + '</li>' +                  // index (hidden on html)
                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name : </a>' + result[1] + '</li>' +
                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description :</a> ' + result[2] + '</li>' +
                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether) : </a>' + web3.fromWei(result[4], 'ether') + '</li>' +
                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time : </a>' + new Date(Number(result[5])) + '</li>' +
                '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" class="buy_model" href="shopping_cart.jsp">Buy this model</a>' +
                '<br><hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
            $("#mapping_things").append(newHeader).trigger("pagecreate");
        }
        <%}%>
        // Loop infos from DB end

        // Buy model
        $("body").on("click",".buy_model", function() {
            // get information from html
            let sellerAddrBuyModel = $(this).parent().find(".seller_address_buy_model").text();
            let sellerContAddrBuyModel = $(this).parent().find(".seller_contract_address_buy_model").text();
            let modelIndexBuyModel = $(this).parent().find(".model_index_buy_model").text();
            // get access to seller's contract
            web3.eth.defaultAccount = sellerAddrBuyModel;
            let Seller_contract = SellerABI.at(sellerContAddrBuyModel);
            // get information for this model, note that we do not need to check repeat here
            let sellerModelDetails = Seller_contract.getModelByIndex.call(modelIndexBuyModel, {from: web3.eth.defaultAccount, gas: 30000000});
            // get access to buyer's contract
            web3.eth.defaultAccount = buyerAddr;
            let Buyer_contract = BuyerABI.at(buyerContAddr);
            // check repeat
            let repeatResult1 = Buyer_contract.checkRepeat.call(sellerModelDetails[3], {from: buyerAddr, gas: 30000000});
            if (repeatResult1) {
                alert("You've already bought this model, don't do it again!");
            }
            else{
                // Buyer deposit money
                Buyer_contract.depositToContract.sendTransaction({from: buyerAddr, value: sellerModelDetails[4], gas: 30000000});
                // get bought time
                let timestamp = Date.parse(new Date());
                // buy model
                Buyer_contract.buyModel.sendTransaction(sellerModelDetails[0], sellerModelDetails[1], sellerModelDetails[2], sellerModelDetails[3],sellerModelDetails[4], timestamp, {from: buyerAddr, gas: 30000000});
                alert("Buying succeeded!");
            }
        });
    }
</script>
</body>
</html>


