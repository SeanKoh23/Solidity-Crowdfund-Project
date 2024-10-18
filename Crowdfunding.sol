// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Crowdfunding {
    address public owner;
    string public name;
    uint256 public targetFunds;
    uint256 public deadline;
    uint256 public totalContributions;
    bool public isFunded;
    bool public isWithdrawn;
    mapping(address => uint256) public funders;

    event Funded(address _funder, uint256 _amount);
    event OwnerWithdraw(uint256 _amount);
    event FunderWithdraw(address _funded, uint256 _amount);

    constructor(string memory _name, uint256 _targetFunds, uint256 _deadline) {
        owner = msg.sender;
        name = _name;
        targetFunds = _targetFunds;
        deadline = block.timestamp + _deadline;
    }

    function fund() public payable {
        require(isFundEnabled() == true, "Funding is currently disabled");
        require(msg.value > 0, "Funding amount must be greater than zero");

        funders[msg.sender] += msg.value;
        totalContributions += msg.value;
        emit Funded(msg.sender, msg.value);
    }

    function withdrawOwner() public {
        require(msg.sender == owner, "Not authorised");
        require(isFundSuccess() == true, "Goal not met, unable to withdraw");

        uint256 amountToSend = address(this).balance;
        (bool success,) = msg.sender.call{value: amountToSend}("");
        require(success, "Unable to send");
        isWithdrawn = true;
        emit OwnerWithdraw(amountToSend);
    }

    function withdrawFunder() public {
        require(isFundEnabled() == false && isFundSuccess() == false, "Unable to withdraw. Crowdfunding is either still ongoing or goal has been met");
        
        uint256 amountToSend = funders[msg.sender];
        require(amountToSend > 0, "No funds to withdraw");
        funders[msg.sender] = 0;
        (bool success,) = msg.sender.call{value: amountToSend}("");
        require(success, "Unable to send");

        emit FunderWithdraw(msg.sender, amountToSend);
    }

    function isFundEnabled() public view returns(bool) {
        if (block.timestamp > deadline || isWithdrawn) {
            return false;
        } else {
            return true;
        }
    }

    function isFundSuccess() public view returns(bool) {
        if(address(this).balance >= targetFunds && !isWithdrawn) {
            return true;
        } else {
            return false;
        }
    }
}