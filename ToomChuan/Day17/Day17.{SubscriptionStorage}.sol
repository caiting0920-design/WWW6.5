 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Day17.{SubscriptionStorageLayout}.sol";

contract SubscriptionStorage is SubscriptionStorageLayout {
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _logicContract) {
        owner = msg.sender;
        logicContract = _logicContract;
    }

    function upgradeTo(address _newLogic) external onlyOwner {
        logicContract = _newLogic;
    }

    //Fallback函数：
    //当用户调用此代理合约中不存在的函数时会被激发
    //每次用户尝试与我们其他合约中的函数交互时，会触发这个函数
    fallback() external payable {
        address impl = logicContract;
        require(impl != address(0), "Logic contract not set");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
    
    //receive函数：一个安全网，允许代理接受原始ETH转账
    receive() external payable {}
}

