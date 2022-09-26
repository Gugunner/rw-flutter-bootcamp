
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadMastersProvider {
  static final instance = LoadMastersProvider();

  final isLoadingProvider = StateProvider<bool>((ref) => true);

  final loadingProvider = FutureProvider.autoDispose((ref) async {
    ref.watch(LoadMastersProvider.instance.isLoadingProvider.notifier).state =
        await Future.delayed(const Duration(seconds: 2), () => false);
  });
}
