import 'package:flutter/widgets.dart';

/// 🎬 **Animation Helpers - Handles Smooth Transitions & Effects**
class AnimationHelpers {
  static Widget fadeIn({required Widget child, Duration duration = const Duration(milliseconds: 500)}) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      child: child,
    );
  }

  static Widget slideIn({required Widget child, required Offset from, Duration duration = const Duration(milliseconds: 500)}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: from, end: Offset.zero),
      duration: duration,
      builder: (context, Offset offset, child) {
        return Transform.translate(offset: offset, child: child);
      },
      child: child,
    );
  }
}
