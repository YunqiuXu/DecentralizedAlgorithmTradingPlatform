<%@ page language="java" import="java.util.*,com.mongodb.*,com.mongodb.MongoClient" pageEncoding="UTF-8"%>
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
    System.out.println("Page updateModel.jsp");
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
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>update model</title>
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
    <script src="js/cartmain.js"></script>
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
                    <li><a style="font-size: 16px;"  class="scroll-top" href="#">Switch</a></li>
                    <li><a style="font-size: 16px;"  class="logout" data-id="logout" href="#">Logout</a></li>
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
            <h2 class="wow slideInRight">Posted Models</h2>
            <a style="font-size: 18px;" type="button" href="sellermainpage.jsp">Go back</a>
        </div>
    </header>
    <div class="container">
        <div class="row" id="mapping_things">
        </div>
    </div>
</section>

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
<script type="text/javascript">
    $(document).ready(function() {
        // mobile nav toggle
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
        });
        $('.scroll-top').on('click', function(event){
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        $('.logout').on('click', function(event){
            event.preventDefault();
            window.location.href=("index.jsp");
        });
        viewAllModelsSingleSeller();
    });
    // scroll function
    function scrollToID(id, speed){
        var offSet = 50;
        var targetOffset = $(id).offset().top - offSet;
        var mainNav = $('#main-nav');
        $('html,body').animate({scrollTop:targetOffset}, speed);
        if (mainNav.hasClass("open")) {
            mainNav.css("height", "1px").removeClass("in").addClass("collapse");
            mainNav.removeClass("open");
        }
    }
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

    function viewAllModelsSingleSeller() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let SellerABI = web3.eth.contract(SellerABIContent);
        let userAddr = "<%=buyerAddrCookie%>";
        let userContAddr = "<%=sellerContractAddrCookie%>";
        console.log(userAddr, userContAddr);
        // get access to contract
        web3.eth.defaultAccount = userAddr;
        let Seller_contract = SellerABI.at(userContAddr);
        $("#mapping_things").empty();
        // get model count
        let modelCount = Seller_contract.getModelCount.call({from: web3.eth.defaultAccount});
        // loop
        for(let i = 0; i < modelCount; i++){
            try {
                // get model information
                let result = Seller_contract.getModelByIndex.call(i, {from: web3.eth.defaultAccount});
                console.log("Index : " + i);
                // console.log("Result : " + result);
                // get model path
                let modelPath = "./upload/" + result[3];
                // display result
                let newHeader = '<div class="divs" id="anlidesc" style=" width:1000px" >' +
                    '<ul style="margin-left:230px">' +
                    '<h3 style="color:#33FF44;font-size:16px;margin-left:320px">Posted Model</h3>' + '<br><br>'+
                    '<li hidden class="seller_addr">' + result[0] + '</li>' + // index (hidden on html)
                    '<li hidden class="update_model_index">' + result[6] + '</li>' +
                    '<li style="color:Grey"><a style="font-size:16px;color:#888888">Name : </a>' + result[1] + '</li>' +
                    '<li style="color:Grey"><a style="font-size:16px;color:#888888">Description : </a>' + result[2] + '</li>' +
                    '<li style="color:Grey"><a style="font-size:16px;color:#888888">Price (ether) : </a>' + web3.fromWei(result[4], 'ether') + '</li>' +
                    '<li style="color:Grey"><a style="font-size:16px;color:#888888">Time : </a>' + new Date(Number(result[5])) + '</li>' +
                    '<br><li><input class="new_description" placeholder="new description" type="text"></li>' +
                    '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" class="update_model_description" href="updateModel.jsp">Update model description</a>' +
                    '<br><br><li><input class="new_price" placeholder="new price (ether)" type="text"></li>' +
                    '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" class="update_model" href="updateModel.jsp">Update model price</a>' +
                    '<br><br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" href="' + modelPath + '" download>Download model</a><br>' +
                    '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                $("#mapping_things").append(newHeader).trigger("pagecreate");
                console.log("Success : " + i);
            }
            catch (error){
                console.log("Error : " + i);
                break;
            }
        }
        // update model description
        $("body").on("click",".update_model_description", function() {
            web3.eth.defaultAccount = userAddr;
            let Seller_contract = SellerABI.at(userContAddr);
            let modelIndex = $(this).parent().find(".update_model_index").text();
            let newDescription = $(this).parent().find(".new_description").val();
            let timestamp = Date.parse(new Date());
            console.log("You are updating model " + modelIndex);
            console.log("New description : " + newDescription);
            // update description
            Seller_contract.updateModelDescription.sendTransaction(modelIndex, newDescription, timestamp, {from: userAddr, gas: 30000000});
            alert("Update description succeed!")
        });
        // update model price
        $("body").on("click",".update_model", function() {
            web3.eth.defaultAccount = userAddr;
            let Seller_contract = SellerABI.at(userContAddr);
            let modelIndex = $(this).parent().find(".update_model_index").text();
            let newPrice = web3.toWei(Number($(this).parent().find(".new_price").val()), 'ether'); // ether -> wei
            let timestamp = Date.parse(new Date());
            console.log("You are updating model " + modelIndex);
            console.log("New price : " + newPrice);
            // update price
            Seller_contract.updateModel.sendTransaction(modelIndex, newPrice, timestamp, {from: userAddr, gas: 30000000});
            alert("Update price succeed!")
        });
    }
</script>
</body>
</html>


