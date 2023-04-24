// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    
    // structure for a single vote
    struct Vote {
        uint candidateId;   // id of the candidate
        bool voted;         // whether this voter has already voted
    }
    
    // structure for a single candidate
    struct Candidate {
        string name;        // name of the candidate
        uint voteCount;     // number of votes received
    }
    
    // list of all candidates
    Candidate[] public candidates;
    
    // list of all registered voters
    mapping(address => Vote) public voters;
    
    // event triggered when a new vote is cast
    event NewVote(uint candidateId, string candidateName, address voter);
    
    // add a new candidate to the list
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }
    
    // cast a vote for a given candidate
    function castVote(uint _candidateId) public {
        // check if the voter has already voted
        require(!voters[msg.sender].voted, "You have already voted!");
        
        // check if the candidate id is valid
        require(_candidateId < candidates.length, "Invalid candidate id!");
        
        // mark the voter as voted and increment the candidate's vote count
        voters[msg.sender].voted = true;
        candidates[_candidateId].voteCount++;
        
        // emit a new vote event
        emit NewVote(_candidateId, candidates[_candidateId].name, msg.sender);
    }
    
    // get the winner of the election
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
