// ignore_for_file: constant_identifier_names

class UniswapConstants {
  static const String ROUTER_VERSION = '3';

  static const String UNISWAP_URL =
      'https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2';
  static const String UNISWAP_PAIRS =
      '{ pairs(first: 5, orderBy: reserveUSD, orderDirection: desc) { id token0 { symbol } token1 { symbol } reserveUSD } }';
  static const String UNISWAP_TOKENS =
      '{ tokens(first: 5, orderBy: tradeVolumeUSD, orderDirection: desc) { id symbol tradeVolumeUSD } }';
}
