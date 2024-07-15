// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    enum ItemType { TomeOfEXP, BagOfHealthPotions, BagOfManaPotions, ElixirOfInvulnerability }
    mapping(ItemType => uint256) public itemPrices;
    mapping(address => mapping(ItemType => uint256)) public inventory;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        itemPrices[ItemType.TomeOfEXP] = 50;
        itemPrices[ItemType.BagOfHealthPotions] = 20;
        itemPrices[ItemType.BagOfManaPotions] = 20;
        itemPrices[ItemType.ElixirOfInvulnerability] = 100;
    }

    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount); 
    }

    function decimals() override public pure returns (uint8){
        return 0;
    }

    function getBalance() public view returns (uint256){
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) public{
        require(balanceOf(msg.sender)>= _value, "You do not have enough Degen Tokens");
        _transfer(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) public{
        require(balanceOf(msg.sender)>= _value, "You do not have enough Degen Tokens");      
        _burn(msg.sender, _value);
    }

    event RedeemedTokens(address indexed user, ItemType itemType, uint256 itemPrice);
    event UpdatedInventory(address indexed user, ItemType itemType, uint256 newBalance);

    function redeemTokens(ItemType _itemType) public {
        uint256 itemPrice = itemPrices[_itemType];
        require(balanceOf(msg.sender) >= itemPrice, "You do not have enough Degen Tokens");
        inventory[msg.sender][_itemType]++;
        emit RedeemedTokens(msg.sender, _itemType, itemPrice);
        emit UpdatedInventory(msg.sender, _itemType, inventory[msg.sender][_itemType]);
        _burn(msg.sender, itemPrice);
    }

    function getItemName(ItemType _itemType) internal pure returns (string memory) {
        if (_itemType == ItemType.TomeOfEXP) return "Tome of EXP";
        if (_itemType == ItemType.BagOfHealthPotions) return "Bag of Health Potions";
        if (_itemType == ItemType.BagOfManaPotions) return "Bag of Mana Potions";
        if (_itemType == ItemType.ElixirOfInvulnerability) return "Elixir of Invulnerability";
        return "";
    }
}
