// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;    // Auto increments IDs
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdtoLevels; // keep track of the levels of the NFTs

    constructor() ERC721("Chain Battles", "CBTLS"){

    }

    function generateCharacter(uint256 tokenId) public returns(string memory){
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getLevels(tokenId),'</text>',
            '</svg>'
        );
        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            )    
        );
    }

    /// @notice Returns level of NFT
    /// @dev Returns a string
    function getLevels(uint256 tokenId) public view returns(string memory){
        uint256 levels = tokenIdtoLevels[tokenId];
        return levels.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Chain Battles #', tokenId.toString(), '",',
                '"description": "Battles on chain",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }


    function mint() public {
        _tokenIds.increment(); // we started on 1 because it's more clear than starting on 0
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdtoLevels[newItemId] = 0; // NFT starts with Level 0
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    /// @notice Trains the NFT if exists
    /// @dev Anyone can train any NFT that exists
    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existint token");
        uint256 currentLevel = tokenIdtoLevels[tokenId];
        tokenIdtoLevels[tokenId] = currentLevel + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

}