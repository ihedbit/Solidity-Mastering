// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract EnglishAuctionTest is Test {
    EnglishAuction private auction;
    address private seller;
    address private bidder1;
    address private bidder2;
    uint256 private startBid = 1 ether;
    uint256 private bidIncrement = 0.1 ether;
    uint256 private auctionDuration = 3600; // 1 hour

    function setUp() public {
        // Define test actors
        seller = address(0x1);
        bidder1 = address(0x2);
        bidder2 = address(0x3);

        // Fund bidders
        vm.deal(bidder1, 10 ether);
        vm.deal(bidder2, 10 ether);

        // Deploy the auction contract with seller as msg.sender
        vm.prank(seller);
        auction = new EnglishAuction(auctionDuration, startBid, bidIncrement);
    }

    function testInitialAuctionState() public view {
        assertEq(auction.seller(), seller, "Seller should be set correctly");
        assertEq(auction.highestBid(), startBid, "Starting bid should be set correctly");
        assertEq(auction.auctionEnded(), false, "Auction should not be ended at start");
    }

    function testPlaceValidBid() public {
        vm.prank(bidder1);
        auction.placeBid{value: startBid + bidIncrement}();

        assertEq(auction.highestBidder(), bidder1, "Bidder1 should be the highest bidder");
        assertEq(auction.highestBid(), startBid + bidIncrement, "Highest bid should be updated");
    }

    function testFailPlaceLowerBid() public {
        vm.prank(bidder1);
        auction.placeBid{value: startBid}(); // ❌ Should fail because bid is not higher than (startBid + increment)
    }

    function testOutbidAndWithdraw() public {
        // Bidder1 places a valid bid
        vm.prank(bidder1);
        auction.placeBid{value: startBid + bidIncrement}();

        // Bidder2 places a higher bid
        vm.prank(bidder2);
        auction.placeBid{value: startBid + 2 * bidIncrement}();

        // Check new highest bid
        assertEq(auction.highestBidder(), bidder2, "Bidder2 should be the highest bidder");
        assertEq(auction.highestBid(), startBid + 2 * bidIncrement, "Highest bid should be updated");

        // Bidder1 should have pending returns
        assertEq(auction.pendingReturns(bidder1), startBid + bidIncrement, "Bidder1 should have pending return");

        // Bidder1 withdraws the bid
        vm.prank(bidder1);
        auction.withdrawBid();

        // Ensure pending return is cleared
        assertEq(auction.pendingReturns(bidder1), 0, "Bidder1 should have no pending returns");
    }

    function testEndAuction() public {
        // Place a valid bid before the auction ends
        vm.prank(bidder1);
        auction.placeBid{value: startBid + bidIncrement}();

        // Fast-forward time to **after** the auction duration
        vm.warp(block.timestamp + auctionDuration + 1);
        assertTrue(auction.hasAuctionEnded(), "Auction should be expired before ending");

        // Ensure only the seller can end the auction
        vm.prank(seller);
        auction.endAuction();

        // Validate the auction state
        assertTrue(auction.auctionEnded(), "Auction should be ended");
    }




    function testFailEndAuctionBeforeTime() public {
        vm.prank(seller);
        auction.endAuction(); // ❌ Should fail because auction is not expired yet
    }

    function testGetRemainingTime() public {
        uint256 timeRemainingBefore = auction.getRemainingTime();
        vm.warp(block.timestamp + 1800); // Move forward 30 minutes
        uint256 timeRemainingAfter = auction.getRemainingTime();

        assertGt(timeRemainingBefore, timeRemainingAfter, "Time remaining should decrease over time");
    }

    function testHasAuctionEnded() public {
        assertFalse(auction.hasAuctionEnded(), "Auction should not be ended at start");

        vm.warp(block.timestamp + auctionDuration + 1);
        assertTrue(auction.hasAuctionEnded(), "Auction should be ended after time expires");
    }
}
