pragma solidity >=0.4.21 <0.6.0;

import "../libs/IERC1155.sol";

contract Marketplace {

    IERC1155 private _token;

    mapping (uint => uint) price;

    constructor(IERC1155 token) public {
        require(address(token) != address(0), "address not valid");
        _token = token;
        price[1] = .003 ether;
        price[2] = .002 ether;
        price[3] = .001 ether;
    }

    function () external payable {
        buyToken(1);
    }

    function buyToken(uint tokenId) public payable {
        uint weiAmount = msg.value;
        require(weiAmount >= price[tokenId], "Insufficient payment.");
        require(price[tokenId] != 0, "Item does not exist.");

        _token.safeTransferFrom(address(this), msg.sender, tokenId, 1, "");
    }

    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4) {
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }
}