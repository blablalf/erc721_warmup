pragma solidity ^0.8.9;
import "./Evaluator.sol";
import "./my_ecr721.sol";

contract MyContract {
    Evaluator evaluator;

    event anEvent(address anAddress);

    constructor() {
        // Init
        evaluator = Evaluator(payable(0x40aDC5976f6ae451Dbf9a390d31c7ffB5366b229));

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
        my_erc721.transferFrom(address(this), address(evaluator), tokenId);
        evaluator.ex2b_testDeclaredAnimal(tokenId);

        // Ex3
        my_erc721.toggleBreeders();
        evaluator.ex3_testRegisterBreeder();

        // Ex4
        evaluator.ex4_testDeclareAnimal();

        // Ex5
        evaluator.ex5_declareDeadAnimal();

        // Ex6a
        evaluator.ex6a_auctionAnimal_offer();

        // Ex6b
        my_erc721.registerMeAsBreeder();
        tokenId = my_erc721.declareAnimal(creatureSex, creatureLegs, creatureWings, creatureName);
        my_erc721.offerForSale(tokenId, 0.0001 ether);
        //evaluator.ex6b_auctionAnimal_buy(tokenId);
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external pure returns(bytes4 value) {
        _operator; _from; _tokenId; _data;
        return 0x150b7a02;
    }
    
}