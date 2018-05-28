<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*,com.mongodb.*,com.mongodb.MongoClient, java.io.*" pageEncoding="UTF-8"%>
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
    System.out.println("Page alreadyAccepted.jsp");
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
    // get all userAddr as well as clientContractAddr
    class info {
        String userAddr;
        String clientContractAddr;
    }
    ArrayList<info> result = new ArrayList<info>();
    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        DB db = mongoClient.getDB( "test" );
        DBCollection coll = db.getCollection("address");
        System.out.println("Collection address selected successfully");
        DBCursor cursor = coll.find();
        while (cursor.hasNext()) {
            info in = new info();
            DBObject show = cursor.next();
            // System.out.println(show);
            Map show1 = show.toMap();
            in.userAddr = (String)show1.get("buyerAddrCookie");
            in.clientContractAddr = (String)show1.get("clientContractDeployed");
            result.add(in);
            System.out.println("userAddr : " + in.userAddr + "    clientContAddr : " + in.clientContractAddr);
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
    <title>already accepted</title>
    <base href="<%=basePath%>">
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

<div style="height:800px">
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

    <div class="parallax-content baner-content" id="home">
        <div class="container">
            <div class="text-content">
                <div class="overlay"></div>
                <div id="modal" class="dropbox">
                    <div class="items-container">
                        <div id="close" style="cursor:pointer;float: right;width:20px">
                            <span class="css-close"></span>
                        </div>
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
</div>

<section id="home-property-listing" style="background-color:white">
    <header class="section-header home-section-header text-center">
        <div class="container">
            <h2 class="wow slideInRight">Accepted requests</h2>
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


<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="FreelancerABI.js"></script>
<script language="javascript" type="text/javascript" src="ClientABI.js"></script>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
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
            window.location.href=("index.jsp");
        });
        showAcceptedRequests();
    });
    if (typeof console === "undefined") {
        console = {
            log: function() { }
        };
    }
</script>

<!-- ---------- upload file begin, similar to selling.jsp, so there's no comment ---------- -->
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
            i++;
        }
        this.childNodes[1].childNodes[1].appendChild(frag);
    }
    function blink() {
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
            url: 'submittingData.jsp',
            type: 'POST',
            data: data,
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                alert('succeed!');
                $("#testCodeInfo").html("You've uploaded the file, now post request");
                closeModal();
                $('.tbody').empty();
                // window.location.href=("alreadyAccepted.jsp");
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
</script>
<!-- ---------- upload file end ---------- -->

<script>
    // add my balance
    if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    } else {
        web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
    }
    let my_balance = String(web3.fromWei(web3.eth.getBalance("<%=buyerAddrCookie%>"), 'ether'));
    $("#my_balance").html("My balance : " + my_balance.substring(0,6) + " ether");

    // show accepted requests
    function showAcceptedRequests() {
        // Set web3
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // get access to freelancer's contract
        let freelancerAddr = "<%=buyerAddrCookie%>";
        let freelancerContAddr = "<%=freelancerContractDeployed%>";
        let FreelancerABI = web3.eth.contract(FreelancerABIContent);
        web3.eth.defaultAccount = freelancerAddr;
        let Freelancer_contract = FreelancerABI.at(freelancerContAddr);
        // get the number of accepted request
        let requestCount = Freelancer_contract.getRequestCount.call({from: web3.eth.defaultAccount});
        // client's abi
        let ClientABI = web3.eth.contract(ClientABIContent);
        // loop to get request information
        for(let i=0; i<requestCount; i++){
            // get simple request (flAddr, flIndex, ctAddr, ctIndex)
            let result = Freelancer_contract.getRequestByIndex.call(i, {from: web3.eth.defaultAccount});
            // db loop begin
            <%for (int i =0; i < result.size(); i++){
                info currentInfo = result.get(i);
            %>
            if (result[2]==("<%=result.get(i).userAddr%>")){
                // get access to client's contract
                web3.eth.defaultAccount = result[2];
                var clientContAddr = "<%=currentInfo.clientContractAddr%>";
                var Client_contract = ClientABI.at(clientContAddr);
                // get detailed result
                var resultVisible = Client_contract.getRequestByIndexVisible.call(result[3], {from: web3.eth.defaultAccount});
                var resultInvisible = Client_contract.getRequestByIndexInvisible.call(result[3], {from: web3.eth.defaultAccount});
                // check whether closed and display the result
                // Status1: closed and you are the winner
                // Status2: closed and you are not the winner
                // Status3: still available
                if (resultInvisible[1]) {
                    if (resultInvisible[4] == freelancerAddr) {
                        var modelPath = "./upload/" + resultInvisible[2];
                        var newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                            '<ul style="margin-left:230px">' +
                            '<h3 style="color:#8833FF;font-size:16px;margin-left:190px">Request status : you winned this request</h3><br>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request description : </a>' + resultVisible[2] + '</li>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Reward (ether) : </a>' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Threshold : </a>' + resultVisible[5] + '</li>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Post time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                            // '<a type="button" style="width:150px;height:16px;border-radius:15px;font-weight:bold;color: " href="' + modelPath + '" download>Download model</a>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Test result : </a>' + resultInvisible[3] + '</li>' +
                            '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color: " type="button" href="' + modelPath + '" download>Download model</a>' +
                            '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                        $("#mapping_things").append(newHeader).trigger("pagecreate");
                    }
                    else{
                        let newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                            '<ul style="margin-left:230px">' +
                            '<h3 style="color:#FF3344;font-size:16px;margin-left:190px">Request status : closed</h3><br>' +
                            '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                            '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                        $("#mapping_things").append(newHeader).trigger("pagecreate");
                    }
                }
                else{
                    var newHeader = '<div class="divs" id="anlidesc" style="width:1000px" >' +
                        '<ul style="margin-left:230px">' +
                        '<h3 style="color:#33FF44;font-size:16px;margin-left:220px">Request status : available</h3><br>' +
                        '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request name : </a>' + resultVisible[1] + '</li>' +
                        '<li style="color:Grey"><a style="font-size:16px;color:#888888">Request description : </a>' + resultVisible[2] + '</li>' +
                        '<li style="color:Grey"><a style="font-size:16px;color:#888888">Reward (ether) : </a>' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                        '<li style="color:Grey"><a style="font-size:16px;color:#888888">Threshold : </a>' + resultVisible[5] + '</li>' +
                        '<li style="color:Grey"><a style="font-size:16px;color:#888888">Post time : </a>' + new Date(Number(resultVisible[6])) + '</li>' +
                        '<br><a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color:#1E87E7 " type="button" onclick="showModal()">Add file (name : model_' + i + '.py)</a></br>' +
                        '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color:#1E87E7 " type="button" class="submit_model" >Submit model to OJ system</a></br>' +
                        '<a style="width:150px;height:30px;border-radius:15px;font-weight:bold;color:#1E87E7 " type="button" class="update_request">View test result and update request</a>' +
                        '<li hidden class = "request_index_freelancer">' + i + '</li>' +               // hidden
                        '<li hidden class = client_addr>' + resultVisible[0] + '</li>' +               // hidden
                        '<li hidden class="client_contract_addr">' + clientContAddr + '</li>' +        // hidden
                        '<li hidden class="request_index_client" >' + resultInvisible[5] + '</li>' +   // hidden
                        '<h3 style="color:#E11EE7;font-size:16px;margin-left:190px" id="test_result_info_' + i + '"></h3>' +
                        '<hr style="border:2px;height:2px;border-top:2px dotted Grey"></hr></ul></div>';
                    $("#mapping_things").append(newHeader).trigger("pagecreate");
                }
                // set the default account back to freelancer
                web3.eth.defaultAccount = freelancerAddr;
            }
            <%}%>
            // db loop end
        }
        // submit model and get result
        $("body").on("click",".submit_model", function() {
            // get information
            var freelancerRequestIndex = $(this).parent().find(".request_index_freelancer").text();
            var clientAddr_submit = $(this).parent().find(".client_addr").text();
            var clientContAddr_submit = $(this).parent().find(".client_contract_addr").text();
            var clientRequestIndex = $(this).parent().find(".request_index_client").text();
            // check information
            console.log("flRIndex : " + freelancerRequestIndex);
            console.log("clAddr : " + clientAddr_submit);
            console.log("clCAddr : " + clientContAddr_submit);
            console.log("clRIndex : " + clientRequestIndex);
            // post information to submitModel.jsp
            $.post('submitModel.jsp', {'freelancerRequestIndex':freelancerRequestIndex, 'clientAddr':clientAddr_submit, 'clientContAddr':clientContAddr_submit, 'clientRequestIndex':clientRequestIndex});
            alert("Testing, please wait for several seconds");
            window.location.href=("alreadyAccepted.jsp");
        });
        // view result and update request
        $("body").on("click",".update_request", function() {
            // get information
            var freelancerRequestIndex = $(this).parent().find(".request_index_freelancer").text();
            var clientAddr_submit = $(this).parent().find(".client_addr").text();
            var clientContAddr_submit = $(this).parent().find(".client_contract_addr").text();
            var clientRequestIndex = $(this).parent().find(".request_index_client").text();
            // check whether result.txt is correct
            <%
                int FLAG = 0;
                // Set root path
                String serverName = request.getServerName();
                String realPath = request.getRealPath(serverName);
                realPath = realPath.substring(0,realPath.lastIndexOf("/"));
                // get access to result.txt
                String run2Path = realPath + "/OJ_test/run_oj_part2.py";
                String resultPath = realPath + "/OJ_test/result.txt";
                System.out.println("run2Path : " + run2Path);
                System.out.println("resultPath : " + resultPath);
                // Check whether run2Path exists (should not exist)
                File run2_file = new File(run2Path);
                String testResult = "";
                if (run2_file.exists()) {
                    System.out.println("Error, run2path still exists! Try upload again!");
                }
                else {
                    System.out.println("Now check result.txt");
                    File result_file = new File(resultPath);
                    if(result_file.exists()){
                        System.out.println("result.txt exists! Now try to read it!");
                        BufferedReader in = new BufferedReader(new FileReader(result_file));
                        String line;
                        while ((line = in.readLine()) != null) {
                            testResult = testResult + line;
                            System.out.println("Test result : " + line);
                        }
                        in.close();
                        if(result_file.delete()){
                            FLAG = 1;
                            System.out.println("Delete result_file successful!");
                        }
                        else{
                            System.out.println("Delete result_file failed!");
                        }
                    }
                    else{
                        System.out.println("Error, result.txt does not exist!");
                    }
                }
            %>

            // check whether the update should be performed
            var succeed_flag = Number("<%=FLAG%>");
            if (succeed_flag == 0){
                alert("Something wrong, try to run OJ again!");
            }
            else{
                // get access to Client's contract
                web3.eth.defaultAccount = clientAddr_submit;
                var ClientABI_here = web3.eth.contract(ClientABIContent);
                var Client_contract = ClientABI_here.at(clientContAddr_submit);

                // Get infotmation to update
                var requestIndex = clientRequestIndex;
                var modelAddr = "<%=freelancerContractDeployed%>" + "/model_" + String(freelancerRequestIndex) + ".py";
                var testResult = "<%=testResult%>";
                var freelancerAddr = "<%=buyerAddrCookie%>";

                // get request count
                var requestCount = Client_contract.getRequestCount.call({from: web3.eth.defaultAccount});
                console.log("Number of requests for this client : " + requestCount);
                var infoButton = "#test_result_info_" + freelancerRequestIndex;

                $(infoButton).empty();
                Client_contract.updateRequest.sendTransaction(Number(requestIndex), modelAddr, Number(testResult), freelancerAddr, {from: web3.eth.defaultAccount, gas: 30000000}, function(error, result){
                    if(!error){
                        $(infoButton).html("Test result is " + String(testResult) + " and request have been updated!");
                        console.log("Updating succeeded");
                    }
                    else{
                        console.log("Updating failed");
                        $(infoButton).html("Test result is " + String(testResult) + " , but failed to update request, try submit model again!");
                    }
                });
            }
        });
    }
</script>
</body>
</html>


