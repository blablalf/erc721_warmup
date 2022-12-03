// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./IExerciceSolution.sol";

contract Blabla721 is ERC721, Ownable, IExerciceSolution {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    mapping(uint256 => Metadatas) private metadatas;
    struct Metadatas {
		uint sex;
        uint legs;
        bool wings;
        string name;
    }

    constructor() ERC721("blabla_721", "BLABLA") {
        _tokenIdCounter.increment();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function mint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
    }

    // Breeding function
	function isBreeder(address account) external returns (bool) {
        return false;
    }

	function registrationPrice() external returns (uint256) {
        return 0;
    }

	function registerMeAsBreeder() external payable {}

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external onlyOwner returns (uint256) {
        metadatas[_tokenIdCounter.current()] = Metadatas(sex, legs, wings, name);
        return _tokenIdCounter.current();
    }

	function getAnimalCharacteristics(uint animalNumber) external view returns (string memory _name, bool _wings, uint _legs, uint _sex) {
        return (metadatas[animalNumber].name, metadatas[animalNumber].wings, metadatas[animalNumber].legs, metadatas[animalNumber].sex);
    }

	function declareDeadAnimal(uint animalNumber) external {}

	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256) {
        return 0;
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