import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Gradient? gradient;

  Shimmer({
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
        );

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: widget.child,
      gradient: widget.gradient!,
      percent: _controller!.value,
    );
  }
}

class _Shimmer extends SingleChildRenderObjectWidget {
  _Shimmer({
    Widget? child,
    this.gradient,
    this.percent,
  }) : super(child: child);

  final Gradient? gradient;
  final double? percent;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _ShimmerFilter(gradient!);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _ShimmerFilter).shiftPercentage = percent!;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  _ShimmerFilter(this._gradient);

  final Gradient _gradient;
  double _shiftPercentage = 0.0;

  set shiftPercentage(double newValue) {
    if (_shiftPercentage != newValue) {
      _shiftPercentage = newValue;
      markNeedsPaint();
    }
  }

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final width = child!.size.width;
      final height = child!.size.height;

      double dy = 0.0;
      double dx = _offset(
        start: -(width * 2),
        end: width * 2,
        percent: _shiftPercentage,
      );

      final rect = Rect.fromLTWH(dx, dy, width, height);

      layer = ShaderMaskLayer();
      layer
        ?..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    }
  }

  double _offset(
      {required double start, required double end, required double percent}) {
    return start + (end - start) * percent;
  }
}
