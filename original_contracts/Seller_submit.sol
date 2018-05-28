pragma solidity ^0.4.18;


// COMP9900 Demo 1 Seller
//
// Author: Yunqiu Xu
// 
// [1] Post a model
// [2] Update a model
// [3] Get the number of posted models
// [4] View a model by its index
// [5] Test functions


contract Seller {
    
    address private owner; // the owner of this contract owner = msg.sender = seller
    
    // event to view information from web3js
    event ModelPosted(address _sellerAddr, string _modelName, string _modelDescriptionAddr, string _modelAddr, uint _modelPrice, uint256 _modelTime, uint _modelSellerIndex);
    event ModelUpdated(address _sellerAddr, string _modelName, string _modelDescriptionAddr, string _modelAddr, uint _modelPrice, uint256 _modelTime, uint _modelSellerIndex);

    // Modifier, owner -> msg.sender -> seller
    modifier isOwner {
        require(owner == msg.sender);
        _;
    }
    
    function Seller() public payable {
        owner = msg.sender;
    }

    // A model's structure
    struct Model {
        string modelName;             // the name of model
        string modelDescriptionAddr;  // the address of model description (to simplify, we use description content during implementation)
        string modelAddr;             // the address of model, the user can get model code via this address
        uint modelPrice;              // the price of model (will also be stored in database as well)
        uint256 modelTime;            // the time this model be posted / updated (in second)
    }
    
    // Collect the models this seller posted
    Model[] public postedModels;
    
    // [1] Seller posts a new model
    function postModel(string _modelName, string _modelDescriptionAddr, string _modelAddr, uint _modelPrice, uint256 _modelTime) public isOwner() {
        postedModels.push(Model(_modelName, _modelDescriptionAddr, _modelAddr, _modelPrice, _modelTime));
        uint modelSellerIndex = getModelCount() - 1;
        ModelPosted(owner, _modelName, _modelDescriptionAddr, _modelAddr, _modelPrice, _modelTime, modelSellerIndex);
    }

    // [2] Seller updates the model (only the description)
    function updateModelDescription(uint _modelSellerIndex, string _newDescription, uint256 _modelTime) public isOwner() returns(bool) {
        if (_modelSellerIndex < postedModels.length) {
            postedModels[_modelSellerIndex].modelDescriptionAddr = _newDescription;
            postedModels[_modelSellerIndex].modelTime = _modelTime;
            ModelUpdated(owner, postedModels[_modelSellerIndex].modelName, postedModels[_modelSellerIndex].modelDescriptionAddr, postedModels[_modelSellerIndex].modelAddr, postedModels[_modelSellerIndex].modelPrice, postedModels[_modelSellerIndex].modelTime, _modelSellerIndex);
            return true;
        }
        return false;
    }

    // [2] Seller updates the model (only the price)
    function updateModel(uint _modelSellerIndex, uint _newPrice, uint256 _modelTime) public isOwner() returns(bool) {
        if (_modelSellerIndex < postedModels.length) {
            postedModels[_modelSellerIndex].modelPrice = _newPrice;
            postedModels[_modelSellerIndex].modelTime = _modelTime;
            ModelUpdated(owner, postedModels[_modelSellerIndex].modelName, postedModels[_modelSellerIndex].modelDescriptionAddr, postedModels[_modelSellerIndex].modelAddr, postedModels[_modelSellerIndex].modelPrice, postedModels[_modelSellerIndex].modelTime, _modelSellerIndex);
            return true;
        }
        return false;
    }

    // [3] Get model count
    function getModelCount() view public returns(uint) {
        return postedModels.length;
    }

    // [4] Get a model directly by their index
    // input : index in postedModels
    // output : seller's name / model's name / description's addr / model's addr / price / time / index
    function getModelByIndex(uint _modelSellerIndex) view public returns(address, string, string, string, uint, uint256, uint) {
         Model storage currentModel = postedModels[_modelSellerIndex]; 
         return (owner, currentModel.modelName, currentModel.modelDescriptionAddr, currentModel.modelAddr, currentModel.modelPrice, currentModel.modelTime, _modelSellerIndex);
    }

    // Call back
    function () public payable {}

}
