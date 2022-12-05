pragma solidity ^0.8.9;
import "./Evaluator.sol";
import "./Evaluator2.sol";
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
        evaluator.ex6b_auctionAnimal_buy(tokenId);

        // Ex7a
        Evaluator2 evaluator2 = Evaluator2(payable(0x0E4F5184E6f87b5F959aeE5a09a2797e8B1b20E5));
        evaluator2.ex2a_getAnimalToCreateAttributes();
        evaluator2.submitExercice(my_erc721);
        my_erc721.registerSomeoneAsBreeder(address(evaluator2));
        uint256 parent1Id = my_erc721.declareAnimal(creatureSex, creatureLegs, creatureWings, creatureName);
        uint256 parent2Id = my_erc721.declareAnimal(creatureSex+1, creatureLegs, creatureWings, creatureName);
        my_erc721.transferFrom(address(this), address(evaluator2), parent1Id);
        my_erc721.transferFrom(address(this), address(evaluator2), parent2Id);
        evaluator2.ex7a_breedAnimalWithParents(parent1Id, parent2Id);

        // Ex7b
        evaluator2.ex7b_offerAnimalForReproduction();

        // Ex7c
        tokenId = my_erc721.declareAnimal(creatureSex, creatureLegs, creatureWings, creatureName);
        my_erc721.offerForReproduction(tokenId, 0.0001 ether);
        evaluator2.ex7c_payForReproduction(tokenId);
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external pure returns(bytes4 value) {
        _operator; _from; _tokenId; _data;
        return 0x150b7a02;
    }
    
}