// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getprice(
        AggregatorV3Interface S_priceFeed
    ) internal view returns (uint256) {
        AggregatorV3Interface Pricefeed = AggregatorV3Interface(S_priceFeed);
        (, int256 price, , , ) = Pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getconversionrate(
        uint256 ethamount,
        AggregatorV3Interface S_priceFeed
    ) internal view returns (uint256) {
        uint256 ethprice = getprice(S_priceFeed);
        uint256 ethamountinUSD = (ethprice * ethamount) / 1e18;
        return ethamountinUSD;
    }
}
