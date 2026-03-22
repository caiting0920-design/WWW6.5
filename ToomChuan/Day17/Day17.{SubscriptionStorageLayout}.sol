// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

//蓝图：谁是所有者；逻辑合约的地址在哪；实际的存储布局（用户订阅、套餐价格、持续时间等）

contract SubscriptionStorageLayout {
    address public logicContract;
    address public owner;

    struct Subscription {
        uint8 planId;
        uint256 expiry;
        bool paused;
    }

    mapping(address => Subscription) public subscriptions;
    mapping(uint8 => uint256) public planPrices;
    mapping(uint8 => uint256) public planDuration;
}

