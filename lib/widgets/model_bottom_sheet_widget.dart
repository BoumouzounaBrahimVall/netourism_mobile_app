import 'package:flutter/material.dart';

void modalBottomSheetWidget(
  BuildContext context, {
  required Widget child,
  required double initialChildSize,
  required double maxChildSize,
  required double minChildSize,
  bool dragIndicator = true,
  bool expand = false,
  VoidCallback? onClose,
}) {
  assert(
    minChildSize <= initialChildSize,
    'minChildSize should be less than or equal to initialChildSize',
  );

  Future<void> future = showModalBottomSheet(
    context: context,
    elevation: 3,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          30,
        ),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      snapSizes: [maxChildSize],
      snapAnimationDuration: const Duration(
        milliseconds: 200,
      ),
      expand: expand,
      snap: true,
      builder: (
        context,
        scrollController,
      ) {
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            if (dragIndicator)
              Positioned(
                top: -15,
                child: Container(
                  width: 60,
                  height: 7,
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    physics: const ScrollPhysics(
                      parent: BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal,
                      ),
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          ],
        );
      },
    ),
  );
  future.then((void value) {
    onClose!();
  });
}
