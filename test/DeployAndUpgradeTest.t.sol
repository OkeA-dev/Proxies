//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract TestDeployAndUpgrade is Test {
    address public proxy;

    UpgradeBox public upgrader;
    DeployBox public deployer;
    address public OWNER = makeAddr("owner");

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    function testBoxVersion() public view {
        uint256 expectedVersion = 1;
        uint256 actualVersion = BoxV1(proxy).version();

        assertEq(expectedVersion, actualVersion);
    }

    function testUpgradeBoxToVersionTwo() public {
        BoxV2 boxV2 = new BoxV2();
        uint256 expectedVersion = 2;
        
        upgrader.upgradeBox(proxy, address(boxV2));
        uint256 actualVersion = BoxV2(proxy).version();

        assertEq(expectedVersion, actualVersion);
    }
}
