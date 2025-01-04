// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "./HelpConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelpConfig helpconfig = new HelpConfig();
        address ETHPriceFeed = helpconfig.ActiveNetworkConfig();

        vm.startBroadcast();
        FundMe fundme = new FundMe(ETHPriceFeed);
        vm.stopBroadcast();
        return fundme;
    }
}
