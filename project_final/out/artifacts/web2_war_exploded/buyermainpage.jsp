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
    System.out.println("Page buyermainpage.jsp");
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
    <title>buyer mainpage</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
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
</head>

<body>
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
                    <li><a style="font-size: 16px;" class="shopping_cart" href="#" type="button">shopping cart</a></li>
                    <li><a style="font-size: 16px;" class="bought_models" href="#" type="button">bought models</a></li>
                    <li><a style="font-size: 16px;" href="#" type="button" class="scroll-top">Switch</a></li>
                    <li><a style="font-size: 16px;" href="#" type="button" class="logout" data-id="logout">Logout</a></li>
                </ul>
            </div>
        </nav>
    </div>
</div>

<div class="parallax-content baner-content" id="home">
    <div class="container">
        <div class="text-content" style="margin-top: -20px;">
            <h2>Bu<em>y</em>er <span>P</span>age</h2>
                <form style= "margin-top: 20px" id="_form" method="post" action="shopping.jsp">
                    <input type="text" style="bottom:30px;  width: 400px; margin-right: 20px" name="search" placeholder="If no keyword, show all models" />
                    <a style="border-radius:20px" onclick="document.getElementById('_form').submit();" href="#" class="animBtn themeB">Search</a>
                </form>
            </div>
        </div>
    </div>
</div>


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

<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // navigation click actions
        $('.bought_models').on('click', function(event){
            event.preventDefault();
            window.location.href=("alreadyBought.jsp");
        });
        $('.shopping_cart').on('click', function(event){
            event.preventDefault();
            window.location.href=("shopping_cart.jsp");
        });
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
            window.location.href=("index.jsp");
        });
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
</script>
</body>
</html>