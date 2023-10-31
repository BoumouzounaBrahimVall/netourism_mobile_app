String formatStoryTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  return difference.inSeconds < 1
      ? "now"
      : difference.inMinutes < 1
          ? "${difference.inSeconds}s"
          : difference.inHours < 1
              ? "${difference.inMinutes}min"
              : difference.inHours < 24
                  ? "${difference.inHours}h"
                  : "24h";
}
