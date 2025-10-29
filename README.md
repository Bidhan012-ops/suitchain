<img width="1371" height="920" alt="Screenshot 2025-10-29 144041" src="https://github.com/user-attachments/assets/f194a0f0-614b-46b1-bf58-62fbc5c7d979" />
# 🎴 On-Chain Card Suit Guessing Game  

### 🧠 A Beginner-Friendly Blockchain Game Built with Solidity  

---

## 🧩 **Project Description**

The **Card Suit Guessing Game** is a simple **on-chain Ethereum/Celo smart contract** designed for beginners to understand how blockchain randomness, events, and Ether transfers work.  

In this game, you **guess a card suit** — Clubs, Diamonds, Hearts, or Spades — and if your guess matches the randomly generated suit, you **win double your money! 💰**

⚠️ **Disclaimer:** The randomness used here is **not cryptographically secure** and should be used **for learning purposes only**.

---

## 🚀 **What It Does**

1. A player calls the `guessSuit()` function and sends a small amount of Ether (minimum `0.001 ETH`).  
2. The smart contract generates a **pseudo-random suit** using on-chain data.  
3. If the player's guess matches the generated suit, they win **2× their bet** instantly.  
4. The game result is permanently stored on-chain for full transparency.  

---

## 🌟 **Features**

✅ Simple and Beginner-Friendly Solidity Code  
✅ On-Chain Game Logic — No Backend Needed  
✅ Real ETH Transfers on Win/Loss  
✅ Public Game History Stored on Blockchain  
✅ Owner Withdrawal and Fund Deposit Functions  
✅ Deployed on the **Celo Sepolia Testnet**

---

## 🧱 **Smart Contract Information**

- **Network:** Celo Sepolia Testnet  
- **Deployed Contract:** [0xB6B51F84813E3FEb70772Aa6ba9de97556ace2Fc](https://celo-sepolia.blockscout.com/address/0xB6B51F84813E3FEb70772Aa6ba9de97556ace2Fc)  
- **Deployment Transaction:** [View on Blockscout](https://celo-sepolia.blockscout.com/tx/0x3067757d0beb26ee13bfd88c2fad8d78e0a5842caee6bdb8ce2210ac89370ea8)  
- **Play Fee:** `0.001 ETH`  
- **Reward Multiplier:** `2x`  
- **Language:** Solidity ^0.8.0  
- **License:** MIT  

---

## ⚙️ **Contract Code**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * Simple On-Chain Card Suit Guessing Game (Beginner version)
 * ----------------------------------------------------------
 * 0 = Clubs, 1 = Diamonds, 2 = Hearts, 3 = Spades
 * 
 * - You call `guessSuit(uint8 suit)` and send some Ether.
 * - The contract generates a pseudo-random suit using block data.
 * - If your guess matches, you win double your money.
 * - Owner can withdraw leftover funds.
 * 
 * ⚠️ Note: This randomness is NOT secure — for learning only.
 */

contract CardSuitGuessGame {
    address public owner;
    uint256 public playFee = 0.001 ether;
    uint256 public winMultiplier = 2;

    struct Game {
        address player;
        uint8 guessedSuit;
        uint8 actualSuit;
        bool won;
        uint256 amount;
    }

    Game[] public gameHistory;

    event GamePlayed(address indexed player, uint8 guess, uint8 actualSuit, bool won, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function guessSuit(uint8 suit) public payable {
        require(suit <= 3, "Invalid suit (0-3)");
        require(msg.value >= playFee, "Insufficient play fee");

        // ⚠️ pseudo-random: NOT secure, but works for testing
        uint8 randomSuit = uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number - 1)))) % 4);

        bool won = (suit == randomSuit);
        uint256 payout = 0;

        if (won) {
            payout = msg.value * winMultiplier;
            require(address(this).balance >= payout, "Contract balance low");
            payable(msg.sender).transfer(payout);
        }

        gameHistory.push(Game(msg.sender, suit, randomSuit, won, payout));

        emit GamePlayed(msg.sender, suit, randomSuit, won, payout);
    }

    function getGameHistoryLength() public view returns (uint256) {
        return gameHistory.length;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= address(this).balance, "Not enough balance");
        payable(owner).transfer(amount);
    }

    // Deposit funds to the contract so players can win rewards
    receive() external payable {}

    // Helper to get suit name
    function suitName(uint8 suit) public pure returns (string memory) {
        if (suit == 0) return "Clubs";
        if (suit == 1) return "Diamonds";
        if (suit == 2) return "Hearts";
        if (suit == 3) return "Spades";
        return "Unknown";
    }
}
<img width="1371" height="920" alt="Screenshot 2025-10-29 144041" src="https://github.com/user-attachments/assets/f9ec13c8-db06-4f98-9b98-a85ded5b0502" />
