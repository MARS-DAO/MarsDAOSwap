// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "./lib/IERC20.sol";
import "./lib/Ownable.sol";
import "./lib/SafeERC20.sol";

contract MarsDaoSwap is Ownable{

    using SafeERC20 for IERC20;
    IERC20 public oldToken;
    IERC20 public newToken;
    address public constant burnAddress =
        0x000000000000000000000000000000000000dEaD;

    constructor(address _oldToken,address _newToken) public {
        oldToken=IERC20(_oldToken);
        newToken=IERC20(_newToken);
    }

    function swap(uint256 amount) external{
        
        require(oldToken.allowance(msg.sender, address(this)) >=amount,
            "Increase the allowance first,call the approve method"
        );
        oldToken.safeTransferFrom(address(msg.sender),burnAddress,amount);
        newToken.safeTransfer(address(msg.sender),amount);
    }

    function inCaseTokensGetStuck(
        address _token,
        uint256 _amount,
        address _to
    ) public onlyOwner{
        IERC20(_token).safeTransfer(_to, _amount);
    }

}