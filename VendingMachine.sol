pragma solidity ^0.8.0;

contract VendingMachine {


    address public owner;
    mapping(address => uint) public drinks;
    uint public drinkBal;

    constructor() {
        owner = msg.sender;
        drinks[address(this)] = 100;
        drinkBal = 100;
    }

    function topUp(uint amt) public {
        require(msg.sender == owner, "Only owner is allowed");
        drinks[address(this)] += amt;
        drinkBal += amt;
    }

    function buyDrink(uint amt) public payable {
        require(msg.value >= amt * 1 ether, "You must pay at least 1 ETH per drink");
        require(drinks[address(this)] >= amt, "Not enough stock");
        drinks[address(this)] -= amt;
        drinks[msg.sender] += amt;
        drinkBal -= amt;
    }

    function getDrink() public {
        require(drinks[msg.sender] >= 1, "You dont have");
        drinks[msg.sender] -= 1;
        drinkBal -= 1;
    }


    function checkMachineBalance() public view returns (uint256) {
        require(msg.sender == owner, "Only owner can check balance");

        return address(this).balance;
    }



}
