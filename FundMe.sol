//SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;
//interfaces compile down to abi, interfaces are like struct 
//ABI: we need ABI to interact with a contract
// we have an interface which has some func defined in the interface located at this address
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
//if you use solidity less than 0.8 then use safemaths to avoid overflow but 0.8 above checks it automatically for safemaths
//we import SafeMath library
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";


contract FundMe {
    //check the safemath for us
    using SafeMathChainlink for uint256;
    //we want this contract to be able to accept new payment so we create a func for it
    //payable means this func can be used to pay for something
    //every func call has an associated value with it, when a transaction happens it has a value to it
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;
    //we make the funders array to set the funders account to zero after we collected the funds in an owner account
    address[] public funders;
    // we create our owner the moment our contract is created, its for security since if we dont create owner first, later someone else could create that and 
    //steal the money
    constructor() public {
        owner = msg.sender;

    }
    function fund() public payable {
        // here we set a threshold of 50, if fund is lessthan 50usd we do not accept
        uint256 minimumUSD = 50 *10 **18; //we turn it to wei
        /* using if statement, not to accept if less than 50, but instead of if statement we can use require
        if (msg.value < minimumUSD){
            revert?
        }
        */
        require(getConversionRate(msg.value)>=minimumUSD,"you need to spend more ETH!");

        //keep track of address who send us money, msg.sender is sender, mgs.value is how much they sent
        addressToAmountFunded[msg.sender] += msg.value;
        //we need eth to usd conversion rate...
        //hgg
        funders.push(msg.sender);
        
    }
    // to use an interface's func is like using struct
    function getVersion() public view returns (uint256){
        // this is how we use the imported interface, we pass the address of the eth contract to get its version.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        /*(uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound) = priceFeed.latestRoundData(); */
        //we can remove variables we dont use and put a comma instead
        (,int256 answer,,,) = priceFeed.latestRoundData();
        //since we need to return uint256, and asnwer is int256 then we cast it to uint, 
        return uint256(answer *10000000000);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/1000000000000000000;
        return ethAmountInUsd;
    }
    //modifiers are used to change the behavior of a func in a declarative way
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    function withdraw() payable onlyOwner public {
        //by using this we mean the contract that we are in, the following means whoever calls withdraw func transfer them all of the money in contract
        // lets make this withdraw in a way that only the owner can withdraw for this we create an owner using constructors
        //require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
        // when we withdraw we want to set everyones account to zero in the mapping, we use forloop
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // we set funders to a new blank address array
        funders = new address[](0);
    }   

}