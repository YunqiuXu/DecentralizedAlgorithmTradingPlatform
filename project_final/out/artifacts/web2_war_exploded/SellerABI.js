// ABI : remix compile -> details -> copy value to clipboard
// For same contract (Seller.sol) the ABI will be same as well
var SellerABIContent = [
    {
        "constant": false,
        "inputs": [
            {
                "name": "_modelName",
                "type": "string"
            },
            {
                "name": "_modelDescriptionAddr",
                "type": "string"
            },
            {
                "name": "_modelAddr",
                "type": "string"
            },
            {
                "name": "_modelPrice",
                "type": "uint256"
            },
            {
                "name": "_modelTime",
                "type": "uint256"
            }
        ],
        "name": "postModel",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getModelCount",
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
                "name": "_modelSellerIndex",
                "type": "uint256"
            }
        ],
        "name": "getModelByIndex",
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
                "name": "_modelSellerIndex",
                "type": "uint256"
            },
            {
                "name": "_newPrice",
                "type": "uint256"
            },
            {
                "name": "_modelTime",
                "type": "uint256"
            }
        ],
        "name": "updateModel",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_modelSellerIndex",
                "type": "uint256"
            },
            {
                "name": "_newDescription",
                "type": "string"
            },
            {
                "name": "_modelTime",
                "type": "uint256"
            }
        ],
        "name": "updateModelDescription",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
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
        "name": "postedModels",
        "outputs": [
            {
                "name": "modelName",
                "type": "string"
            },
            {
                "name": "modelDescriptionAddr",
                "type": "string"
            },
            {
                "name": "modelAddr",
                "type": "string"
            },
            {
                "name": "modelPrice",
                "type": "uint256"
            },
            {
                "name": "modelTime",
                "type": "uint256"
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
                "name": "_sellerAddr",
                "type": "address"
            },
            {
                "indexed": false,
                "name": "_modelName",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelDescriptionAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelPrice",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_modelTime",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_modelSellerIndex",
                "type": "uint256"
            }
        ],
        "name": "ModelPosted",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "_sellerAddr",
                "type": "address"
            },
            {
                "indexed": false,
                "name": "_modelName",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelDescriptionAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelAddr",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "_modelPrice",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_modelTime",
                "type": "uint256"
            },
            {
                "indexed": false,
                "name": "_modelSellerIndex",
                "type": "uint256"
            }
        ],
        "name": "ModelUpdated",
        "type": "event"
    }
];
