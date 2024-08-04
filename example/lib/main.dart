// ignore_for_file: avoid_print

import 'package:uniswap_flutter/uniswap_flutter.dart';

void main() async {
  try {
    // Create an instance of UniswapSwapManager for BSC
    UniswapSwapManager bscManager = UniswapSwapManager(
      poolAddress: '0x1234567890abcdef',
      poolChain: PoolChain.bsc,
      bscScanApiKey: 'your_bsc_scan_api_key',
    );

    // Create an instance of UniswapSwapManager for ETH with Infura and Etherscan API keys
    UniswapSwapManager ethManager = UniswapSwapManager(
      poolAddress: '0xabcdef1234567890',
      poolChain: PoolChain.eth,
      infuraApiKey: 'your_infura_api_key',
      etherScanApiKey: 'your_etherscan_api_key',
    );

    // Create instances of UniswapFlutter using the managers
    UniswapFlutter bscUniswapFlutter = UniswapFlutter(swapManager: bscManager);
    UniswapFlutter ethUniswapFlutter = UniswapFlutter(swapManager: ethManager);

    // Print details
    print('BSC Pool Address: ${bscUniswapFlutter.swapManager.poolAddress}');
    print('BSC Pool Chain: ${bscUniswapFlutter.swapManager.poolChain}');
    print('BSC Scan API Key: ${bscUniswapFlutter.swapManager.bscScanApiKey}');
    print('ETH Pool Address: ${ethUniswapFlutter.swapManager.poolAddress}');
    print('ETH Pool Chain: ${ethUniswapFlutter.swapManager.poolChain}');
    print('ETH Infura API Key: ${ethUniswapFlutter.swapManager.infuraApiKey}');
    print(
        'ETH Etherscan API Key: ${ethUniswapFlutter.swapManager.etherScanApiKey}');

    //YOU MUST CALL INIT FIRST
    await bscUniswapFlutter.swapManager.init();
  } catch (e) {
    print('Error: $e');
  }
}
