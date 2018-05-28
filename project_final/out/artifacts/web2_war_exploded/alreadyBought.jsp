<%@ page language="java" import="java.util.*, javax.servlet.*,com.mongodb.*" pageEncoding="UTF-8"%>
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
    System.out.println("Page alreadyBought.jsp");
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
    <title>already bought</title>
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
            <h2 class="wow slideInRight">Bought models</h2>
            <a style="font-size: 18px" type="button" href="buyermainpage.jsp">Go back</a>
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
<script language="javascript" type="text/javascript" src="BuyerABI.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.scroll-link').on('click', function(event){
            event.preventDefault();
            var t = $(window).scrollTop();
            $('body,html').animate({'scrollTop':t+900},1000)
        });
        viewAllModelsSingleBuyer();
        // scroll to top action
        $('.scroll-top').on('click', function(event) {
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        $('.logout').on('click', function(event) {
            event.preventDefault();
            window.location.href=("login.jsp");
        });
        // mobile nav toggle
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
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
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=buyerAddrCookie%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");

    function viewAllModelsSingleBuyer() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let BuyerABI = web3.eth.contract(BuyerABIContent);
        let userAddr = "<%=buyerAddrCookie%>";
        let userContAddr = "<%=buyerContractAddrCookie%>";
        console.log(userAddr, userContAddr);
        // get access to contract
        web3.eth.defaultAccount = userAddr;
        let Buyer_contract = BuyerABI.at(userContAddr);
        $("#mapping_things").empty();
        // get model count
        let modelCount = Buyer_contract.getModelCount.call({from: web3.eth.defaultAccount});
        // loop
        for(let i = 0; i < modelCount; i++) {
            try {
                // get model information
                let result = Buyer_contract.getModelByIndex.call(i, {from: web3.eth.defaultAccount});
                console.log("Index : " + i);
                // display result
                let modelPath = "./upload/" + result[3];
                let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                    '<ul style="margin-left:230px">' +
                    '<h3 style="color:#33FF44;font-size:16px;margin-left:280px">Bought Model</h3><br><br>' +
                    '<li  style="color:Grey"><a style="font-size:16px;color:#888888">Name : </a>' + result[1] + '</li>' +
                    '<li  style="color:Grey"><a style="font-size:16px;color:#888888">Description : </a>' + result[2] + '</li>' +
                    '<li  style="color:Grey"><a style="font-size:16px;color:#888888">Bought time : </a>' + new Date(Number(result[5])) + '</li>' +
                    '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" href="' + modelPath + '" download>Download model</a><br>' +
                    '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                $("#mapping_things").append(newHeader).trigger("pagecreate");
                console.log("Success : " + i);
            }
            catch (error){
                console.log("Error : " + i);
                break;
            }
        }
    }
</script>

</body>
</html>


