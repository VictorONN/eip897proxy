// SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

contract ProxyStorage {
    address public otherContractAddress;

    function setOtherAddress(address _otherContract) internal {
        otherContractAddress = _otherContract;
    }
}

contract NotLostStorage is ProxyStorage {
    address public myAddress;
    uint256 public myUint;

    function setAddress(address _address) public {
        myAddress = _address;
    }

    function setMyUint(uint256 _uint) public {
        myUint = _uint;
    }
}

contract ProxyNoMoreClash is ProxyStorage {
    constructor(address _otherContract) {
        setOtherAddress(_otherContract);
    }

    function setOtherAddress(address _otherContract) public {
        super.setOtherAddressStorage(_otherContract);
    }

    /*
    @dev Fallback function allowing to perform a delegatecall to the given implementation.
    This function will return whatever the implementation call returns
     */
    fallback() external payable {
        address _impl = otherContractAddress;
    }
}
