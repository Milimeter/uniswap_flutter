import '../enum/system.dart';
import 'crypto_data.dart';
import 'network_models.dart';

class SupportedCoin {
  String id;
  String symbol;
  String name;
  String image;
  String? walletAddress;
  String? privateKey;
  List<QuoteElement>? quotes = [];
  NetworkModel? networkModel;
  int? decimal;
  CoinType? coinType;
  String? contractAddress;
  bool? isImplementedContract = false;
  String? implementationContractAddress;

  SupportedCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    this.walletAddress,
    this.privateKey,
    this.quotes,
    this.networkModel,
    this.decimal,
    this.coinType,
    this.contractAddress,
    this.isImplementedContract,
    this.implementationContractAddress,
  });
}
