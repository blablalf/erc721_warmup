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
        MyToken my_erc = new MyToken();
        my_erc.mint(address(evaluator));
        evaluator.submitExercice(my_erc);
        evaluator.ex1_testERC721();
    }
}