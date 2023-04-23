// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    mapping(address => bool) public registeredVoters;
    mapping(bytes32 => uint256) public votesReceived;
    bytes32[] public candidateList = [bytes32("Aman"), bytes32("Aishwary"), bytes32("Aayush")];

    function registerVoter() public {
        registeredVoters[msg.sender] = true;
    }

    function vote(bytes32 candidate) public {
        require(registeredVoters[msg.sender], "You must be a registered voter to cast your vote.");
        require(validCandidate(candidate), "Invalid candidate.");
        votesReceived[candidate] += 1;
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint256) {
        require(validCandidate(candidate), "Invalid candidate.");
        return votesReceived[candidate];
    }

    function getCandidateList() public view returns (bytes32[] memory) {
        return candidateList;
    }
    
    function validCandidate(bytes32 candidate) private view returns (bool) {
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}
