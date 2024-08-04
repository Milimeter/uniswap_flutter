// ignore_for_file: avoid_print

import 'dart:developer';

import '../constants/rpc_urls.dart';
import '../constants/scan_api.dart';
import '../enum/system.dart';
import '../functions/get_pool_abi.dart';
import '../services/api_client.dart';

class UniswapSwapManager {
  final String poolAddress;
  final PoolChain poolChain;
  final String? infuraApiKey;
  final String? bscScanApiKey;
  final String? etherScanApiKey;

  String? rpcUrl;
  late final ApiClient apiClient;
  late String poolAbi;

  // Constructor with required parameters
  UniswapSwapManager({
    required this.poolAddress,
    required this.poolChain,
    this.infuraApiKey,
    this.bscScanApiKey,
    this.etherScanApiKey,
  }) {
    // Code that runs when an instance is created
    log('UniswapSwapManager was instantiated with poolAddress: $poolAddress and poolChain: $poolChain');
    // Validate that Infura API key and Etherscan API key are provided if the chain is ETH
    // Validate that Infura API key and Etherscan API key are provided if the chain is ETH
    if (poolChain == PoolChain.eth) {
      if (infuraApiKey == null || infuraApiKey!.isEmpty) {
        throw ArgumentError('Infura API key is required for Ethereum pool.');
      }
      if (etherScanApiKey == null || etherScanApiKey!.isEmpty) {
        throw ArgumentError('Etherscan API key is required for Ethereum pool.');
      }
      apiClient = ApiClient(baseUrl: SCANAPI.ETHERSCAN);
    }
    // Validate that BSC Scan API key is provided if the chain is BSC
    if (poolChain == PoolChain.bsc) {
      if (bscScanApiKey == null || bscScanApiKey!.isEmpty) {
        throw ArgumentError('BSC Scan API key is required for BSC pool.');
      }
      apiClient = ApiClient(baseUrl: SCANAPI.BSCSCAN);
    }

    if (poolChain == PoolChain.eth) {
      rpcUrl = '${RPCUrls.ETHEREUM}$infuraApiKey';
    } else if (poolChain == PoolChain.bsc) {
      rpcUrl = RPCUrls.BINANCE_SMART_CHAIN;
    }
  }

  Future<void> init() async {
    String apiKey;

    if (poolChain == PoolChain.eth) {
      apiKey = etherScanApiKey!;
    } else if (poolChain == PoolChain.bsc) {
      apiKey = bscScanApiKey!;
    } else {
      throw ArgumentError('Unsupported pool chain');
    }

    try {
      poolAbi = await getPoolAbi(
        apiClient: apiClient,
        poolAddress: poolAddress,
        apiKey: apiKey,
      );
      print('ABI: $poolAbi');
    } catch (e) {
      print('Error: $e');
    }
  }
}
