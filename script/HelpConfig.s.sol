// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HelpConfig {
    struct NetworkConfig {
        address PriceFeed;
    }

    NetworkConfig public ActiveNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            ActiveNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 80001) {
            ActiveNetworkConfig = getPoly_AmoyEthConfig();
        } else {
            ActiveNetworkConfig = getPoly_AmoyEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function getPoly_AmoyEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        return NetworkConfig(0xF0d50568e3A7e8259E16663972b11910F89BD8e7);
    }
}
