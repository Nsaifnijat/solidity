//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract overflow {


    function Overflow() public pure returns(uint8){

        //uint8 big = 255 +1 ,gives error
        uint8 big = 255 +uint8(1);
        return big; // the big will be zero because it resets uint8 max is 255, once over that it resets
    }
}