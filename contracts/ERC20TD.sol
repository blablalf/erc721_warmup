pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20TD is ERC20 {

    mapping(address => bool) public teachers;
    event DenyTransfer(address recipient, uint256 amount);
    event DenyTransferFrom(address sender, address recipient, uint256 amount);

    constructor(string memory name, string memory symbol,uint256 initialSupply) public ERC20(name, symbol) {}

    function distributeTokens(address tokenReceiver, uint256 amount) public onlyTeachers {}

    function setTeacher(address teacherAddress, bool isTeacher) public onlyTeachers {}

    modifier onlyTeachers() {
        _;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {}

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        return false;
    }

}