// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

error NotOwner();

contract FundMe {
    address public immutable Owner;
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    AggregatorV3Interface private S_PriceFeed;

    address[] private funders;
    mapping(address => uint) private addressToAmountFunded;

    constructor(address PriceFeedAddress) payable {
        Owner = msg.sender;
        S_PriceFeed = AggregatorV3Interface(PriceFeedAddress);
    }

    function fund() public payable {
        require(
            msg.value.getconversionrate(S_PriceFeed) >= MINIMUM_USD,
            "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function Withdraw() public payable Owneronly {
        uint256 FundersLength = funders.length;

        for (
            uint256 funderIndex = 0;
            funderIndex < FundersLength;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    modifier Owneronly() {
        if (msg.sender != Owner) revert NotOwner();
        _;
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    function getAddressTOAmountFunded(
        address fundersaddress
    ) external view returns (uint256) {
        return (addressToAmountFunded[fundersaddress]);
    }

    function getFunder(uint256 FundersIndex) external view returns (address) {
        return (funders[FundersIndex]);
    }
}
