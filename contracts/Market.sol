//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

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
    struct Item {
        uint256 id;
        string itemname;
        uint256 price;
    }

    Erc20 public jusd;
    event Buy(string recipients, string itemname, uint256 _amount);
    Item[] public items;

    constructor(address _jusd) {
        jusd = Erc20(_jusd);
    }

    function addItem(string memory _name, uint256 _price) public {
        Item memory newItem;
        newItem.itemname = _name;
        newItem.price = _price;
        items.push(newItem);
    }

    function editItem(
        uint256 _id,
        string memory _name,
        uint256 _price
    ) public {
        items[_id].itemname = _name;
        items[_id].price = _price;
    }

    function findItem(string memory _name) public view returns (uint256) {
        for (uint256 i = 0; i < items.length; i++) {
            if (
                keccak256(abi.encodePacked(items[i].itemname)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                return i;
            }
        }
        return 0;
    }

    function deleteItem(uint256 _id) public {
        delete items[_id];
    }

    function buyItem(
        string memory recipients,
        uint256 _id,
        uint256 _quantity
    ) public {
        uint256 price = items[_id].price * _quantity;
        jusd.transferFrom(msg.sender, address(this), price);
        emit Buy(recipients, items[_id].itemname, _quantity);
    }
}
