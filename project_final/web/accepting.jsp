<%@ page language="java" import="java.util.*, javax.servlet.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%
    // [Yunqiu Xu] finished checking
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    // get all address
    String buyerAddrCookie = "";
    String userNameCookie = "";
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";
    String clientContractAddrCookie = "";
    String freelancerContractDeployed = "";
    String clientContractDeployed = "";
    Cookie[] cookies = request.getCookies();
    class combo{
        String userAddress = "";
        String clientContractAddr = "";
    }
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
            clientContractAddrCookie = (String)show4.get("clientContractDeployed");
            System.out.println("kkk"+clientContractAddrCookie);
            c.userAddress = buyerAddrCookie;
            c.clientContractAddr = clientContractAddrCookie;
            container.add(c);
        }
    }catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }

    System.out.println("Page accepting.jsp");
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
    String searchPattern = (String)request.getParameter("search"); // this is search pattern, if pattern == "", show all models
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>accepting</title>
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
            <a style="font-size: 18px;" type="button" href="freelancerMainpage.jsp">Go back</a>
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
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="ClientABI.js"></script>
<script language="javascript" type="text/javascript" src="FreelancerABI.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.scroll-link').on('click', function(event){
            event.preventDefault();
            var t = $(window).scrollTop();
            $('body,html').animate({'scrollTop':t+900},1000)
        });
        viewAllRequestsMultiClient();
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
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=buyerAddrCookie%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");

    // Note that this is search result
    function viewAllRequestsMultiClient() {
        // Insert ABI
        let ClientABI = web3.eth.contract(ClientABIContent);
        let FreelancerABI = web3.eth.contract(FreelancerABIContent);
        // get all sellers and their contracts
        var allClients = [];
        <%for(int i=0;i<container.size();i++){%>
        allClients.push("<%= container.get(i).userAddress%>");
        <%}%>
        var allClientContracts = [];
        <%for(int i=0;i<container.size();i++){%>
        allClientContracts.push("<%= container.get(i).clientContractAddr%>");
        <%}%>
        $("#mapping_things").empty();
        for (let j = 0; j < allClients.length; j++){
            let current_client = allClients[j];
            web3.eth.defaultAccount = current_client;
            let Client_contract = ClientABI.at(allClientContracts[j]);
            // Get request count
            let requestCount = Client_contract.getRequestCount.call({from: web3.eth.defaultAccount});
            // loop to get each request
            for(let i = 0; i < requestCount; i++){
                try {
                    // get information
                    let resultVisible = Client_contract.getRequestByIndexVisible.call(i, {from: web3.eth.defaultAccount});
                    let resultInvisible = Client_contract.getRequestByIndexInvisible.call(i, {from: web3.eth.defaultAccount});
                    // match search result
                    let currentName = resultVisible[1].toLowerCase();
                    let searchPattern = "<%=searchPattern%>".toLowerCase();
                    // check whether I've accepted this request
                    web3.eth.defaultAccount = "<%=buyerAddrCookie%>";
                    let Freelancer_contract = FreelancerABI.at("<%=freelancerContractDeployed%>");
                    let repeatResult = Freelancer_contract.checkRepeat.call(resultVisible[0], resultInvisible[5], {from: web3.eth.defaultAccount, gas: 30000000});
                    web3.eth.defaultAccount = current_client;
                    // display the result
                    if (searchPattern == "") { // show all requests
                        // this is my own request
                        if (current_client.toLowerCase() == "<%=buyerAddrCookie%>".toLowerCase()){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#008CFD;font-size:16px;margin-left:190px">Request status : my own request</h3><br><br>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr> </ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // I've accepted this request
                        else if (repeatResult){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#E67E22;font-size:16px;margin-left:190px">Request status : already accepted</h3>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // closed
                        else if (resultInvisible[1]){ // closed
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#FF3344;font-size:16px;margin-left:220px">Request status : closed</h3><br><br>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // available
                        else{
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Request status : available</h3><br><br>' +
                                '<li hidden class="client_addr">' + resultVisible[0] + '</li>' +               // hidden
                                '<li hidden class="client_contract_addr">' + allClientContracts[j] + '</li>' + // hidden
                                '<li hidden class="request_index" >' + resultInvisible[5] + '</li>' +          // hidden
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request description : </a>' + resultVisible[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Reward (ether) : </a>' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">threshold : </a>' + resultVisible[5] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Post time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " class="accept_request">Accept this request</a>'+
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                    }
                    else if(currentName.match(searchPattern)){ // only show matched requests
                        // this is my own request
                        if (current_client.toLowerCase() == "<%=buyerAddrCookie%>".toLowerCase()){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#008CFD;font-size:16px;margin-left:190px">Request status : my own request</h3><br><br>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr> </ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // I've accepted this request
                        else if (repeatResult){
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#E67E22;font-size:16px;margin-left:190px">Request status : already accepted</h3>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // closed
                        else if (resultInvisible[1]){ // closed
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#FF3344;font-size:16px;margin-left:220px">Request status : closed</h3><br><br>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Posted time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                            $("#mapping_things").append(newHeader).trigger("pagecreate");
                        }
                        // available
                        else{
                            let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                                '<ul style="margin-left:230px">' +
                                '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Request status : available</h3><br><br>' +
                                '<li hidden class="client_addr">' + resultVisible[0] + '</li>' +               // hidden
                                '<li hidden class="client_contract_addr">' + allClientContracts[j] + '</li>' + // hidden
                                '<li hidden class="request_index" >' + resultInvisible[5] + '</li>' +          // hidden
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request description : </a>' + resultVisible[2] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Reward (ether) : </a>' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">threshold : </a>' + resultVisible[5] + '</li>' +
                                '<li style="color:Grey"><a style="font-size:16px;color:#888888">Post time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                                '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " class="accept_request">Accept this request</a>'+
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
        }
        // accept this request
        $("body").on("click",".accept_request", function() {
            // get this request's information
            let clientAddr = $(this).parent().find(".client_addr").text();
            let clientContractAddr = $(this).parent().find(".client_contract_addr").text();
            let requestIndex = $(this).parent().find(".request_index").text();
            console.log("You are about to accept : ");
            console.log("client's user address : " + clientAddr);
            console.log("client't contract address : " + clientContractAddr);
            console.log("requestIndex : " + requestIndex);
            console.log("-----");
            // get access to freelancer's contract
            let FreelancerABI = web3.eth.contract(FreelancerABIContent);
            let freelancerAddr = "<%=buyerAddrCookie%>"; // "buyerAddrCookie" is the user's address, regardless his identity
            let freelancerContAddr = "<%=freelancerContractDeployed%>";
            web3.eth.defaultAccount = freelancerAddr;
            let Freelancer_contract = FreelancerABI.at(freelancerContAddr);

            console.log("Your user address : " + web3.eth.defaultAccount);
            console.log("Your freelancer contract : " + freelancerContAddr);
            console.log("=====");

            // check repeat
            let repeatResult1 = Freelancer_contract.checkRepeat.call(clientAddr, requestIndex, {from: web3.eth.defaultAccount, gas: 30000000});
            if (repeatResult1) {
                alert("You've already accepted this request, don't do it again!");
            }
            else{
                // accept request
                Freelancer_contract.acceptRequest.sendTransaction(clientAddr, requestIndex, {from: web3.eth.defaultAccount, gas: 30000000}, function(error){
                    if(!error){
                        alert("Accepting succeeded!");
                    }
                    else{
                        alert("Accepting failed!");
                    }
                });
            }
        });
    }
</script>

</body>
</html>


