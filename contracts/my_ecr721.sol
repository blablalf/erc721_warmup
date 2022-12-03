// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// 0xa0b9f62A0dC5cCc21cfB71BA70070C3E1C66510E
contract MyToken is ERC721 {
    constructor() ERC721("MyToken", "MTK") {}
}
