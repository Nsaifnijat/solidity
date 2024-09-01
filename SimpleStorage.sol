pragma solidity ^0.6.0; //it means from 0.6.0 to 0.6.9
//pragma solidity 0.6.0; //it means only this version
//pragma solidity >=0.6.0 <0.9.0 it means from 0.6.0 to 0.9.0
// so to create a contract you  need to use contract keyword it is like a class which contains data
/* 
its a multiline comment
*/
/*
public funcs: these are part of the contract interface and can be called either internally or via messages.
for public state variables an automatic getter func is generated
internal funcs: these funcs and state variables can only be accessed internally(i.e from within the current contract or contracts)
without using this. this is the default visibility level for state variables
external funcs:these can be called from other contracts and via transactions. an external func can not be called internally
private funs: these funcs and state variables are only visible for the contracts they are defined in and not in 
derived contracts.

the following are shown in blue color
view: is only to view something, is use when we only read something of the blockchain
pure is only for mathematic calculations

struct: what if we store a favorite numb for each person, so we do it using struct, its like creating new objects

solidity storing data:
memory: it will be stored in memory and only during execution it is available
storage: it will be stored in the storage for long use

EVM: all solidity code gets compiled to ethereum virtual machicne
*/

contract SimpleStorage{
    uint256 favoriteNumber; // it will be initialized as zero
    uint256 favoriteNumber = 5; //unsigned integer which 256 bytes
    bool favoriteBool = false;
    string favoriteString = 'string';
    int256 favoriteInt = -5;
    address favoriteAddress = 0x71C7656EC7ab88b098defB751B7401B5f6d8976F;
    bytes32 favoriteBytes = 'cat'; // 32 bytes in this object
    //we can make a variable or function external,internal,public and private
    uint256 public favoriteNumber; // it can be accessed anywhere
    uint256 external favoriteNumber; // it can only be accessed externally
    //if a func is internal it can only be called from funcs inside that func
    //vice versa if its external it can only be called from external areas
    
    struct People {
        uint256 favoriteNumber; //index is 0
        string name; // index becomes 1
    }
    
    People public person = People({favoriteNumber:3,name:'khan'});

    
    
    
    //create a function which can be passed uint256
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    
    }
    
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    
    // creating arrays
    People[] public people; // dynamic array, it can change its size
    People[1] public people; // fixed size it can only has one element
    mapping(string => uint256) public nameToFavoriteNumber; // it maps string to an integer, its is used to search for people favoriteNumber using their name
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
    //add an element to an array
    //people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
    people.push(People( _favoriteNumber,  _name));
    //now we mapp name to favorite number
    nameToFavoriteNumber[_name] = _favoriteNumber;
    
    }
    
}





























































