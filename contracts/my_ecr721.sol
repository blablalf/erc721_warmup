// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./IExerciceSolution.sol";

contract Blabla721 is ERC721, Ownable, IExerciceSolution {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => Metadatas) public metadatas;
    //mapping(uint256 => bool) public isDead;

    // Breeders
    bool breedersEnabled;
    mapping(address => bool) private breeders;
    uint registrationPriceVal;

    struct Metadatas {
		uint sex;
        uint legs;
        bool wings;
        string name;
    }

    constructor() ERC721("blabla_721", "BLABLA") {}

    function safeMint(address to) public onlyOwner {
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());
    }

    function mint(address to) public onlyOwner {
        _tokenIdCounter.increment();
        _mint(to, _tokenIdCounter.current());
    }

    function toggleBreeders() public onlyOwner {
        breedersEnabled = !breedersEnabled;
    }

    // Breeding function
	function isBreeder(address account) external view returns (bool) {
        return breeders[account];
    }

	function registrationPrice() external view returns (uint256) {
        return registrationPriceVal;
    }

	function registerMeAsBreeder() external payable {
        require(msg.value == registrationPriceVal, "Payed value not equal to registrationPrice value.");
        breeders[msg.sender] = true;
    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external returns (uint256) {
        if (breedersEnabled) require(breeders[msg.sender], "Not registred as breeder.");
        _tokenIdCounter.increment();
        metadatas[_tokenIdCounter.current()] = Metadatas(sex, legs, wings, name);
        _mint(msg.sender, _tokenIdCounter.current());
        return _tokenIdCounter.current();
    }

	function getAnimalCharacteristics(uint animalNumber) external view returns (string memory _name, bool _wings, uint _legs, uint _sex) {
        return (metadatas[animalNumber].name, metadatas[animalNumber].wings, metadatas[animalNumber].legs, metadatas[animalNumber].sex);
    }

	function declareDeadAnimal(uint animalNumber) external {
        require(msg.sender == ownerOf(animalNumber), "Only owner of the token can do that");
        require(breeders[msg.sender], "Not registred as breeder.");
        metadatas[animalNumber] = Metadatas(0, 0, false, "");
        _burn(animalNumber);
        //transferFrom(msg.sender, address(this), animalNumber);

        //isDead[animalNumber] = true;
    }

	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256) {
        require(balanceOf(owner) > 0, "Owner do not have any token");
        uint ownerBalance = balanceOf(owner);
        uint elementAdded;

        for (uint i = 1; i <= _tokenIdCounter.current() || elementAdded != ownerBalance; i++) 
            if (ownerOf(i) == owner && elementAdded == index) return i;
            else if (ownerOf(i) == owner) elementAdded++;

        return 0; // Never happens
        
    }

	// Selling functions
	function isAnimalForSale(uint animalNumber) external view returns (bool) {
        return false;
    }

	function animalPrice(uint animalNumber) external view returns (uint256) {
        return 0;
    }

	function buyAnimal(uint animalNumber) external payable {}

	function offerForSale(uint animalNumber, uint price) external {}

	// Reproduction functions

	function declareAnimalWithParents(uint sex, uint legs, bool wings, string calldata name, uint parent1, uint parent2) external returns (uint256) {
        return 0;
    }

	function getParents(uint animalNumber) external returns (uint256, uint256) {
        return (0, 0);
    }

	function canReproduce(uint animalNumber) external returns (bool) {
        return false;
    }

	function reproductionPrice(uint animalNumber) external view returns (uint256) {
        return 0;
    }

	function offerForReproduction(uint animalNumber, uint priceOfReproduction) external returns (uint256) {
        return 0;
    }

	function authorizedBreederToReproduce(uint animalNumber) external returns (address) {
        return msg.sender;
    }

	function payForReproduction(uint animalNumber) external payable {}
}