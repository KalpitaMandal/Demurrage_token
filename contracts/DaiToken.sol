pragma solidity ^0.6.0;

import "./ERC20.sol";

contract daiToken is ERC20 {

    constructor() ERC20("daitoken", "DAI") public {
        _mint(msg.sender,100000);
    }
}