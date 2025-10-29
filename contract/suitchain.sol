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

