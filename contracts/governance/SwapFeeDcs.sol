// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {ISwapFee} from "../interfaces/ISwapFee.sol";

contract SwapFeeDcs is ISwapFee, Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    address public admin;
    address public proxy;
    uint16 public immutable mintFeeGasPrice; // in gwei
    uint32 public immutable mintFeeGasUsed;
    uint256 public immutable burnFeeDcs;
    IERC20 public immutable dcs;
    address public system;

    //================================= Public =================================
    constructor(
        address _admin,
        address _proxy,
        uint256 _burnFeeDcs,
        uint16 _mintFeeGasPrice,
        uint32 _mintFeeGasUsed,
        IERC20 _dcs,
        address _system
    ) {
        admin = _admin;
        proxy = _proxy;
        mintFeeGasUsed = _mintFeeGasUsed;
        mintFeeGasPrice = _mintFeeGasPrice;
        burnFeeDcs = _burnFeeDcs;
        dcs = _dcs;
        system = _system;
    }
    
    function updateProxy(address _updateProxy) {
        require(msg.sender == admin, "NOt administrator");
        proxy = _updateProxy;
    }
}
