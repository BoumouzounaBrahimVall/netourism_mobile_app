import 'package:flutter/material.dart';

enum ToastPosition { top, bottom }

class ToastWidget {
  static OverlayEntry? overlayEntry; // Track the current toast overlay

  static void showToast({
    required BuildContext context,
    required String text,
    Color textColor = Colors.white,
    Color bgColor = Colors.black,
    double bgOpacity = 0.7,
    IconData? icon,
    ToastPosition position = ToastPosition.bottom,
    Duration delay = const Duration(seconds: 2),
  }) {
    // Don't show toast if another toast is currently displayed
    if (overlayEntry != null) return;

    final double initialPosition = position == ToastPosition.top ? -1.0 : 1.0;
    const double finalPosition = 0.1;

    final AnimationController controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutExpo,
    );

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          top: position == ToastPosition.top ? height * finalPosition : null,
          bottom:
              position == ToastPosition.bottom ? height * finalPosition : null,
          left: width * 0.1,
          right: width * 0.1,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, initialPosition),
              end: const Offset(0, finalPosition),
            ).animate(curvedAnimation),
            child: FadeTransition(
              opacity: curvedAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(bgOpacity),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) Icon(icon, color: textColor),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
    controller.forward();

    Future.delayed(delay).then((value) {
      controller.reverse().then((_) {
        overlayEntry?.remove();
        overlayEntry = null; // Reset the overlay entry after removing
      });
    });
  }
}

/**
 here is how to test it 
 
 ToastWidget.showToast(
  context: context,
  text: 'Hello, this is a Sporgates toast!',
  icon: Icons.info,

);
 */