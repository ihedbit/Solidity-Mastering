// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DutchAuction
 * @dev Implements a Dutch auction where prices decrease over time until a buyer is found.
 */
contract DutchAuction {
    address payable public seller;
    uint256 public startingPrice;
    uint256 public reservePrice;
    uint256 public auctionStartTime;
    uint256 public duration;
    uint256 public priceDropInterval;
    uint256 public priceDropAmount;
    bool public auctionEnded;

    event AuctionStarted(uint256 startingPrice, uint256 reservePrice, uint256 duration);
    event AuctionSuccessful(address indexed buyer, uint256 finalPrice);
    event AuctionCancelled();

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can perform this action");
        _;
    }

    modifier auctionActive() {
        require(!auctionEnded, "Auction has ended");
        _;
    }

    constructor(
        uint256 _startingPrice,
        uint256 _reservePrice,
        uint256 _duration,
        uint256 _priceDropInterval,
        uint256 _priceDropAmount
    ) {
        require(_startingPrice > _reservePrice, "Starting price must be greater than reserve price");
        require(_duration > 0, "Auction duration must be greater than zero");
        require(_priceDropInterval > 0, "Price drop interval must be greater than zero");

        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        reservePrice = _reservePrice;
        auctionStartTime = block.timestamp;
        duration = _duration;
        priceDropInterval = _priceDropInterval;
        priceDropAmount = _priceDropAmount;

        emit AuctionStarted(_startingPrice, _reservePrice, _duration);
    }

    /**
     * @dev Returns the current price of the auction based on elapsed time.
     */
    function getCurrentPrice() public view auctionActive returns (uint256) {
        uint256 elapsedTime = block.timestamp - auctionStartTime;
        uint256 decrements = elapsedTime / priceDropInterval;
        uint256 totalDrop = decrements * priceDropAmount;

        if (startingPrice > totalDrop) {
            uint256 currentPrice = startingPrice - totalDrop;
            return currentPrice > reservePrice ? currentPrice : reservePrice;
        } else {
            return reservePrice;
        }
    }

    /**
     * @dev Allows a buyer to purchase the item at the current price.
     */
    function buy() external payable auctionActive {
        uint256 currentPrice = getCurrentPrice();
        require(msg.value >= currentPrice, "Insufficient payment");

        auctionEnded = true;
        seller.transfer(currentPrice);

        if (msg.value > currentPrice) {
            payable(msg.sender).transfer(msg.value - currentPrice);
        }

        emit AuctionSuccessful(msg.sender, currentPrice);
    }

    /**
     * @dev Allows the seller to cancel the auction before it ends.
     */
    function cancelAuction() external onlySeller auctionActive {
        auctionEnded = true;
        emit AuctionCancelled();
    }

    /**
     * @dev Checks if the auction has expired.
     */
    function hasAuctionExpired() public view returns (bool) {
        return block.timestamp >= auctionStartTime + duration;
    }
}
