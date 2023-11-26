// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) balances;
    uint256 constant minimumBalance = 1 ether; // Minimum balance set to 1 ETH

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount should be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount should be greater than 0");
        require(balances[msg.sender] - amount >= minimumBalance, "Minimum balance should be maintained");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address to, uint256 amount) public {
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Transfer amount should be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function checkBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}

      