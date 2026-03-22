// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract WeaponStorePlugin {
    //user => weapon name
    mapping(address => string) public equippedWeapon;

    //设置用户的现有装备
    function setWeapon(address user, string memory weapon) public {
        equippedWeapon[user] = weapon;
    }

    //获取用户的现有装备
    function getWeapon(address user) public view returns (string memory) {
        return equippedWeapon[user];

       
    }


}