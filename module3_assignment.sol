// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title VotingSystem
 * @dev A simple smart contract for a voting system with candidate management and donations.
 */
contract VotingSystem {
    // Define a struct for the Candidate
    struct Candidate {
        string name;     // The name of the candidate.
        uint256 voteCount; // The number of votes received by the candidate.
    }

    // Mapping to store the vote count for each candidate
    mapping(string => uint256) public candidates;

    // Mapping to track whether an address has already voted
    mapping(address => bool) public hasVoted;

    // Event to log donations
    event DonationReceived(address indexed sender, uint256 amount);

    /**
     * @dev Constructor to initialize the contract with two default candidates, "John" and "Paul."
     */
    constructor() {
        addCandidate("John");
        addCandidate("Paul");
    }

    /**
     * @dev Add a new candidate to the election.
     * @param _name The name of the candidate to be added.
     * @notice Requires that the candidate does not already exist.
     */
    function addCandidate(string memory _name) public {
        require(!hasCandidate(_name), "Candidate already exists");
        candidates[_name] = 0;
    }

    /**
     * @dev Check if a candidate with a given name exists.
     * @param _name The name of the candidate to check.
     * @return True if the candidate exists, otherwise false.
     */
    function hasCandidate(string memory _name) public view returns (bool) {
        return candidates[_name] > 0;
    }

    /**
     * @dev Modifier to ensure that the candidate name is valid (either "John" or "Paul").
     * @param _name The name of the candidate to check.
     * @notice If the name is not valid, it will revert with an error message.
     */
    modifier onlyValidCandidate(string memory _name) {
        require(
            keccak256(bytes(_name)) == keccak256(bytes("John")) ||
            keccak256(bytes(_name)) == keccak256(bytes("Paul")),
            "You are not allowed to vote"
        );
        _;
    }

    /**
     * @dev Cast a vote for a candidate.
     * @param _name The name of the candidate to vote for.
     * @notice Requires that the candidate exists and the sender has not voted before.
     */
    function vote(string memory _name) public onlyValidCandidate(_name) {
        require(!hasVoted[msg.sender], "You have already voted");
        
        candidates[_name]++;
        hasVoted[msg.sender] = true;
    }

    /**
     * @dev Payable function for users to send Ether as a donation to the contract.
     * @notice Users can send Ether as a donation, and the DonationReceived event will be emitted.
     */
    function donate() public payable {
        // Emit the DonationReceived event with the sender's address and the amount of Ether received
        emit DonationReceived(msg.sender, msg.value);
    }

    /**
     * @dev Get the current vote count for a candidate and their name as a Candidate struct.
     * @param _name The name of the candidate to retrieve information for.
     * @return A Candidate struct containing the candidate's name.
     * @notice Requires that the candidate exists.
     */
    function getCandidateVoteCount(string memory _name) public view returns (Candidate memory) {
        require(hasCandidate(_name), "Candidate does not exist");
        
        Candidate memory candidateInfo;
        candidateInfo.name = _name;
        candidateInfo.voteCount = candidates[_name];
        return candidateInfo;
    }
}
