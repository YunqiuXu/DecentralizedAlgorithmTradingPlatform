pragma solidity ^0.4.18;

// COMP9900 Demo 2 Client
//
// Author: Yunqiu Xu
//
// [1] postRequest()
// [2] updateRequest(): update the modelAddr / modelTestResult / frelancerAddr
// [3] getRequestCount(): get the number of requests
// [4] getRequestByIndex() : get one request by its index (within this client)
//      [4-1] Get visible part of request by index
//      [4-2] Get invisible part of request by index (only when requestEnd = False can they be seen)
//      Why divide these: too many variables will cause exception
// [5] closeRequest() : set requestEnd = True and perform transaction
// [6] depositToContract()

contract Client {
    address private owner; // the owner of this contract owner = msg.sender = client

    // event to view information from web3js
    event RequestPosted(address _clientAddr, uint _requestClientIndex, string _requestName, string _requestDescriptionAddr, string _testCodeAddr, uint _reward, uint _threshold, uint256 _requestPostTime, bool _requestEnd);
    event RequestUpdated(address _clientAddr, uint _requestClientIndex, uint _threshold, string _modelAddr, uint _testResult, address _freelancerAddr);
    event RequestClosed(address _clientAddr, uint _requestClientIndex, bool _requestEnd, string _modelAddr, uint _testResult, address _freelancerAddr);

    // Modifier, owner -> msg.sender -> client
    modifier isOwner {
        require(owner == msg.sender);
        _;
    }    

    function Client() public payable {
        owner = msg.sender;
    }

    // A request's structure
    struct Request {
        string requestName;            // the name of request 
        string requestDescriptionAddr; // the description
        string testCodeAddr;           // the test code (address)
        uint reward;                   // the reward (ether)
        uint threshold;                // a threshold for test result, e.g. for accuracy 0.9500 --> threshold = 9500
        uint256 requestPostTime;       // different from model before, only postTime will be loded, and it will not be changed
        bool requestEnd;               // if true, perform transaction
        string modelAddr;              // the model to be submitted
        uint testResult;               // the test result to compare with threshold
        address freelancerAddr;        // the freelancer who posted "modelAddr" and get "testResult"             
    }

    // Collect the requests for this client
    Request[] public postedRequests;


    // [1] Post a new request
    // input: requestName, requestDescriptionAddr, testCodeAddr, reward, threshold, requestPostTime
    // other initializations:
    //      requestEnd = false
    //      modelAddr = ''
    //      testResult = 0
    //      freelancerAddr = owner
    function postRequest(string _requestName, string _requestDescriptionAddr, string _testCodeAddr, uint _reward, uint _threshold, uint256 _requestPostTime) public isOwner() {
        // add a request
        postedRequests.push(Request(_requestName, _requestDescriptionAddr, _testCodeAddr, _reward, _threshold, _requestPostTime, false, "", 0, owner));
        // get its index within this client
        uint requestClientIndex = getRequestCount() - 1;
        // add event
        RequestPosted(owner, requestClientIndex, _requestName, _requestDescriptionAddr, _testCodeAddr, _reward, _threshold, _requestPostTime, false);
    }


    // [2] Update a request
    // This function will be called when a freelancer submit a model as well as its test result
    // Input: requestClientIndex, newModelAddr, newTestResult, newFreelancerAddr
    function updateRequest(uint _requestClientIndex, string _newModelAddr, uint _newTestResult, address _newFreelancerAddr) public isOwner() {
        // check whether new test result is better than both threshold and result
        // other wise no update will be performed
        if (postedRequests[_requestClientIndex].threshold <= _newTestResult && postedRequests[_requestClientIndex].testResult <= _newTestResult) {
            postedRequests[_requestClientIndex].modelAddr = _newModelAddr;
            postedRequests[_requestClientIndex].testResult = _newTestResult;
            postedRequests[_requestClientIndex].freelancerAddr = _newFreelancerAddr;
        }
        // add event 
        RequestUpdated(owner, _requestClientIndex, postedRequests[_requestClientIndex].threshold, postedRequests[_requestClientIndex].modelAddr, postedRequests[_requestClientIndex].testResult, postedRequests[_requestClientIndex].freelancerAddr);
    }


    // [3] get request count
    function getRequestCount() view public returns(uint) {
        return postedRequests.length;
    }

    // [4-1] Get visible part of request by index
    function getRequestByIndexVisible(uint _requestClientIndex) view public returns(address, string, string, string, uint, uint, uint256) {
        Request storage currentRequest = postedRequests[_requestClientIndex]; 
        return (owner, currentRequest.requestName, currentRequest.requestDescriptionAddr, currentRequest.testCodeAddr, currentRequest.reward, currentRequest.threshold, currentRequest.requestPostTime);
    }

    // [4-2] Get invisible part of request by index 
    // Only when "requestEnd = true" can the other attibutes by invisible, otherwise we can only see "requestEnd = false"
    function getRequestByIndexInvisible(uint _requestClientIndex) view public returns(address, bool, string, uint, address, uint) {
         Request storage currentRequest = postedRequests[_requestClientIndex]; 
         return (owner, currentRequest.requestEnd, currentRequest.modelAddr, currentRequest.testResult, currentRequest.freelancerAddr, _requestClientIndex);
    }

    // [5] closeRequest
    // if client chooses to close this request, requestEnd will be set as "true" first
    // if owner != freelancerAddr, then transfer the money: owner -> contract -> freelancer : the request is finished successfully
    // if owner == freelancerAddr, then the money in contract goes back to client : no one satisfies the request
    function closeRequest(uint _requestClientIndex) public isOwner() payable {
        // close the request
        postedRequests[_requestClientIndex].requestEnd = true;
        // transfer the reward from this contract to freelancerAddr
        postedRequests[_requestClientIndex].freelancerAddr.transfer(postedRequests[_requestClientIndex].reward);
        // add the event
        RequestClosed(owner, _requestClientIndex, postedRequests[_requestClientIndex].requestEnd, postedRequests[_requestClientIndex].modelAddr, postedRequests[_requestClientIndex].testResult, postedRequests[_requestClientIndex].freelancerAddr);
    }

    // [6] Client should deposit some money to this contract when posting a request
    // E.g. if he posts 3 requests with reward 1,2,3, then the balance in this contract should be 6
    function depositToContract() public payable {}

    // Call back
    function () public payable {}

}
