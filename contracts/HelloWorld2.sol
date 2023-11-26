// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract Ballot {
  mapping (string => uint256) private votesReceived;
      address public chairperson;
      string[] private candidateList;
  address[] private votersList;
  bool votingState;
    constructor(string[] memory candidateNames, address[] memory voters)
}

  
 {
      chairperson = msg.sender;
      candidateList = candidateNames;
	 votersList = voters;
      votingState = true;
  }
  modifier onlyChair() {
         require(msg.sender == chairperson, 'Only chairperson');
         _;
    }

  function stopVoting() public onlyChair {
    votingState = false;
  }
  function totalVotesFor(string memory candidate) view public onlyChair returns (uint256)  {

    require(validCandidate(candidate));
    return votesReceived[candidate];
  }
  function castVote(string memory candidate) public {
    require(validVoter(msg.sender));
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }
  function validCandidate(string memory candidate) view private returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (keccak256(bytes(candidateList[i])) == keccak256(bytes(candidate))) {
        return true;
      }
    }
    return false;
  }

  function validVoter(address voter) view private returns (bool) {
    for(uint i = 0; i < votersList.length; i++) {
      if (votersList[i] == voter) {
        return true;
      }
    }
    return false;
  }
}