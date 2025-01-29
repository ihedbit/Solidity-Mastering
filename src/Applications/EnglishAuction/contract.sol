// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EnglishAuction
 * @dev Implements an English auction where bids increase incrementally, and the highest bidder wins.
 */
contract EnglishAuction {
    address public seller;
    address public highestBidder;
    uint256 public highestBid;
    uint256 public auctionEndTime;
    uint256 public bidIncrement;
    bool public auctionEnded;

    mapping(address => uint256) public pendingReturns;

    event AuctionStarted(uint256 endTime);
    event NewHighestBid(address indexed bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);
    event BidWithdrawn(address indexed bidder, uint256 amount);

    modifier onlyBeforeEnd() {
        require(block.timestamp < auctionEndTime, "Auction already ended");
        _;
    }

    modifier onlyAfterEnd() {
        require(block.timestamp >= auctionEndTime, "Auction still ongoing");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Only the seller can perform this action");
        _;
    }

    constructor(uint256 _duration, uint256 _startingBid, uint256 _bidIncrement) {
        seller = msg.sender;
        highestBid = _startingBid;
        bidIncrement = _bidIncrement;
        auctionEndTime = block.timestamp + _duration;
        
        emit AuctionStarted(auctionEndTime);
    }

    /**
     * @dev Place a bid in the auction.
     */
    function placeBid() external payable onlyBeforeEnd {
        require(msg.value >= highestBid + bidIncrement, "Bid must be higher than current highest bid + increment");

        if (highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid; // Refund the previous highest bidder
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

        emit NewHighestBid(msg.sender, msg.value);
    }

    /**
     * @dev Withdraw a previous bid if it was outbid.
     */
    function withdrawBid() external {
        uint256 amount = pendingReturns[msg.sender];
        require(amount > 0, "No pending returns available");

        pendingReturns[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit BidWithdrawn(msg.sender, amount);
    }

    /**
     * @dev End the auction and send funds to the seller.
     */
    function endAuction() external onlySeller onlyAfterEnd {
        require(!auctionEnded, "Auction has already been ended");

        auctionEnded = true;
        if (highestBidder != address(0)) {
            payable(seller).transfer(highestBid);
            emit AuctionEnded(highestBidder, highestBid);
        } else {
            revert("No valid bids received");
        }
    }

    /**
     * @dev Get the remaining auction time.
     */
    function getRemainingTime() external view returns (uint256) {
        if (block.timestamp >= auctionEndTime) {
            return 0;
        }
        return auctionEndTime - block.timestamp;
    }

    /**
     * @dev Check if the auction has ended.
     */
    function hasAuctionEnded() external view returns (bool) {
        return block.timestamp >= auctionEndTime;
    }
}

