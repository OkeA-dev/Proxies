//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract TestDeployAndUpgrade is Test {

    address boxV1;
    address boxV2;
    UpgradeBox upgrader;

    function setUp() public {
        DeployBox deployer = new DeployBox();
        upgrader = new UpgradeBox();
        boxV1 = deployer.run();
        
    }

    function testBoxVersion() public view {
        uint256 expectedVersion = 1;
        uint256 actualVersion = BoxV1(boxV1).version();

        assertEq(expectedVersion, actualVersion);
    }

    function testUpgradeBoxToVersionTwo() public view{
        uint256 expectedVersion = 2;
        uint256 actualVersion = BoxV2(boxV2).version();

        assertEq(expectedVersion, actualVersion);
    }
}