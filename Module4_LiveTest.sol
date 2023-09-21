// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0; 

contract VotingContract { 
    address public owner; 
    
    // Define an enum `CandidateStatus` to represent the status of a candidate (Pending, Approved, Disqualified) 
    enum CandidateStatus { Pending, Approved, Disqualified }
    
    struct Candidate { 
        string name; 
        uint256 votes;
        CandidateStatus status;
    } 
    
    mapping(address => Candidate) public candidates; 

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor() { 
        owner = msg.sender;
    } 

    function addCandidate(address _candidateAddress, string memory _name) public onlyOwner {
        require(candidates[_candidateAddress].status == CandidateStatus.Pending, "Candidate already exists.");
        candidates[_candidateAddress].name = _name;
        candidates[_candidateAddress].status = CandidateStatus.Pending;
    } 

    function removeCandidate(address _candidateAddress) public onlyOwner { 
        require(candidates[_candidateAddress].status != CandidateStatus.Disqualified, "Candidate already disqualified.");
        candidates[_candidateAddress].status = CandidateStatus.Disqualified;
    } 

    function vote(address _candidateAddress) public {
        require(candidates[_candidateAddress].status == CandidateStatus.Approved, "Only approved candidates can receive votes.");
        candidates[_candidateAddress].votes += 1;
    }

    function getTotalVotesForCandidate(address _candidateAddress) public view returns (uint256) { 
        return candidates[_candidateAddress].votes;
    } 

    function getCandidateStatus(address _candidateAddress) public view returns (CandidateStatus) { 
        return candidates[_candidateAddress].status;
    } 

    function approveCandidate(address _candidateAddress) public onlyOwner { 
        require(candidates[_candidateAddress].status == CandidateStatus.Pending, "Candidate not in pending status.");
        candidates[_candidateAddress].status = CandidateStatus.Approved;
    }
}
