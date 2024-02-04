import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

// Replace this key with a securely generated key
final key = encrypt.Key.fromUtf8('a secure 32-byte key');

// Replace this IV with a securely generated IV
final iv = encrypt.IV.fromUtf8('a secure 16-byte IV');

String encryptPassword(String password) {
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final encrypted = encrypter.encrypt(password, iv: iv);
  return encrypted.base64;
}

String decryptPassword(String encryptedPassword) {
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
  return decrypted;
}

// void check() {
//   // Example: Encrypting and Decrypting a password
//   final originalPassword = 'secret123';
//   final encryptedPassword = encryptPassword(originalPassword);

//   print('Original Password: $originalPassword');
//   print('Encrypted Password: $encryptedPassword');

//   final decryptedPassword = decryptPassword(encryptedPassword);
//   print('Decrypted Password: $decryptedPassword');
// }
