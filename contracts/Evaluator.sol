pragma solidity ^0.8.9;
pragma experimental ABIEncoderV2;

import "./ERC20TD.sol";
import "./IExerciceSolution.sol";

contract Evaluator {

	mapping(address => bool) public teachers;
	ERC20TD TDERC20;

 	mapping(address => mapping(uint256 => bool)) public exerciceProgression;
 	mapping(address => IExerciceSolution) public studentExerciceSolution;
 	mapping(address => bool) public hasBeenPaired;
	mapping(address => uint256) public assignedRank;
	uint public nextValueStoreRank;

 	event newRandomAnimalAttributes(string name, uint256 legs, uint256 sex, bool wings);
 	event constructedCorrectly(address erc20Address);
	
	constructor(ERC20TD _TDERC20) 
	public 
	{}

	fallback () external payable 
	{}

	receive () external payable 
	{}

	function ex1_testERC721()
	public	
	{}

	function ex2a_getAnimalToCreateAttributes()
	public
	{}

	function ex2b_testDeclaredAnimal(uint animalNumber)
	public	
	{}

	function ex3_testRegisterBreeder()
	public	
	{}

	function ex4_testDeclareAnimal()
	public	
	{}

	function ex5_declareDeadAnimal()
	public	
	{}

	function ex6a_auctionAnimal_offer()
	public
	{}

	function ex6b_auctionAnimal_buy(uint animalForSale)
	public
	{}

	/* Internal functions and modifiers */ 
	function submitExercice(IExerciceSolution studentExercice)
	public
	{}

	modifier onlyTeachers() 
	{
	    require(TDERC20.teachers(msg.sender));
	    _;
	}

	function _compareStrings(string memory a, string memory b) 
	internal 
	pure 
	returns (bool) 
	{
    	return false;
	}

	function bytes32ToString(bytes32 _bytes32) 
	public 
	pure returns (string memory) 
	{
        return "";
    }

    function readName(address studentAddress)
	public
	view
	returns(string memory)
	{
		return "";
	}

	function readLegs(address studentAddress)
	public
	view
	returns(uint256)
	{
		return 0;
	}

	function readSex(address studentAddress)
	public
	view
	returns(uint256)
	{
		return 0;
	}

	function readWings(address studentAddress)
	public
	view
	returns(bool)
	{
		return false;
	}

	function setRandomValuesStore(string[20] memory _randomNames, uint256[20] memory _randomLegs, uint256[20] memory _randomSex, bool[20] memory _randomWings)
    public 
    onlyTeachers
    {}

}