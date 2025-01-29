// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract DutchAuctionTest is Test {
    DutchAuction private auction;
    address payable private seller;
    address payable private buyer;
    uint256 private startingPrice = 10 ether;
    uint256 private reservePrice = 2 ether;
    uint256 private duration = 3600; // 1 hour
    uint256 private priceDropInterval = 600; // Every 10 minutes
    uint256 private priceDropAmount = 1 ether;

    function setUp() public {
        // Assign test addresses
        seller = payable(address(0x1234));
        buyer = payable(address(0x5678));

        // Fund the buyer
        vm.deal(buyer, 20 ether);

        // Deploy the contract from seller's address
        vm.prank(seller);
        auction = new DutchAuction(startingPrice, reservePrice, duration, priceDropInterval, priceDropAmount);
    }

    function testAuctionInitialization() public view {
        assertEq(auction.seller(), seller, "Incorrect seller address");
        assertEq(auction.startingPrice(), startingPrice, "Incorrect starting price");
        assertEq(auction.reservePrice(), reservePrice, "Incorrect reserve price");
        assertEq(auction.duration(), duration, "Incorrect duration");
        assertEq(auction.priceDropInterval(), priceDropInterval, "Incorrect price drop interval");
        assertEq(auction.priceDropAmount(), priceDropAmount, "Incorrect price drop amount");
        assertFalse(auction.auctionEnded(), "Auction should not be ended initially");
    }

    function testPriceDecreasesOverTime() public {
        uint256 initialPrice = auction.getCurrentPrice();
        assertEq(initialPrice, startingPrice, "Initial price should be the starting price");

        // Fast forward time by multiple intervals
        vm.warp(block.timestamp + priceDropInterval * 10); // 10 price drops

        uint256 priceAfterDrops = auction.getCurrentPrice();
        uint256 expectedPrice = startingPrice - (priceDropAmount * 10);

        if (expectedPrice < reservePrice) {
            expectedPrice = reservePrice; // Ensure it doesn't go below reserve price
        }

        assertEq(priceAfterDrops, expectedPrice, "Price should decrease correctly");

        // Fast forward to after auction expiration
        vm.warp(block.timestamp + duration);
        uint256 finalPrice = auction.getCurrentPrice();
        assertEq(finalPrice, reservePrice, "Price should not drop below reserve price");
    }


    function testSuccessfulPurchase() public {
        // Fast forward time so that price is at 7 ether
        vm.warp(block.timestamp + priceDropInterval * 3); // 3 intervals = 3 ether drop

        uint256 currentPrice = auction.getCurrentPrice();
        assertEq(currentPrice, 7 ether, "Price should be 7 ether after 3 intervals");

        // Buyer purchases at current price
        vm.prank(buyer);
        auction.buy{value: currentPrice}();

        // Ensure auction ended
        assertTrue(auction.auctionEnded(), "Auction should be marked as ended");
    }

    function testBuyRefundsExcessPayment() public {
        // Fast forward time so that price is at 6 ether
        vm.warp(block.timestamp + priceDropInterval * 4); // 4 intervals = 4 ether drop

        uint256 currentPrice = auction.getCurrentPrice();
        uint256 buyerInitialBalance = buyer.balance;

        vm.prank(buyer);
        auction.buy{value: 8 ether}(); // Buyer sends 8 ether, expecting 2 ether in refund

        uint256 buyerFinalBalance = buyer.balance;
        assertEq(buyerFinalBalance, buyerInitialBalance - currentPrice, "Buyer should receive correct refund");
    }

    function testCannotBuyWithInsufficientFunds() public {
        // Fast forward so price is at 6 ether
        vm.warp(block.timestamp + priceDropInterval * 4);

        uint256 currentPrice = auction.getCurrentPrice();

        vm.expectRevert("Insufficient payment");
        vm.prank(buyer);
        auction.buy{value: currentPrice - 1}(); // Sending less than required amount
    }

    function testAuctionCanBeCancelledBySeller() public {
        vm.prank(seller);
        auction.cancelAuction();

        assertTrue(auction.auctionEnded(), "Auction should be ended after cancellation");
    }

    function testNonSellerCannotCancelAuction() public {
        vm.expectRevert("Only seller can perform this action");
        vm.prank(buyer);
        auction.cancelAuction();
    }

    function testAuctionExpiration() public {
        vm.warp(block.timestamp + duration + 1); // Move past auction duration
        assertTrue(auction.hasAuctionExpired(), "Auction should be marked as expired");
    }
}
