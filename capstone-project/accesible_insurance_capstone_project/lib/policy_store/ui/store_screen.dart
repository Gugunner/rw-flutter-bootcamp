import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/imago.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpgradePolicyScreen extends ConsumerWidget {
  const UpgradePolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: const Center(
          child: AnimatedLogoMatrix(),
        ),
      ),
    );
  }
}

class AnimatedLogoMatrix extends ConsumerStatefulWidget {
  const AnimatedLogoMatrix({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedLogoMatrixState();
}

class _AnimatedLogoMatrixState extends ConsumerState<AnimatedLogoMatrix>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogoMatrixPoint(controller: controller);
  }
}

class AnimatedLogoMatrixPoint extends AnimatedWidget {
  const AnimatedLogoMatrixPoint({
    super.key,
    required AnimationController controller,
  }) : super(listenable: controller);

  Animation<double> get _opacity => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _opacity.value, child: const Imago());
  }
}
