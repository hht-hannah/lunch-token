
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./LunchToken.sol";

contract LunchFactory is LunchToken {
    event NewLunch(uint lunchId);
    event NewPending(uint pendingId);


    struct Lunch {
      uint256 totalAmount;
      string date;
    }

    struct Pending {
        Lunch lunch;
        uint256 amount;
        bool status;
    }

    Lunch[] public lunches;
    Pending[] public pendings;

    mapping (uint => address) public lunchToOwner;
    mapping (address => uint) public ownerLunchCount;

    mapping (uint => address) public pendingSend;
    mapping (address => uint) public ownerPendingSendCount;

    mapping (uint => address) public pendingRecieve;
    mapping (address => uint) public ownerPendingReceiveCount;

    function createLunchEvent(uint256 totalAmount, string memory date, address[] memory accounts) public {
        lunches.push(Lunch(totalAmount, date));
        uint id = lunches.length-1;
        lunchToOwner[id] = msg.sender;
        ownerLunchCount[msg.sender]++;

        uint256 amount = totalAmount/(accounts.length+1);
        for (uint i=0; i<accounts.length; i++) {
            _createPending(lunches[id], amount, accounts[i]);
        }
        emit NewLunch(id);
    }

    function getLunchByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerLunchCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < lunches.length; i++) {
            if (lunchToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function _createPending(Lunch memory lunch, uint256 amount, address from) internal {
        pendings.push(Pending(lunch, amount,false));
        uint id = pendings.length-1;
        pendingRecieve[id] = msg.sender;
        pendingSend[id] = from;
        emit NewPending(id);
    }

    function getPendingSendByOwner(address _owner) public view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerPendingSendCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < pendings.length; i++) {
            if (pendingSend[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function getPendingReceiveByOwner(address _owner) public view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerPendingReceiveCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < pendings.length; i++) {
            if (pendingRecieve[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function allowSend(uint pendingId) public payable returns(bool) {
        require(pendingSend[pendingId] == msg.sender, "wrong sender");
        require(pendings[pendingId].status == false,"already paid bill");
        require(balanceOf(msg.sender) >= pendings[pendingId].amount, "not enough token");
        approve(pendingRecieve[pendingId], pendings[pendingId].amount);
        return true;
    }

    function collect(uint pendingId) public payable returns(bool) {
        require(pendingRecieve[pendingId] == msg.sender, "wrong receiver");
        require(pendings[pendingId].status == false,"already paid bill");
        transferFrom(pendingSend[pendingId], msg.sender, pendings[pendingId].amount);
        changePendingStatus(pendingId);
        return true;
    }

    function changePendingStatus(uint pendingId) public view {
        pendings[pendingId].status!=pendings[pendingId].status;
    }
}

