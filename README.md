# Degen Token Contract
=========================

## Overview
-----------

The Degen Token contract is a decentralized application (dApp) built on the Ethereum blockchain. It allows for the creation, transfer, redemption, and burning of tokens.

## Features
------------

### 1. Minting new tokens
### 2. Transferring tokens
### 3. Redeeming tokens
### 4. Checking token balance
### 5. Burning tokens

## Contract Code
----------------

```solidity
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

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
