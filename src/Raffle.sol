// SPDX-License-Identifier: MIT

pragma solidity >=0.8.19;
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.2.0/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";


/**
 * @title Raffle contract - Raffle.sol
 * @author Pavel Vitov
 * @notice This is a contract used to create a simple raffle
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle {

    error Raffle_NotEnoughETH();

    uint256 private immutable i_entranceFee;
    //@dev The duration i nlottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }
    function enterRaffle() external payable {
        //require(msg.value >= i_entranceFee, NotEnoughETH());
        if(msg.value < i_entranceFee){
            revert Raffle_NotEnoughETH ();
        }
        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external {
        if((block.timestamp - s_lastTimeStamp) < i_interval){
            revert();
        }

         requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );

    }

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }


}
