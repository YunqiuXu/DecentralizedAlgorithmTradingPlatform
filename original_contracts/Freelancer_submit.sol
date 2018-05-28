pragma solidity ^0.4.18;

// COMP9900 Demo 2 Freelancer
//
// Author: Yunqiu Xu
//  
// [1] acceptRequest() : accept a request
// [2] getRequestCount() : get the number of requests he accepted
// [3] getRequestByIndex() : get the information of a request by its index
// [4] checkRepeat() : the same request should not be acccepted twice

contract Freelancer {
    address private owner; // the owner of this contract owner = msg.sender = freelancer

    // event to view information from web3js
    event RequestAccepted(address _clientAddr, uint _requestClientIndex, address _freelancerAddr, uint _requestFreelancerIndex);

    // Modifier, owner -> msg.sender -> freelancer
    modifier isOwner {
        require(owner == msg.sender);
        _;
    }    

    function Freelancer() public payable {
        owner = msg.sender;
    }

    // A request's structure (Note this is different from what in client)
    struct Request {
        address clientAddr;            // the address of client
        uint requestClientIndex;        // the index within client's contract 
    }

    // Collect the requests for this freelancer
    Request[] public acceptedRequests;

    // [1] Accept a request
    function acceptRequest(address _clientAddr, uint _requestClientIndex) public isOwner() {
        acceptedRequests.push(Request(_clientAddr, _requestClientIndex));
        uint requestFreelancerIndex = getRequestCount() - 1;
        RequestAccepted(_clientAddr, _requestClientIndex, owner, requestFreelancerIndex);
    }

    // [2] get the number of accepted requests
    function getRequestCount() view public returns(uint) {
        return acceptedRequests.length;
    }

    // [3] get the information of a request by index
    function getRequestByIndex(uint _requestFreelancerIndex) view public returns(address, uint, address, uint) {
        Request storage currentRequest = acceptedRequests[_requestFreelancerIndex]; 
        return (owner, _requestFreelancerIndex, currentRequest.clientAddr, currentRequest.requestClientIndex);
    }

    // [4] check whether a request has been exist in acceptedRequests
    function checkRepeat(address _clientAddr, uint _requestClientIndex) view public returns(bool) {
        for (uint i = 0; i < acceptedRequests.length; i++) {
            Request storage currentRequest = acceptedRequests[i];
            if (keccak256(currentRequest.clientAddr) == keccak256(_clientAddr) && currentRequest.requestClientIndex == _requestClientIndex){
                return true;
            }
        }
        return false;
    }

    // Callback
    function () public payable {}
}
