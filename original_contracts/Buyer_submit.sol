pragma solidity ^0.4.18;


// COMP9900 Demo 1 Buyer
// 
// Author: Yunqiu Xu
//
// [1] Buy a model
// [2] Get the number of bought models
// [3] Get a bought model by index
// [4] Deposit some money from user(buyer) to this contract
// [5] Check repeat by address

contract Buyer {

    address private owner; // the owner of this contract (buyer)

    // An event which will be triggered when function buyModel() is called
    event ModelPurchased(address _buyerAddr, address _sellerAddr, string _modelName, string _modelDescriptionAddr, string _modelAddr, uint _modelPrice, uint256 _modelTime, uint _modelBuyerIndex);

    // Modifier, owner -> msg.sender -> buyer
    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }

    // Build a buyer, here we just need the buyer's address (metamask's address)
    function Buyer() public payable {
        owner = msg.sender;
    }

    // A model's structure, same with Seller
    struct Model {
        string modelName;             // the name of model
        string modelDescriptionAddr; // the address of model description
        string modelAddr;            // the address of model, the user can get model code via this address
        uint modelPrice;              // the price of model (will also be stored in database as well)
        uint256 modelTime;            // the time this model be bought
    }
    
    // collect the models this buyer bought
    Model[] public boughtModels;
    
    // [1] a buyer buys an item from a seller
    // input: the address of seller, the index of this model in seller's postedModels
    // then other details will be collected by using Seller's contract
    // The model's details will be served as the input of this function
    function buyModel(address _sellerAddr, string _modelName, string _modelDescriptionAddr, string _modelAddr, uint _modelPrice, uint256 _modelTime) public isOwner() payable {
        boughtModels.push(Model(_modelName, _modelDescriptionAddr, _modelAddr, _modelPrice, _modelTime));
        _sellerAddr.transfer(_modelPrice); // transfer money from contract to _sellerAddr
        uint modelBuyerIndex = getModelCount() - 1;
        ModelPurchased(owner, _sellerAddr, _modelName, _modelDescriptionAddr, _modelAddr, _modelPrice, _modelTime, modelBuyerIndex);
    }

    // [2] Get model count
    function getModelCount() view public returns(uint) {
        return boughtModels.length;
    }

    // [3] Get a model directly by their index
    // input : index in boughtModels
    // output : buyer's address / name / description's addr / model's addr / price / bought time / model's index
    function getModelByIndex(uint _modelBuyerIndex) view public returns(address, string, string, string, uint, uint256, uint) {
        Model storage currentModel = boughtModels[_modelBuyerIndex];
        return (owner, currentModel.modelName, currentModel.modelDescriptionAddr, currentModel.modelAddr, currentModel.modelPrice, currentModel.modelTime, _modelBuyerIndex);
    }

    // [4] Buyer should deposit some money to this contract first
    function depositToContract() public payable {}

    // [5] Check repeat by address
    function checkRepeat(string _modelAddr) view public returns(bool) {
        for (uint i = 0; i < boughtModels.length; i++) {
            Model storage currentModel = boughtModels[i];
            if (keccak256(currentModel.modelAddr) == keccak256(_modelAddr)) {
                return true;
            }
        }
        return false;
    }

    // Callback
    function () public payable {}
}
