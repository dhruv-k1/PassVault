import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final String encryptionKey = '01234567890123456789012345678901';

  Encrypted encryptPassword(String password) {
    final key = Key.fromUtf8(encryptionKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encryptedPassword = encrypter.encrypt(password, iv: iv);
    return encryptedPassword;
  }

  String decryptPassword(Encrypted encryptedPassword) {
    final key = Key.fromUtf8(encryptionKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt(encryptedPassword, iv: iv);
  }
}
