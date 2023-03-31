//SPDX-License-Identifier: GPL - 3.0
pragma solidity >=0.5.0 <0.9.0;

contract token{
    address public manager;
    address payable[] public customer;

    constructor()
    {
        manager = msg.sender; //global variable
    }

    receive() external payable{
        require(msg.value==1 ether);
        customer.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, customer.length)));
    }

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