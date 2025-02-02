class FormatUtility {
  static bool isEmail(final String? text) {
    if (text == null || text.isEmpty) return false;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(text);
  }

  static bool isPhone(final String? text) {
    if (text == null || text.isEmpty) return false;

    final wholeNumberRegex = RegExp(r'^\d+$');

    return wholeNumberRegex.hasMatch(text);
  }

  const FormatUtility._();
}