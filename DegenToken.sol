/*
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    }

    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount); 
    }

    function decimals() override public pure returns (uint8){
        return 0;
    }

    function getBalance() external view returns (uint256){
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "You do not have enough Degen Tokens");
        _transfer(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "You do not have enough Degen Tokens");      
        _burn(msg.sender, _value);
    }

    function redeemTokens(uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "You do not have enough Degen Tokens");
        //redeem tokens: 1 token = 1 item
        uint256 itemsReceived = _value;
        console.log("You have redeemed %s tokens for %s items", _value, itemsReceived);
        _burn(msg.sender, _value);
    }
}
