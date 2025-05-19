import '../models/module.dart';

class ModulesData {
  static List<Module> getModules() {
    return [
      Module(
        id: 1,
        title: "What is Bitcoin?",
        description: "Learn the basics of Bitcoin and cryptocurrency.",
        iconPath: "assets/images/bitcoin_intro.png",
        pointsReward: 50,
        badgeEarned: "Bitcoin Novice",
        lessonContent: [
          LessonContent(
            title: "Introduction to Bitcoin",
            content: "Bitcoin is a decentralized digital currency created in 2009 by an unknown person or group using the pseudonym Satoshi Nakamoto. Unlike traditional currencies issued by governments (fiat money), Bitcoin operates on a peer-to-peer network without a central authority or banks managing transactions.\n\nThe key innovation of Bitcoin is its use of blockchain technology, which is a distributed ledger that records all transactions across a network of computers. This makes Bitcoin transactions transparent and resistant to fraud or manipulation.",
            imagePath: "assets/images/bitcoin_blockchain.jpg",
          ),
          LessonContent(
            title: "Why Bitcoin Matters",
            content: "Bitcoin was created as a response to the 2008 financial crisis, which revealed flaws in the traditional banking system. It offers several advantages over conventional currencies:\n\n• Decentralization: No single entity controls Bitcoin\n• Limited supply: Only 21 million bitcoins will ever exist, making it resistant to inflation\n• Pseudonymity: Users can maintain some privacy in transactions\n• Global accessibility: Anyone with internet access can use Bitcoin\n• Lower transaction fees for international transfers",
            imagePath: "assets/images/bitcoin_advantages.jpg",
          ),
        ],
        quizzes: [
          Quiz(
            question: "Who created Bitcoin?",
            options: [
              "Satoshi Nakamoto",
              "Vitalik Buterin",
              "Elon Musk",
              "Mark Zuckerberg"
            ],
            correctAnswerIndex: 0,
          ),
          Quiz(
            question: "What is the maximum number of bitcoins that will ever exist?",
            options: [
              "1 million",
              "21 million",
              "100 million",
              "Unlimited"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "What technology does Bitcoin use to record transactions?",
            options: [
              "Cloud computing",
              "Artificial intelligence",
              "Blockchain",
              "Quantum computing"
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),

      Module(
        id: 2,
        title: "How Bitcoin Transactions Work",
        description: "Understand the mechanics of Bitcoin transactions and the blockchain.",
        iconPath: "assets/images/bitcoin_transaction.jpg",
        pointsReward: 75,
        badgeEarned: "Transaction Expert",
        lessonContent: [
          LessonContent(
            title: "Anatomy of a Bitcoin Transaction",
            content: "A Bitcoin transaction is essentially a transfer of value between Bitcoin wallets. Each transaction is broadcast to the network and collected into blocks that form the blockchain.\n\nWhen you send bitcoin, you're creating a message that includes:\n• Input: Reference to bitcoin you've previously received\n• Amount: How much bitcoin you're sending\n• Output: The recipient's Bitcoin address\n• Digital signature: Proof that you own the bitcoin being sent",
            imagePath: "assets/images/transaction_anatomy.jpg",
          ),
          LessonContent(
            title: "Blockchain Verification",
            content: "Once your transaction is broadcast to the network, it enters the 'mempool' (memory pool) where it waits to be verified by miners. Miners group multiple transactions into blocks and solve complex mathematical puzzles to add these blocks to the blockchain.\n\nAfter a block is added to the blockchain, the transaction receives one 'confirmation.' Each subsequent block added provides an additional confirmation, making the transaction increasingly secure and irreversible. Most exchanges and services consider a transaction secure after 6 confirmations.",
            imagePath: "assets/images/blockchain_verification.jpg",
          ),
        ],
        quizzes: [
          Quiz(
            question: "What does a Bitcoin transaction include?",
            options: [
              "Only the recipient's address",
              "Input, amount, output, and digital signature",
              "Only the sender's private key",
              "The sender's bank account details"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "How many confirmations are typically considered secure for a Bitcoin transaction?",
            options: [
              "1 confirmation",
              "3 confirmations",
              "6 confirmations",
              "21 confirmations"
            ],
            correctAnswerIndex: 2,
          ),
          Quiz(
            question: "What is the 'mempool' in Bitcoin?",
            options: [
              "A type of Bitcoin wallet",
              "A pool where unconfirmed transactions wait to be verified",
              "A collection of mining hardware",
              "Bitcoin's programming language"
            ],
            correctAnswerIndex: 1,
          ),
        ],
      ),

      Module(
        id: 3,
        title: "What is a Wallet and a Private Key?",
        description: "Learn about Bitcoin wallets and the importance of private keys.",
        iconPath: "assets/images/bitcoin_wallet.jpg",
        pointsReward: 75,
        badgeEarned: "Wallet Master",
        lessonContent: [
          LessonContent(
            title: "Understanding Bitcoin Wallets",
            content: "A Bitcoin wallet is not actually a physical or digital container that stores your bitcoin. Instead, it's software that stores your private keys, which are needed to access your Bitcoin address and sign transactions.\n\nYour bitcoin are actually stored on the blockchain, and your wallet gives you the ability to access and manage them. There are several types of wallets:\n\n• Software wallets: Desktop, mobile, or web applications\n• Hardware wallets: Physical devices designed for secure key storage\n• Paper wallets: Physical documents containing keys and QR codes\n• Brain wallets: Memorized passphrases that generate keys",
            imagePath: "assets/images/wallet_types.png",
          ),
          LessonContent(
            title: "Private Keys: The Ultimate Control",
            content: "A private key is a secret, alphanumeric password that allows bitcoins to be spent. Your wallet generates and stores private keys for you, and uses them to sign transactions when you want to send bitcoin.\n\nThe relationship between your private key and Bitcoin address is like that between a password and username. Your Bitcoin address (derived from your public key) can be shared freely, but your private key must be kept secret.\n\nThe critical rule of Bitcoin: 'Not your keys, not your coins.' If you don't control your private keys (as with some exchange wallets), you don't truly own your bitcoin.",
            imagePath: "assets/images/private_key.png",
          ),
        ],
        quizzes: [
          Quiz(
            question: "What does a Bitcoin wallet actually store?",
            options: [
              "Bitcoin coins",
              "Private keys",
              "The blockchain",
              "Mining equipment"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "What is the famous rule about private keys in Bitcoin?",
            options: [
              "Private keys should be shared with friends",
              "Not your keys, not your coins",
              "Keys expire after one year",
              "Keys should be changed monthly"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "Which of these is a physical Bitcoin wallet device?",
            options: [
              "Software wallet",
              "Web wallet",
              "Brain wallet",
              "Hardware wallet"
            ],
            correctAnswerIndex: 3,
          ),
        ],
      ),

      Module(
        id: 4,
        title: "How Mining Works",
        description: "Discover the process of Bitcoin mining and its importance to the network.",
        iconPath: "assets/images/bitcoin_mining.png",
        pointsReward: 100,
        badgeEarned: "Mining Expert",
        lessonContent: [
          LessonContent(
            title: "The Purpose of Mining",
            content: "Bitcoin mining serves two essential purposes in the Bitcoin network:\n\n1. It verifies transactions and adds them to the blockchain\n2. It introduces new bitcoins into circulation (the mining reward)\n\nMiners compete to solve complex mathematical problems (proof-of-work). The first to solve the problem gets to add a new block to the blockchain and receives a reward in bitcoin.",
            imagePath: "assets/images/bitcoin_mining.jpg",
          ),
          LessonContent(
            title: "Mining Process and Equipment",
            content: "The mining process involves:\n\n1. Collecting unconfirmed transactions into a block\n2. Computing a block header that includes a timestamp, nonce, and hash of previous block\n3. Attempting to find a nonce value that, when hashed, produces a result below a target threshold\n4. Once found, broadcasting the block to the network\n\nOriginally, Bitcoin could be mined using ordinary computers, but today specialized hardware called ASICs (Application-Specific Integrated Circuits) are required to mine profitably. Mining operations now often take place in large facilities with access to cheap electricity and cooling systems.",
            //imagePath: "assets/images/mining_process.png",
          ),
          LessonContent(
            title: "Mining Difficulty and Rewards",
            content: "The Bitcoin protocol automatically adjusts the mining difficulty every 2016 blocks (approximately two weeks) to maintain an average block time of 10 minutes.\n\nThe mining reward started at 50 BTC per block in 2009 and halves approximately every four years (every 210,000 blocks) in an event called 'the halving.' As of 2025, the reward is 3.125 BTC per block.\n\nEventually, the reward will decrease to zero, and all 21 million bitcoins will have been mined. After that, miners will be incentivized solely by transaction fees.",
            //imagePath: "assets/images/mining_difficulty.png",
          ),
        ],
        quizzes: [
          Quiz(
            question: "What are the two main purposes of Bitcoin mining?",
            options: [
              "Making miners rich and increasing inflation",
              "Verifying transactions and introducing new bitcoins",
              "Hacking the network and creating new addresses",
              "Securing private keys and changing algorithms"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "What is the current mining reward per block as of 2025?",
            options: [
              "50 BTC",
              "6.25 BTC",
              "3.125 BTC",
              "0 BTC"
            ],
            correctAnswerIndex: 2,
          ),
          Quiz(
            question: "How often does Bitcoin's mining difficulty adjust?",
            options: [
              "Every 10 minutes",
              "Every 2016 blocks (approximately two weeks)",
              "Every halving (approximately four years)",
              "It never adjusts"
            ],
            correctAnswerIndex: 1,
          ),
          Quiz(
            question: "What type of specialized hardware is used for Bitcoin mining today?",
            options: [
              "Regular laptops",
              "Gaming computers",
              "ASICs (Application-Specific Integrated Circuits)",
              "Smartphones"
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ];
  }
}
