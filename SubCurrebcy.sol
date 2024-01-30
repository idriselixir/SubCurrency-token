// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract SubCurrency {
    address public _owner;
    string public name = "idris";
    string public symbol = "IDR";
    uint256 public tsuply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );

    modifier onlyOwner() {
        require(msg.sender == _owner, "Not Owner");
        _;
    }

    constructor(address owner) {
        _owner = owner;
    } 

    function mint(address to, uint256 amount) public onlyOwner {
        tsuply +=amount * 10**18;
        balanceOf[to] +=amount *10**18;
        emit Transfer(address(0), to , amount);
       
    }
    function approve(address spender, uint256 amount) public returns (bool) {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}


function transferFrom(address from, uint256 amount) public returns (bool) {
    require(balanceOf[msg.sender] >= amount, "Insufficient balance");
    require(amount <= allowance[from][msg.sender], "Allowance exceeded");

    // Subtract the transferred amount from the sender's balance
    balanceOf[msg.sender] -= amount;

    // Add the transferred amount to the recipient's balance
    balanceOf[from] += amount;

    // Adjust allowance
    allowance[from][msg.sender] -= amount;

    // Emit the Transfer event
    emit Transfer(msg.sender, from, amount);

    return true;
}

    // events part
    //   event Currency (
    //     address from,
    //     address to,
    //     uint256 amount
    //   );
    //   function NewCurrency(address to, uint256 value) internal {
    //   emit Currency(msg.sender, to, value);
    //   }
}
