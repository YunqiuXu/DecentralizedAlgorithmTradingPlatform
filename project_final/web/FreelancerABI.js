// ABI : remix compile -> details -> copy value to clipboard
// For same contract the ABI will be same as well
var FreelancerABIContent = [
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "acceptedRequests",
        "outputs": [
            {
                "name": "clientAddr",
                "type": "address"
            },
            {
                "name": "requestClientIndex",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getRequestCount",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "_requestFreelancerIndex",
                "type": "uint256"
            }
        ],
        "name": "getRequestByIndex",
        "outputs": [
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_clientAddr",
                "type": "address"
            },
            {
                "name": "_requestClientIndex",
                "type": "uint256"
            }
        ],
        "name": "acceptRequest",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "_clientAddr",
                "type": "address"
            },
            {
                "name": "_requestClientIndex",
                "type": "uint256"
            }
        ],
        "name": "checkRepeat",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "constructor"
    },
    {
        "payable": true,
        "stateMutability": "payable",
        "type": "fallback"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "_clientAddr",
                "type": "address"
            },
            {
                "indexed": false,
                "name": "_requestClientIndex",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_freelancerAddr",
                "type": "address"
            },
            {
                "indexed": false,
                "name": "_requestFreelancerIndex",
                "type": "uint256"
            }
        ],
        "name": "RequestAccepted",
        "type": "event"
    }
];
