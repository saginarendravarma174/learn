pragma solidity ^0.8.0;

contract HardPuzzle {
    uint256 public secret;
    address public winner;
    
    constructor(uint256 _secret) payable {
        require(msg.value == 1 ether, "Send 1 ETH");
        secret = _secret;
    }
    
    function solve(uint256 _guess) external {
        require(winner == address(0), "Already solved");
        require(uint256(keccak256(abi.encodePacked(block.timestamp, _guess))) == secret, "Wrong guess");
        winner = msg.sender;
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send ETH");
    }
}
