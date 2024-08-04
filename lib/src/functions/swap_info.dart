// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

import '../models/asset.dart';
import '../models/coin_pair.dart';
import '../services/token_factory.dart';

class SwapInfo {
  final TokenFactory _tokenFactory = TokenFactory();

  estimateSwapTxGas({
    required Asset sourceAsset,
    required CoinPair pair,
    required BigInt poolFee,
    required double sourceSwapAmount,
    required String rpcURL,
  }) async {
    try {
      String routerAddress = pair.routerAddress;
      String routerAbi = pair.routerAbi;
      DeployedContract contract =
          await _tokenFactory.intContract(routerAbi, routerAddress, "Router");

      final exactInputSingle = contract.function("exactInputSingle");
      final credentials =
          await _tokenFactory.getCredentials(sourceAsset.privateKey!);
      List<dynamic> params = [
        [
          EthereumAddress.fromHex(pair.pairOne.contractAddress!),
          EthereumAddress.fromHex(pair.pairTwo.contractAddress!),
          poolFee,
          EthereumAddress.fromHex(sourceAsset.walletAddress!),
          BigInt.from(sourceSwapAmount),
          BigInt.zero,
          BigInt.zero
        ]
      ];
      Transaction tx = await _constructTx(
          contract: contract,
          function: exactInputSingle,
          credentials: credentials,
          params: params);

      BigInt gas = await estimateTxGas(
        sender: sourceAsset.walletAddress!,
        to: pair.routerAddress,
        from: sourceAsset,
        data: tx.data!,
        rpcURL: rpcURL,
      );
      return gas;
    } catch (e) {
      throw Exception('Failed to estimate swap tx gas: $e');
    }
  }

  static Future<Transaction> _constructTx(
      {required DeployedContract contract,
      required ContractFunction function,
      required Credentials credentials,
      required List<dynamic> params,
      EtherAmount? gasPrice,
      int? maxGas}) async {
    Transaction transaction = Transaction.callContract(
        contract: contract,
        function: function,
        gasPrice: gasPrice,
        maxGas: maxGas,
        from: credentials.address,
        parameters: params);
    return transaction;
  }

  Future<BigInt> estimateTxGas(
      {required String sender,
      required String to,
      required Asset from,
      required Uint8List data,
      required String rpcURL}) async {
    print("Getting ${from.networkModel!.chainSymbol} Tx fee");
    Web3Client? webClient = await _tokenFactory.initWebClient(rpcURL);
    BigInt gasPrice = await webClient.estimateGas(
        sender: EthereumAddress.fromHex(sender),
        to: EthereumAddress.fromHex(to),
        data: data);
    print("Gas : ${gasPrice.toString()}");
    return gasPrice;
  }
}
