// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    
    struct Vote {
        uint candidateId;   
        bool voted;         
    }
    struct Candidate {
        string name;        
        uint voteCount;     
    }
    
    Candidate[] public candidates;
    mapping(address => Vote) public voters;
    event NewVote(uint candidateId, string candidateName, address voter);
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }
   
    function castVote(uint _candidateId) public {
        require(!voters[msg.sender].voted, "You have already voted!");
        
        require(_candidateId < candidates.length, "Invalid candidate id!");
        
        voters[msg.sender].voted = true;
        candidates[_candidateId].voteCount++;
        
        emit NewVote(_candidateId, candidates[_candidateId].name, msg.sender);
    }
    
    function getWinner() public view returns (string memory) {
        uint maxVotes = 0;
        string memory winnerName = "";
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
        return winnerName;
    }
}
