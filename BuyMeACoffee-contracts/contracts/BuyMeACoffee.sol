// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Deployed to Goerli at 0xdE45b0F8b93Dd9F7F6671eE25412E6cdD3E7e438

contract BuyMeACoffee {
    // Event to emit when a memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
        
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends.
    Memo[] memos;

    // Address of contract deployer.
    address payable owner;

    // Deploy logic.
    constructor() {
        owner = payable(msg.sender);
    }

    /** 
    * @dev buy a coffee for contract owner
    * @param _name of the coffee buyer
    * @param _message a nice message from the coffee buyer
    */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Can't buy coffee with 0 ETH");

        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /** 
    * @dev send the entire balance in this contract to the owner
    */

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /** 
    * @dev retrieve all the memos received and stored on the blockchain
    */

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

}
