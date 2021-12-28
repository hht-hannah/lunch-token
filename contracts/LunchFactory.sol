
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./LunchToken.sol";

contract LunchFactory is LunchToken {
    struct Lunch {
      uint totalAmount;
      string date;
    }

    struct Pending {
        uint amount;
        bool allowed;
        bool status;
    }

    struct PendingReturn {
        uint id;
        address account;
        uint amount;
    }

    mapping (address => Lunch[]) public LunchMap;

    Pending[] public pendings;

    mapping (uint => address) public pendingSend;
    mapping (address => uint) public ownerPendingSendCount;

    mapping (uint => address) public pendingReceive;
    mapping (address => uint) public ownerPendingReceiveCount;

    function createLunchEvent(uint totalAmount, string memory date, address[] memory accounts) public {
        LunchMap[msg.sender].push(Lunch(totalAmount, date));
        uint amount = totalAmount/(accounts.length+1);
        for (uint i=0; i<accounts.length; i++) {
            _createPending(amount, accounts[i]);
        }
    }


    function getLunchByOwner(address _owner) public view returns(Lunch[] memory) {
        return LunchMap[_owner];
    }

    function _createPending(uint amount, address from) internal {
        pendings.push(Pending(amount, false, false));
        uint id = pendings.length-1;
        pendingReceive[id] = msg.sender;
        pendingSend[id] = from;
        ownerPendingReceiveCount[msg.sender] += 1;
        ownerPendingSendCount[from] += 1;
    }

    function getPendingSendByOwner(address _owner) public view returns(PendingReturn[] memory) {
        PendingReturn[] memory result = new PendingReturn[](ownerPendingSendCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < pendings.length; i++) {
            if (pendingSend[i] == _owner && pendings[i].allowed == false) {
                result[counter] = PendingReturn(i, pendingReceive[i], pendings[i].amount);
                counter++;
            }
        }
        return result;
    }

    function getPendingReceiveByOwner(address _owner) public view returns(PendingReturn[] memory) {
        PendingReturn[] memory result = new PendingReturn[](ownerPendingReceiveCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < pendings.length; i++) {
            if (pendingReceive[i] == _owner && pendings[i].status == false) {
                result[counter] = PendingReturn(i, pendingSend[i], pendings[i].amount);
                counter++;
            }
        }
        return result;
    }

    function allowSend(uint pendingId) public payable returns(bool) {
        require(pendingSend[pendingId] == msg.sender, "wrong sender");
        require(pendings[pendingId].status == false,"already paid bill");
        require(balanceOf(msg.sender) >= pendings[pendingId].amount, "not enough token");
        approve(pendingReceive[pendingId], pendings[pendingId].amount);
        changePendingAllowed(pendingId);
        ownerPendingSendCount[msg.sender] -= 1;
        return true;
    }

    function collect(uint pendingId) public payable returns(bool) {
        require(pendingReceive[pendingId] == msg.sender, "wrong receiver");
        require(pendings[pendingId].status == false,"already paid bill");
        transferFrom(pendingSend[pendingId], msg.sender, pendings[pendingId].amount);
        changePendingStatus(pendingId);
        ownerPendingReceiveCount[msg.sender] -= 1;
        return true;
    }

    function changePendingAllowed(uint pendingId) internal {
        pendings[pendingId].allowed = !pendings[pendingId].allowed;
    }

    function changePendingStatus(uint pendingId) internal {
        pendings[pendingId].status = !pendings[pendingId].status;
    }
}

