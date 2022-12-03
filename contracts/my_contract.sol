pragma solidity ^0.8.9;
import "./Evaluator.sol";
import "./my_ecr721.sol";

contract MyContract {
    Evaluator evaluator;

    event anEvent(address anAddress);

    constructor() {
        // Init
        evaluator = Evaluator(payable(0xB1BEAE84fDC2989fB9ef5C2ee8127617B17039E0));
    }

    function allIn() public {
        // Ex1
        Blabla721 my_erc721 = new Blabla721();
        evaluator.submitExercice(my_erc721);
        my_erc721.mint(address(evaluator));
        evaluator.ex1_testERC721();

        // Ex2a
        evaluator.ex2a_getAnimalToCreateAttributes();

        // Ex2b
        //uint256 creatureRank = evaluator.assignedRank(address(this));
        uint256 creatureSex = evaluator.readSex(address(this));
        uint256 creatureLegs = evaluator.readLegs(address(this));
        bool creatureWings = evaluator.readWings(address(this));
        string memory creatureName = evaluator.readName(address(this));
        uint256 tokenId = my_erc721.declareAnimal(creatureSex, creatureLegs, creatureWings, creatureName);
        my_erc721.mint(address(evaluator));
        evaluator.ex2b_testDeclaredAnimal(tokenId);

    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external pure returns(bytes4 value) {
        _operator; _from; _tokenId; _data;
        return 0x150b7a02;
    } 
}