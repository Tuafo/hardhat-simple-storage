// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// EVM, Ethereum Virtual Machine
// Avalanche, Fantom, Polygon

contract SimpleStorage {
    // boolean, unit, int, address, bytes
    /*
    bool hasFavoriteNumber = true;
    uint favoriteNumber = 123;
    int256 FavoriteInt = -123;
    string favoriteNumberText = "Five";
    address myAddress = 0x20aeCE9f6d8b076819BB2Ff78271CA9A335B9881;
    bytes32 favoriteBytes = "cat"; // 0x123456789asfsdfgt
    */

    // This gets initialized to zero!
    // uint256 public favoriteNumber;
    uint256 favoriteNumber;

    /*
    People public person = People({ favoriteNumber: 13, name: "Thiago" });
    People public person2 = People({ favoriteNumber: 3, name: "Didico" });
    */

    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        // created a new type called People
        uint256 favoriteNumber;
        string name;
    }

    // uint256[] public favoriteNumberList;
    // People[3] public people; only allow to have 3 people in the array
    People[] public people;

    function Store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
        retrieve(); // it's not free
    }

    // view, pure ( will just read the state of the contract, can't modifier the state ) it's free
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // don't need to read any storage, something that is done over and over again. it's free
    function add() public pure returns (uint256) {
        return (1 + 1);
    }

    // calldata(exists temporarily, can be modify), memory(exists temporarily, can't be modify), storage(permament variables that can be modify)
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // People memory newPerson = People({ favoriteNumber: _favoriteNumber, name: _name });
        // People memory newPerson = People(_favoriteNumber, _name );
        //people.push(newPerson);

        people.push(People(_favoriteNumber, _name));

        nameToFavoriteNumber[_name] = _favoriteNumber; // create a relation betwhen the two ones
    }
}
