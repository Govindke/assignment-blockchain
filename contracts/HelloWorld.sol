// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
    }
    struct Proposal {
        uint voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    // New state variable
    bool votingActive;

    constructor(uint8 _numProposals) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        proposals = new Proposal[](_numProposals);
        votingActive = true;
    }

    // Modified to check if voting is active
    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted.");
        require(votingActive, "Voting is not active.");
        voters[voter].weight = 1;
    }

    // Modified to check if voting is active
    function vote(uint8 toProposal) public {
        require(votingActive, "Voting is not active.");
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }

    // New function to stop the voting
    function stopVoting() public {
        require(msg.sender == chairperson, "Only chairperson can stop the voting.");
        votingActive = false;
    }
}

