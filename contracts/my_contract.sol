pragma solidity ^0.8.9;
import "./Evaluator.sol";

contract MyContract {
    Evaluator evaluator;

    constructor() {
        // Init
        evaluator = Evaluator(payable(0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5));
    }
}