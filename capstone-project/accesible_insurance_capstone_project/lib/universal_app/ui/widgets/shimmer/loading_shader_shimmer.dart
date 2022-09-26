import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class LoadingShaderShimmer extends StatefulWidget {
  const LoadingShaderShimmer({
    Key? key,
    this.isLoading = false,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  State<LoadingShaderShimmer> createState() => _LoadingShaderShimmerState();
}

class _LoadingShaderShimmerState extends State<LoadingShaderShimmer> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChanges);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChanges);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChanges);
    super.dispose();
  }

  void _onShimmerChanges() {
    if (widget.isLoading) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final shimmer = Shimmer.of(context);
    final renderObject = context.findRenderObject();
    if (shimmer != null && !shimmer.hasSize || 
    //Protects agaings interactions from user when screen is loading
    renderObject  == null) {
      return const SizedBox();
    }

    final shimmerSize = shimmer!.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.obtainDescendantOffset(
        descendant: renderObject as RenderBox);

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(-offsetWithinShimmer.dx, -offsetWithinShimmer.dy,
              shimmerSize.width, shimmerSize.height),
        );
      },
      child: widget.child,
    );
  }
}
