class FormatUtils {
  static String formatCurrency(dynamic amount) {
    if (amount == null) return '\$0';
    final number = amount is int ? amount.toDouble() : amount;
    return '\$${number.toStringAsFixed(2)}';
  }
  
  static String formatDate(String? date) {
    if (date == null) return 'N/A';
    return date; // You can format this further if needed
  }
  
  static String formatTime(String? time) {
    if (time == null) return 'N/A';
    return time;
  }
}