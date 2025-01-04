// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address Most_Recent_Depeloyment) public {
        vm.startBroadcast();
        FundMe(payable(Most_Recent_Depeloyment)).fund{value: SEND_VALUE};
        console.log("Funded FundMe with %s", SEND_VALUE);
        vm.stopBroadcast();
    }

    function run() external {
        address Most_recent_Address = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(Most_recent_Address);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address Most_Recent_Depeloyment) public {
        vm.startBroadcast();
        FundMe(payable(Most_Recent_Depeloyment)).Withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address Most_recent_Address = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(Most_recent_Address);
    }
}
