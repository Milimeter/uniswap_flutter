// ignore_for_file: avoid_print

import 'package:uniswap_flutter/uniswap_flutter.dart';

void main() {
  UniswapSwapManager manager = UniswapSwapManager(
    poolAddress: '0x1234567890abcdef',
    poolChain: PoolChain.bsc,
  );

  // Create an instance of UniswapFlutter using the manager
  UniswapFlutter uniswapFlutter = UniswapFlutter(swapManager: manager);

  // Print details
  print('Pool Address: ${uniswapFlutter.swapManager.poolAddress}');
  print('Pool Chain: ${uniswapFlutter.swapManager.poolChain}');
}

