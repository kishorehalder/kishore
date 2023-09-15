// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    int256 public result;

    constructor() {
        result = 0;
    }

    modifier validInputs(int256 num1, int256 num2) {
        require(num1 >= 0 && num2 >= 0, "Both numbers must be equal or greater than Zero.");
        _;
    }

    modifier validDivision(int256 num1, int256 num2) {
        require(num2 > 0, "Division by zero is not allowed.");
        _;
    }

    function add(int256 num1, int256 num2) public validInputs(num1, num2) {
        result = num1 + num2;
    }

    function subtract(int256 num1, int256 num2) public validInputs(num1, num2) {
        result = num1 - num2;
    }

    function multiply(int256 num1, int256 num2) public validInputs(num1, num2) {
        result = num1 * num2;
    }

    function divide(int256 num1, int256 num2) public validInputs(num1, num2) validDivision(num1, num2) {
        result = num1 / num2;
    }

    function getResult() public view returns (int256) {
        return result;
    }
}
