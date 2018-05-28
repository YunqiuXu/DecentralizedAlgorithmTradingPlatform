var BuyerABIContent =[
    {
        "constant": false,
        "inputs": [
            {
                "name": "_sellerAddr",
                "type": "address"
            },
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
        "name": "buyModel",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
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
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "_buyerAddr",
                "type": "address"
            },
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
                "name": "_modelBuyerIndex",
                "type": "uint256"
            }
        ],
        "name": "ModelPurchased",
        "type": "event"
    },
    {
        "payable": true,
        "stateMutability": "payable",
        "type": "fallback"
    },
    {
        "inputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "constructor"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "boughtModels",
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
        "constant": true,
        "inputs": [
            {
                "name": "_modelAddr",
                "type": "string"
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
        "constant": true,
        "inputs": [
            {
                "name": "_modelBuyerIndex",
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
    }
]