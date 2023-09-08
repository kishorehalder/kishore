// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // State variable to store an integer value
    uint256 private storedData;
    
    // Event to log changes in the storedData variable
    event ValueUpdated(uint256 newValue);

    // Constructor: Initialize the contract with an initial value
    constructor(uint256 initialValue) {
        storedData = initialValue;
    }

    // Function to get the current stored value
    function getValue() public view returns (uint256) {
        return storedData;
    }

    // Function to set a new value
    function setValue(uint256 newValue) public {
        storedData = newValue;
        emit ValueUpdated(newValue); // Emit an event when the value is updated
    }
}
