// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./IExerciceSolution.sol";

contract Blabla721 is ERC721, Ownable, IExerciceSolution {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    // Breeders
    bool breedersEnabled;
    mapping(address => bool) private breeders;
    uint registrationPriceVal;

    // Sales
    mapping(uint => uint) public animalSalePrice;
    mapping(uint => bool) public isForSale;

    // Parents
    mapping(uint => Parents) public parents;
    struct Parents {
		uint parent1;
        uint parent2;
    }

    // Reproduction
    mapping(uint => bool) public reproducingAvaibility;
    mapping(uint => uint) public repoductionPrice;
    mapping(uint => address) public authorizedBreederToReproduction;

    // Characteristics/Metadatas
    mapping(uint => Metadatas) public metadatas;
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

    function registerSomeoneAsBreeder(address futurBreeder) external payable {
        require(msg.value == registrationPriceVal, "Payed value not equal to registrationPrice value.");
        breeders[futurBreeder] = true;
    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) public returns (uint256) {
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
        require(msg.sender == ownerOf(animalNumber), "Only owner of the token can do that.");
        require(breeders[msg.sender], "Not registred as breeder.");
        metadatas[animalNumber] = Metadatas(0, 0, false, "");
        _burn(animalNumber);
    }

    // Shouldn't works with big mapping
	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256) {
        require(balanceOf(owner) > 0, "Owner do not have any token.");
        uint ownerBalance = balanceOf(owner);
        uint elementAdded;
        for (uint i = 1; i <= _tokenIdCounter.current() || elementAdded != ownerBalance; i++)
            if (_exists(i)) {
                if (ownerOf(i) == owner && elementAdded == index) return i;
                else if (ownerOf(i) == owner) elementAdded++;
            }

        return 0; // Normally it never happens
    }

	// Selling functions
	function isAnimalForSale(uint animalNumber) external view returns (bool) {
        return isForSale[animalNumber];
    }

	function animalPrice(uint animalNumber) external view returns (uint256) {
        return animalSalePrice[animalNumber];
    }

	function buyAnimal(uint animalNumber) external payable {
        require(isForSale[animalNumber], "Token not for sale.");
        require(msg.value >= animalSalePrice[animalNumber], "Proposed value lower than price.");
        isForSale[animalNumber] = false;
        _transfer(ownerOf(animalNumber), msg.sender, animalNumber);
    }

	function offerForSale(uint animalNumber, uint price) external {
        require(msg.sender == ownerOf(animalNumber), "Caller is not owner of this token.");
        isForSale[animalNumber] = true;
        animalSalePrice[animalNumber] = price;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal override
    {
        require(!isForSale[tokenId], "Token for sale.");
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

	// Reproduction functions

	function declareAnimalWithParents(uint sex, uint legs, bool wings, string calldata name, uint parent1, uint parent2) external returns (uint256) {
        require(ownerOf(parent1) == msg.sender || authorizedBreederToReproduction[parent1] == msg.sender, "Sender is not allowed to use parent1 to reproduce.");
        require(ownerOf(parent2) == msg.sender || authorizedBreederToReproduction[parent2] == msg.sender, "Sender is not allowed to use parent1 to reproduce.");
        uint tokenId = declareAnimal(sex, legs, wings, name);
        parents[tokenId].parent1 = parent1;
        parents[tokenId].parent2 = parent2;
        if (authorizedBreederToReproduction[parent1] == msg.sender) authorizedBreederToReproduction[parent1] = address(0);
        if (authorizedBreederToReproduction[parent2] == msg.sender) authorizedBreederToReproduction[parent2] = address(0);
        return tokenId;
    }

	function getParents(uint animalNumber) external view returns (uint256, uint256) {
        return (parents[animalNumber].parent1, parents[animalNumber].parent2); // if 0 is returned then it doesn't have parents
    }

	function canReproduce(uint animalNumber) external view returns (bool) {
        return reproducingAvaibility[animalNumber];
    }

	function reproductionPrice(uint animalNumber) external view returns (uint256) {
        return repoductionPrice[animalNumber];
    }

	function offerForReproduction(uint animalNumber, uint priceOfReproduction) external returns (uint256) {
        require(ownerOf(animalNumber) == msg.sender);
        reproducingAvaibility[animalNumber] = true;
        repoductionPrice[animalNumber] = priceOfReproduction;
        return animalNumber;
    }

	function authorizedBreederToReproduce(uint animalNumber) external view returns (address) {
        return authorizedBreederToReproduction[animalNumber];
    }

	function payForReproduction(uint animalNumber) external payable {
        require(breeders[msg.sender], "Not registred as breeder.");
        require(msg.value >= repoductionPrice[animalNumber], "Paid value is inferior to reproduction price.");
        require(reproducingAvaibility[animalNumber], "Animal cannot reproduce.");
        repoductionPrice[animalNumber] = 0;
        reproducingAvaibility[animalNumber] = false;
        authorizedBreederToReproduction[animalNumber] = msg.sender;
    }
}