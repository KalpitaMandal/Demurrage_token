pragma solidity ^0.6.0;

import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract daiToken is ERC20 {
    
    IERC20 DetaInstance;
    // uint256 _amount = 100;
    
    constructor() ERC20("daitoken", "DAI") public {
        _mint(msg.sender,100000);
    }
    
    function InteractAndApprove(address _DetaToken, uint256 _amount) public {
        DetaInstance = IERC20(_DetaToken);
        Approve(_DetaToken,_amount);
    }
    function Approve(address _DetaToken, uint256 _amount) public {
        approve(_DetaToken,_amount);
    }
}