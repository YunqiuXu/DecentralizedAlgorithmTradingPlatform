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
    System.out.println("Page postRequest.jsp");
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
    <title>postRequest</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
                    <li><a style="font-size: 16px;" class="scroll-top" href="#">Switch</a></li>
                    <li><a style="font-size: 16px;" class="logout" data-id="logout" href="#">Logout</a></li>
                </ul>
            </div>
        </nav>
    </div>
</div>

<!-- Yunqiu Xu : input information -->
<div class="primary-white-button">
    <div class="login">
        <button class="btn" style="font-size: 18px;color: #4db6ac" onclick="showModal()">Add testcode</button>
        <div class="uploadFiles"></div>
        <form method="post" id="_form">
            <input id="name" type="text" placeholder="Request's name" required="required" />
            <textarea id="description" placeholder="Description" style="height:80px;"></textarea>
            <input id="reward" type="text" placeholder="Reward (ether)" required="required" />
            <input id="threshold" type="text" placeholder="Threshold (e.g. if 95%, input '9500')" required="required" />
            </br>
            <a style="text-align: center;width:400px" href="clientMainpage.jsp" onclick="postRequest()" class="animBtn themeB">Submit</a>
        </form>
    </div>
</div>

<div class="parallax-content baner-content" id="home">
    <div class="container">
        <div class="text-content">
            <h2 style="margin-top:-50px">P<em>o</em>st <span>A</span> R<em>e</em>quest</h2>
            <div class="overlay"></div>
            <div id="modal" class="dropbox">
                <div class="items-container">
                    <div id="close" style="cursor:pointer;float: right;width:20px">
                        <span class="css-close"></span>
                    </div>
                    <h5 id="testCodeInfo"></h5>
                    <div>
                        <p class="head"><b>additional file</b></p>
                        <div class="content" id="content">
                            <table class="table">
                                <tbody class="tbody"></tbody>
                            </table>
                        </div>
                        <div class="footer">
                            <button class="btn" onclick="upload()">Upload file</button>
                        </div>
                        <a href='#' onclick='clearAll()' style='position:absolute;bottom:10px;right:30px;'>clear all</a>
                    </div>
                </div>
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

<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="ClientABI.js"></script>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
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
</script>


<!-- ---------- upload file begin, this is similar to what in selling.jsp, so no comment here ---------- -->
<script>
    function showModal() {
        var modal = document.getElementById('modal');
        var overlay = document.getElementsByClassName('overlay')[0];
        overlay.style.display = 'block';
        modal.style.display = 'block';
    }
    function closeModal() {
        var modal = document.getElementById('modal');
        var overlay = document.getElementsByClassName('overlay')[0];
        overlay.style.display = 'none';
        modal.style.display = 'none';
    }
    document.getElementsByClassName('overlay')[0].addEventListener('click', closeModal, false);
    document.getElementById('close').addEventListener('click', closeModal, false);
    var Dragfiles=(function (){
        var instance;
        return function(){
            if(!instance){
                instance = new FormData();
            }
            return instance;
        }
    }());
    FormData.prototype.deleteAll=function () {
        var _this=this;
        this.forEach(function(value,key){
            _this.delete(key);
        });
    }

    var dz = document.getElementById('content');
    dz.ondragover = function (ev) {
        ev.preventDefault();
        this.style.borderColor = 'red';
    }

    dz.ondragleave = function () {
        this.style.borderColor = 'gray';
    }
    var fileName = "";
    dz.ondrop = function (ev) {
        this.style.borderColor = 'gray';
        ev.preventDefault();
        var files = ev.dataTransfer.files;
        var len=files.length, i=0;
        var frag=document.createDocumentFragment();
        var tr,time,size;
        var newForm=Dragfiles();
        while(i<len){
            tr=document.createElement('tr');
            size=Math.round(files[i].size * 100 / 1024) / 100 + 'KB';
            time = files[i].lastModifiedDate.toLocaleDateString() + ' '+files[i].lastModifiedDate.toTimeString().split(' ')[0];
            tr.innerHTML='<td>'+files[i].name+'</td><td>'+time+'</td><td>'+size+'</td><td>删除</td>';
            console.log(size+' '+time);
            frag.appendChild(tr);
            newForm.append(files[i].name,files[i]);
            fileName = files[i].name;
            i++;
        }
        this.childNodes[1].childNodes[1].appendChild(frag);
    }
    function blink()
    {
        document.getElementById('content').style.borderColor = 'gray';
    }

    function upload(){
        if(document.getElementsByTagName('tbody')[0].hasChildNodes()==false){
            document.getElementById('content').style.borderColor = 'red';
            setTimeout(blink,200);
            return false;
        }
        var data=Dragfiles();
        console.log(data);
        $.ajax({
            url: 'requestData.jsp',
            type: 'POST',
            data: data,
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                alert('succeed!');
                closeModal();
                $('.tbody').empty();
                $('.uploadFiles').append("<h6 style='margin-left:20px;color:white'>"+ fileName+"</h6>").trigger("pagecreate");
            },
            error: function (returndata) {
                alert('failed!');
            }
        });
    }
    $(".tbody").on('click','tr td:last-child',function(){
        var temp=Dragfiles();
        var key=$(this).prev().prev().prev().text();
        console.log(key);
        temp.delete(key);
        $(this).parent().remove();
    });
    function clearAll(){
        if(document.getElementsByTagName('tbody')[0].hasChildNodes()==false){
            document.getElementById('content').style.borderColor = 'red';
            setTimeout(blink,300);
            return false;
        }
        var data=Dragfiles();
        data.deleteAll();
        document.getElementsByTagName('tbody')[0].innerHTML='';
    }

<!-- ---------- upload file end ---------- -->

    // Set web3
    if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    } else {
        web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
    }
    // Add balance
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=buyerAddrCookie%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");
    // Insert ABI
    let ClientABI = web3.eth.contract(ClientABIContent);
    let clientAddr = "<%=buyerAddrCookie%>"; // "buyerAddrCookie" is the user's address, regardless his identity
    let clientContAddr = "<%=clientContractDeployed%>";
    // Get access to contract
    web3.eth.defaultAccount = clientAddr;
    let Client_contract = ClientABI.at(clientContAddr);
    // Get testcode path
    let requestCount = Client_contract.getRequestCount.call({from: web3.eth.defaultAccount});
    $("#testCodeInfo").html("Post a new request. The file name should be 'testcode_" + String(requestCount) + ".py'");

    // Before posting request, you should upload the file first
    function postRequest() {
        // get information
        let requestName = $("#name").val();
        let requestDescriptionAddr = $("#description").val();
        let reward = web3.toWei(Number($("#reward").val()), 'ether');
        let threshold = Number($("#threshold").val());
        let timestamp = Date.parse(new Date());

        // the testcode address should be "xxx/testcode_num.py"
        // Here "xxx" means clientContAddr, "num" means requestCount
        // When download, you should get clientContAddr, then add "./upload/" at its head
        let testCodeAddr = clientContAddr + "/testcode_" + String(requestCount) + ".py";
        // Deposit reward (wei) to contract
        Client_contract.depositToContract.sendTransaction({from: clientAddr, value: reward, gas: 30000000});
        // Post the request
        Client_contract.postRequest.sendTransaction(requestName, requestDescriptionAddr, testCodeAddr, reward, threshold, timestamp, {from: clientAddr, gas: 30000000});
    }
</script>
</body>
</html>