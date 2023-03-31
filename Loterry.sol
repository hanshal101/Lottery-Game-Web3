//SPDX-License-Identifier: GPL - 3.0
pragma solidity >=0.5.0 <0.9.0;

contract token{
    address public manager;
    address payable[] public customer;

    constructor()
    {
        manager = msg.sender; //global variable
    }


    //Get minimum ether value of 1

    receive() external payable{
        require(msg.value==1 ether);
        customer.push(payable(msg.sender));
    }

    //Require only works for the account which is declared - here its the manager account

    function getBalance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }

    //Getting a random hash using prebuilt library 'keccak256' 

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, customer.length)));
    }


     //Lets get the Winner now and transfer all the money to it
    function getWinner() public 
    {
        require(msg.sender==manager);
        require(customer.length>=3);
        uint r = random();
        address payable Winner;
        uint index = r % customer.length;
        Winner=customer[index];
        Winner.transfer(getBalance());
        customer= new address payable [](0);
        }
}