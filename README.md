![Uploading image.png…]()




contract add = 0xb6b51f84813e3feb70772aa6ba9de97556ace2fc


🎴 On-Chain Card Suit Guessing Game
Smart Contract Address: 0xb6b51f84813e3feb70772aa6ba9de97556ace2fc

🧩 Overview
This is a simple on-chain guessing game built with Solidity for beginners learning smart contract development.
You can guess a card suit — Clubs, Diamonds, Hearts, or Spades — and if your guess matches the randomly generated one, you win double your money! 💰
⚠️ Note: This project uses pseudo-randomness from block data, which is not secure for production.
It’s intended for learning and experimentation only.

💡 How It Works


You call the function guessSuit(uint8 suit) and send at least 0.001 ETH.


Suits are represented as:


0 = Clubs


1 = Diamonds


2 = Hearts


3 = Spades






The contract generates a pseudo-random suit using:
keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number - 1)))



If your guess matches the random result:


You win 2× your bet amount!


Ether is instantly sent back to your wallet.




All game results are stored on-chain in gameHistory.



🧱 Smart Contract Details
FieldDescriptionNetworkEthereum (Testnet/Custom Network)Contract Address0xb6b51f84813e3feb70772aa6ba9de97556ace2fcPlay Fee0.001 ETH minimumReward Multiplier2×OwnerThe deployer of the contractLanguageSolidity ^0.8.0LicenseMIT

⚙️ Functions
🎮 guessSuit(uint8 suit)
Play the game by guessing a suit (0–3).
You must send at least 0.001 ETH along with the transaction.


Input: Suit number (0–3)


Output: Emits an event GamePlayed


Example (Remix or Web3 call):
await contract.guessSuit(2, { value: ethers.utils.parseEther("0.001") });


🧾 getGameHistoryLength()
Returns the total number of games played.

💸 withdraw(uint256 amount)
Allows the owner to withdraw funds from the contract balance.

💰 receive() external payable
Lets anyone deposit ETH into the contract to ensure there’s enough for payouts.

♠️ suitName(uint8 suit)
Returns the name of the suit as a string.
Example:
await contract.suitName(3); // "Spades"


🧠 Example Gameplay
PlayerGuessActualResultPayout0x1234…Hearts (2)Hearts (2)✅ Won0.002 ETH0x5678…Clubs (0)Spades (3)❌ Lost0 ETH

🚀 Deployment Info


Deployed by: Bidhan Bera


Contract Address: 0xb6b51f84813e3feb70772aa6ba9de97556ace2fc


Compiler: Solidity 0.8.0+


License: MIT



⚠️ Disclaimer
This project is for educational purposes only.
The random number generation method used here is not secure and should not be used in real-money or mainnet environments.

💬 Author
👤 Bidhan Bera
💻 Beginner Blockchain Developer | Exploring Solidity & Web3
🔗 LinkedIn Profile

Would you like me to format this as a downloadable README.md file for your GitHub repo?
