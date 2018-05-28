// ABI : remix compile -> details -> copy value to clipboard
// For same contract the ABI will be same as well
var ClientABIContent = [
    {
        "constant": true,
        "inputs": [
            {
                "name": "_requestClientIndex",
                "type": "uint256"
            }
        ],
        "name": "getRequestByIndexVisible",
        "outputs": [
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "uint256"
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
                "name": "_requestPostTime",
                "type": "uint256"
            }
        ],
        "name": "client2_test_posts_5requests",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_requestPostTime",
                "type": "uint256"
            }
        ],
        "name": "client1_test_posts_3requests",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
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
        "constant": false,
        "inputs": [
            {
                "name": "_requestClientIndex",
                "type": "uint256"
            },
            {
                "name": "_newModelAddr",
                "type": "string"
            },
            {
                "name": "_newTestResult",
                "type": "uint256"
            },
            {
                "name": "_newFreelancerAddr",
                "type": "address"
            }
        ],
        "name": "updateRequest",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "_requestClientIndex",
                "type": "uint256"
            }
        ],
        "name": "getRequestByIndexInvisible",
        "outputs": [
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "bool"
            },
            {
                "name": "",
                "type": "string"
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
        "inputs": [],
        "name": "depositToContract",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_requestName",
                "type": "string"
            },
            {
                "name": "_requestDescriptionAddr",
                "type": "string"
            },
            {
                "name": "_testCodeAddr",
                "type": "string"
            },
            {
                "name": "_reward",
                "type": "uint256"
            },
            {
                "name": "_threshold",
                "type": "uint256"
            },
            {
                "name": "_requestPostTime",
                "type": "uint256"
            }
        ],
        "name": "postRequest",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "postedRequests",
        "outputs": [
            {
                "name": "requestName",
                "type": "string"
            },
            {
                "name": "requestDescriptionAddr",
                "type": "string"
            },
            {
                "name": "testCodeAddr",
                "type": "string"
            },
            {
                "name": "reward",
                "type": "uint256"
            },
            {
                "name": "threshold",
                "type": "uint256"
            },
            {
                "name": "requestPostTime",
                "type": "uint256"
            },
            {
                "name": "requestEnd",
                "type": "bool"
            },
            {
                "name": "modelAddr",
                "type": "string"
            },
            {
                "name": "testResult",
                "type": "uint256"
            },
            {
                "name": "freelancerAddr",
                "type": "address"
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
                "name": "_requestClientIndex",
                "type": "uint256"
            }
        ],
        "name": "closeRequest",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
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
                "name": "_requestName",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_requestDescriptionAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_testCodeAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_reward",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_threshold",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_requestPostTime",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_requestEnd",
                "type": "bool"
            }
        ],
        "name": "RequestPosted",
        "type": "event"
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
                "name": "_threshold",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_modelAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_testResult",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_freelancerAddr",
                "type": "address"
            }
        ],
        "name": "RequestUpdated",
        "type": "event"
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
                "name": "_requestEnd",
                "type": "bool"
            },
            {
                "indexed": false,
                "name": "_modelAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_testResult",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_freelancerAddr",
                "type": "address"
            }
        ],
        "name": "RequestClosed",
        "type": "event"
    }
];
