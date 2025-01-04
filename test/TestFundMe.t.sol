// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    DeployFundMe deployfundme = new DeployFundMe();


    function setUp() external {
        fundMe = deployfundme.run();
    }

    function testMINIMUM_USDisFive() external view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testMEG_sender_is_Owner() external view {
        assertEq(fundMe.Owner(), msg.sender);
    }
}
