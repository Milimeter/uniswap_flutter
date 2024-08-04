// Function to get the ABI of a pool address
import 'dart:convert';

import 'package:web3dart/web3dart.dart';

import '../services/api_client.dart';
import '../services/token_factory.dart';

class PoolInfo {
  final TokenFactory _tokenFactory = TokenFactory();

  Future<String> getPoolAbi({
    required ApiClient apiClient,
    required String poolAddress,
    required String apiKey,
  }) async {
    final response = await apiClient.getRequest(
      endpoint: '',
      queryParams: {
        'module': 'contract',
        'action': 'getabi',
        'address': poolAddress,
        'apikey': apiKey,
      },
    );

    final data = jsonDecode(response.body);
    if (data['status'] == '1') {
      return data['result'];
    } else {
      throw Exception('Failed to fetch ABI: ${data['message']}');
    }
  }

  Future<BigInt> getPoolFee({
    required String rpcUrl,
    required String abi,
    required String poolAddress,
  }) async {
    try {
      Web3Client? webClient = await _tokenFactory.initWebClient(rpcUrl);
      final contract = await _tokenFactory.intContract(abi, poolAddress, '');
      ContractFunction feeFunction = contract.function("fee");
      final feeList = await webClient.call(
        contract: contract,
        function: feeFunction,
        params: [],
      );
      BigInt fee = feeList.first;
      return fee;
    } catch (e) {
      throw Exception('Failed to fetch fee: $e');
    }
  }
}
