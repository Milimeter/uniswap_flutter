import '../enum/system.dart';
import '../swap/swap_manager.dart';

class UniswapFlutter {
  final UniswapSwapManager swapManager;

  UniswapFlutter({UniswapSwapManager? swapManager})
      : swapManager = swapManager ??
            UniswapSwapManager(
              poolAddress: 'default_pool_address',
              poolChain: PoolChain.bsc,
            );
}
