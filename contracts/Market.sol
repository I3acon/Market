//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

interface Erc20 {
    function approve(address, uint256) external returns (bool);

    function transfer(address, uint256) external returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);
}

contract Market {
    Erc20 public jusd;
    uint256 public tvd;
    mapping(address => uint256) public balance;
    event Buy(address indexed user, uint256 _id, uint256 _amount);
    uint256[] public ids;

    constructor(address _jusd) {
        jusd = Erc20(_jusd);
    }

    function additemid(uint256 _id) public {
        require(!checkitemid(_id));
        ids.push(_id);
    }

    function checkitemid(uint256 _id) public view returns (bool) {
        for (uint256 i = 0; i < ids.length; ) {
            if (ids[i] == _id) {
                return true;
            }
            unchecked {
                ++i;
            }
        }
        return false;
    }

    function buy(uint256 _id, uint256 _amount) public {
        require(_amount > 0);
        require(checkitemid(_id));
        jusd.transferFrom(msg.sender, address(this), _amount);
        emit Buy(msg.sender, _id, _amount);
    }
}
