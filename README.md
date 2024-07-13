**Degen Token Contract README**

This is a Solidity contract for a custom ERC20 token called Degen Token (DGN). It's built on top of OpenZeppelin's ERC20, Ownable, and ERC20Burnable contracts.

**Contract Overview**

The Degen Token contract allows users to mint, transfer, and burn tokens. It also has a unique feature that enables users to redeem tokens for in-game items.

**Functions**

### 1. `mint(address to, uint256 amount)`

Only the contract owner can call this function to mint a specified amount of DGN tokens to a given address.

### 2. `decimals()`

Overrides the default ERC20 `decimals()` function to return 0, indicating that the token has no decimal places.

### 3. `getBalance()`

Returns the balance of DGN tokens for the caller's address.

### 4. `transferTokens(address _receiver, uint256 _value)`

Allows users to transfer a specified amount of DGN tokens to another address.

### 5. `burnTokens(uint256 _value)`

Allows users to burn a specified amount of DGN tokens from their own balance.

### 6. `redeemTokens(ItemType _itemType)`

This function enables users to redeem DGN tokens for in-game items. Here's how it works:

* The user calls the `redeemTokens` function, specifying the type of item they want to redeem (e.g., TomeOfEXP, BagOfHealthPotions, etc.).
* The contract checks if the user has enough DGN tokens to cover the item's price, which is stored in the `itemPrices` mapping.
* If the user has sufficient tokens, the contract increments the user's inventory for the specified item type and burns the required amount of tokens from the user's balance.
* The contract logs a message indicating the successful redemption, including the item name and the amount of tokens redeemed.

**Redemption Process**

The redemption process involves the following steps:

1. The user calls `redeemTokens` with the desired item type.
2. The contract checks the user's balance and the item's price.
3. If the user has enough tokens, the contract updates the user's inventory and burns the required tokens.
4. The contract logs a success message.

**Item Types and Prices**

The contract defines four item types, each with a corresponding price in DGN tokens:

* TomeOfEXP: 50 DGN tokens
* BagOfHealthPotions: 20 DGN tokens
* BagOfManaPotions: 20 DGN tokens
* ElixirOfInvulnerability: 100 DGN tokens

**Inventory Management**

The contract uses a mapping `inventory` to store the user's inventory for each item type. When a user redeems tokens for an item, the contract increments the corresponding inventory value.

**Note**

This contract is for demonstration purposes only and should not be used in production without thorough testing and security audits.
