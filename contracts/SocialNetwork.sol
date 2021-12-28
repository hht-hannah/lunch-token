//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./LunchToken.sol";
import "./LunchFactory.sol";

contract SocialNetwork is LunchFactory {
    struct Person {
        string name;
        uint256 accountBalance;
        address personalAddress;
    }

    mapping (address => Person[]) public friendsMap;

    function addFriend(address _owner,address _friend,string memory name) public{
        require(_owner!=_friend,"wrong friend address");

        friendsMap[_owner].push(Person(name,balanceOf(_friend),_friend));
    }

    function getFriends(address _owner) public view returns(Person[] memory){
        return friendsMap[_owner];
    }

    function deleteFriend(address _owner,address _friend) public{
        require(_owner!=_friend,"wrong friend address");
        uint size = friendsMap[_owner].length;
        for(uint i=0;i<size;i++){
            if(friendsMap[_owner][i].personalAddress==_friend){
                for(uint j = i; j < size -1; j++){
                    friendsMap[_owner][j] = friendsMap[_owner][j+1];
                }
                delete friendsMap[_owner][size - 1];
                size--;
            }
        }
    }


    function createLunchEventAmongAllFriends(uint256 totalAmount, string memory date,address _owner) public{
        address[] memory accounts = new address[](friendsMap[_owner].length);
        for(uint i=0;i<friendsMap[_owner].length;i++){
            accounts[i]=friendsMap[_owner][i].personalAddress;
        }
        createLunchEvent(totalAmount,date,accounts);
    }

    function createLunchEventAmongSelectedFriends(uint64 totalAmount, string memory date, address[] memory accounts) public{
        createLunchEvent(totalAmount,date,accounts);
    }
}