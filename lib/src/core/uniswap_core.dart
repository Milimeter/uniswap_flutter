import '../enum/system.dart';
import '../swap/swap_manager.dart';

class UniswapFlutter {
  final UniswapSwapManager swapManager;

  UniswapFlutter({UniswapSwapManager? swapManager})
      : swapManager = swapManager ??
            UniswapSwapManager(
              poolAddress:
                  '0x74F7A360eB36A46B675eA932ea07094A3ace441F', // USDT / GNB pool address
              poolChain: PoolChain.bsc,
              bscScanApiKey: "your_bscscan_api_key",
            );
}
