import 'asset.dart';

class CoinPair {
  Asset pairOne;
  Asset pairTwo;
  Asset? intermediary;
  String poolAddress;
  String poolAbi;
  String routerAddress;
  String routerAbi;
  String? nftPositionManagerAddress;
  String? nftPositionManagerAbi;

  bool isIntermediary;

  CoinPair(
      {required this.pairOne,
      required this.pairTwo,
      this.intermediary,
      required this.poolAddress,
      required this.poolAbi,
      required this.routerAddress,
      required this.routerAbi,
      required this.isIntermediary,
      this.nftPositionManagerAddress,
      this.nftPositionManagerAbi});

  CoinPair copyWith({
    Asset? pairOne,
    Asset? pairTwo,
    Asset? intermediary,
    String? poolAddress,
    String? nftPositionManagerAddress,
    String? nftPositionManagerAbi,
    String? poolAbi,
    String? routerAddress,
    String? routerAbi,
    bool? isIntermediary,
  }) {
    return CoinPair(
      pairOne: pairOne ?? this.pairOne,
      pairTwo: pairTwo ?? this.pairTwo,
      intermediary: intermediary ?? this.intermediary,
      poolAddress: poolAddress ?? this.poolAddress,
      poolAbi: poolAbi ?? this.poolAbi,
      routerAddress: routerAddress ?? this.routerAddress,
      nftPositionManagerAddress:
          nftPositionManagerAddress ?? this.nftPositionManagerAddress,
      nftPositionManagerAbi:
          nftPositionManagerAbi ?? this.nftPositionManagerAbi,
      routerAbi: routerAbi ?? this.routerAbi,
      isIntermediary: isIntermediary ?? this.isIntermediary,
    );
  }
}
