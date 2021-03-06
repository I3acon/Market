//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface Erc20 {
    function approve(address, uint256) external returns (bool);

    function transfer(address, uint256) external returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);
}

contract Market is Ownable {
    struct Item {
        string itemname;
        uint256 price;
    }
    mapping(uint256 => Item) public data;

    Erc20 public jusd;
    event Buy(string recipients, string itemname, uint256 _amount);
    Item[] public items;

    constructor(address _jusd) {
        jusd = Erc20(_jusd);
    }

    function addItem(string memory _name, uint256 _price) public onlyOwner {
        Item memory newItem;
        newItem.itemname = _name;
        newItem.price = _price;
        items.push(newItem);
    }

    function editItem(
        uint256 _id,
        string memory _name,
        uint256 _price
    ) public onlyOwner {
        items[_id].itemname = _name;
        items[_id].price = _price;
    }

    function findItemIndex(string memory _name) public view returns (uint256) {
        for (uint256 i = 0; i < items.length; ) {
            if (
                keccak256(abi.encodePacked(items[i].itemname)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                return i;
            }
            unchecked {
                ++i;
            }
        }
        return 0;
    }

    function deleteItem(uint256 _id) public onlyOwner {
        delete items[_id];
    }

    function purchase(
        string memory recipients,
        string memory name,
        uint256 quantity
    ) public {
        uint256 id = findItemIndex(name);
        if (id < 0 || id >= items.length) {
            console.log("Item not found");
            revert();
        }
        uint256 price = items[id].price * quantity;
        jusd.transferFrom(msg.sender, address(this), price);
        emit Buy(recipients, items[id].itemname, quantity);
    }

    function getSingleItem(uint256 _id)
        public
        view
        returns (string memory, uint256)
    {
        return (items[_id].itemname, items[_id].price);
    }

    function getItems() public view returns (Item[] memory) {
        return items;
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount > 0);
        jusd.transfer(msg.sender, _amount);
    }
}
