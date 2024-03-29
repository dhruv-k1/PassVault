import 'dart:math';

String generateRandomPassword({
  bool includeLowercase = true,
  bool includeUppercase = true,
  bool includeNumbers = true,
  bool includeSpecialChars = true,
  int length = 12,
}) {
  String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String numberChars = '0123456789';
  String specialChars = '!@#\$%^&*()-_=+[]{}|;:,.<>?';

  String allChars = '';
  if (includeLowercase) allChars += lowercaseChars;
  if (includeUppercase) allChars += uppercaseChars;
  if (includeNumbers) allChars += numberChars;
  if (includeSpecialChars) allChars += specialChars;

  if (allChars.isEmpty) {
    throw ArgumentError('At least one character set must be included.');
  }

  final Random secureRandom = Random.secure();
  List<int> codes = List.generate(length, (index) {
    int charIndex = secureRandom.nextInt(allChars.length);
    return allChars.codeUnitAt(charIndex);
  });

  return String.fromCharCodes(codes);
}
