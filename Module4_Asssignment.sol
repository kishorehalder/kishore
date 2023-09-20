// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenContract {
    struct Token {
        string name;
        string symbol;
        uint256 totalSupply;
    }

    Token[] private tokens;
    mapping(string => mapping(address => uint256)) private balances;

    function createToken(string memory name, string memory symbol, uint256 initialSupply) public {
        tokens.push(Token({
            name: name,
            symbol: symbol,
            totalSupply: initialSupply
        }));

        balances[symbol][msg.sender] = initialSupply;
    }

    function transferToken(string memory symbol, address recipient, uint256 amount) public {
        require(balances[symbol][msg.sender] >= amount, "Insufficient balance");
        require(getTokenIndex(symbol) >= 0, "Token does not exist");

        balances[symbol][msg.sender] -= amount;
        balances[symbol][recipient] += amount;
    }

    function getBalanceByToken(string memory symbol, address account) public view returns (uint256) {
        return balances[symbol][account];
    }

    function getTotalTokenCount() public view returns (uint256) {
        return tokens.length;
    }

    function getTokenIndex(string memory symbol) private view returns (int256) {
        for(uint256 i = 0; i < tokens.length; i++) {
            if(keccak256(abi.encodePacked(tokens[i].symbol)) == keccak256(abi.encodePacked(symbol))) {
                return int256(i);
            }
        }
        return -1;
    }
}
