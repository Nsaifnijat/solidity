//SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
//we need to import simplestorage to make storagefactory know about simple storage
import "./SimpleStorage.sol"; //its like copying the whole contract into here


//contract StorageFactory {
//in order to inherit the SimpleStorage funcs we can add this
contract StorageFactory is SimpleStorage {

    // in this array we keep track of our SimpleStorage transactions
    SimpleStorage[] public simpleStorageArray;
    // lets launch the SimpleStorage contract from this contract
    function createSimpleStorageContract() public {
        
        // create an object of type SimpleStorage Contract, name it simpleStorage then we say its gonna
        //be a new SimpleStorage() contract and it takes no parameters, it make use of our imported SimpleStorage
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    // create a func to interact with SimpleStorage contract, for interacting with a contract
    // we need two things: address, ABI
    // address: we can get the address from our array simpleStorageArray
    //ABI = application binary interface, we get it from the import  
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //interact with SimpleStorage contract
        //SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        //simpleStorage.store(_simpleStorageNumber);
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }
    // we interacted with SimpleStorage contract using the above func but we did not retrieve anything 
    // so in the following we retrieve data
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
        //SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        //return simpleStorage.retrieve();
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}