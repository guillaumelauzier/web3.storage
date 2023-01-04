pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/SafeERC721.sol";

// This contract is a simple example of an ERC-721 non-fungible token.
// It has one function, `mint`, which allows the contract owner to create
// new tokens and assign them to any address.

// Declare a new contract that inherits from the SafeERC721 contract
contract SimpleNFT is SafeERC721 {
  // The contract owner
  address public owner;

  // The name of the token
  string public name;

  // The symbol of the token
  string public symbol;

  // The total number of tokens that have been minted
  uint256 public totalSupply;

  // The mapping from token ID to token owner
  mapping(uint256 => address) public tokenOwners;

  // The constructor function
  constructor(string memory _name, string memory _symbol) public {
    // Set the contract owner to the address that deployed the contract
    owner = msg.sender;
    // Set the name and symbol of the token
    name = _name;
    symbol = _symbol;
  }

  // The function to mint new tokens
  function mint(address _to, uint256 _tokenId) public {
    // Only the contract owner can mint new tokens
    require(msg.sender == owner, "Only the contract owner can mint tokens");
    // The token ID must be unique
    require(_tokenId > totalSupply, "Token ID must be unique");
    // Assign the token to the specified address
    tokenOwners[_tokenId] = _to;
    // Increment the total supply
    totalSupply++;
    // Emit the Transfer event
    emit Transfer(address(0), _to, _tokenId);
  }

  // The ERC-721 functions that must be implemented
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balanceOf(_owner);
  }

  function ownerOf(uint256 _tokenId) public view returns (address owner) {
    return tokenOwners[_tokenId];
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
    require(tokenOwners[_tokenId] == _from, "Token is not owned by the sender");
    tokenOwners[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }
}
