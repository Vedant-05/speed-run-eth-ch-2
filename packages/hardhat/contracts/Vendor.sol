pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  YourToken public yourToken;

  uint256 public constant  tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:

  function buyTokens() payable public {

    uint toBeSentValue = msg.value * tokensPerEth;

    yourToken.transfer(msg.sender, toBeSentValue);

    emit BuyTokens(msg.sender, msg.value, toBeSentValue);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH

  function withdraw() public onlyOwner(){
     address payable to = payable(msg.sender);
     to.transfer(address(this).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:

  function sellTokens(uint256 _amount) public {
    yourToken.transferFrom(msg.sender, address(this), _amount);
    payable(msg.sender).transfer(_amount / tokensPerEth);
    emit SellTokens(msg.sender, _amount, _amount / tokensPerEth);

  }
}
