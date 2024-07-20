// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    string[] private shop = [
        "HealthPotion",
        "ManaPotion",
        "TomeOfExp",
        "ElixirOfStrength",
        "ElixirOfAgility",
        "ElixirOfIntelligence",
        "Antidote",
        "Medicine",
        "ElixirOfInvincibility",
        "DevilsBlood"
    ];

    mapping(string => uint256) public shopPrices;
    mapping(address => string) public inventory;

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 1000000 * 1 ** uint(decimals()));

        shopPrices["HealthPotion"] = 20 * 1 ** uint(decimals());
        shopPrices["ManaPotion"] = 20 * 1 ** uint(decimals());
        shopPrices["TomeOfExp"] = 50 * 1 ** uint(decimals());
        shopPrices["ElixirOfStrength"] = 70 * 1 ** uint(decimals());
        shopPrices["ElixirOfAgility"] = 70 * 1 ** uint(decimals());
        shopPrices["ElixirOfIntelligence"] = 70 * 10 ** uint(decimals());
        shopPrices["Antidote"] = 60 * 1 ** uint(decimals());
        shopPrices["Medicine"] = 60 * 1 ** uint(decimals());
        shopPrices["ElixirOfInvincibility"] = 120 * 1 ** uint(decimals());
        shopPrices["DevilsBlood"] = 150 * 1 ** uint(decimals());
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    function redeem(string memory itemName) external {
        require(shopPrices[itemName] > 0, "Item does not exist");
        uint256 shopPrice = shopPrices[itemName];
        require(balanceOf(msg.sender) >= shopPrice, "Insufficient balance to buy this item!");

        _burn(msg.sender, shopPrice);

        inventory[msg.sender] = itemName;
    }

    function getRedeemedItem(address account) external view returns (string memory) {
        return inventory[account];
    }
}
