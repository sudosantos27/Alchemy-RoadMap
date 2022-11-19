// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuyMeACoffee {
    event NewMemo(
        address from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /// @notice Buy a coffee for contract owner
    /// @param _name name of the coffee buyer
    /// @param _message a message from the coffee buyer
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Can not buy coffee with 0 ETH");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /// @notice send the entire balance in this contract to the owner
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /// @notice retrieve all the memos received and stored on the blockchain
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    } 
}