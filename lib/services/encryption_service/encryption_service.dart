import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  // The singleton instance
  static final EncryptionService _instance = EncryptionService._internal();

  // Private constructor
  EncryptionService._internal();

  // Factory constructor to return the same instance
  factory EncryptionService() {
    return _instance;
  }

  encrypt.Key? key;

  String generateRandomKey() {
    key = encrypt.Key.fromSecureRandom(32);
    return key!.base64;
  }

  // Method to initialize the encryption key
  void init() {
    key = encrypt.Key.fromBase64(generateRandomKey());
  }

  // Method to encrypt data
  String encryptData(String plainText) {
    if (key == null) {
      throw Exception('Encryption key is not initialized.');
    }
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key!));
    final iv = encrypt.IV.fromLength(8);
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final ivBase64 = iv.base64;
    final encryptedBase64 = encrypted.base64;

    return '$ivBase64:$encryptedBase64:${key!.base64}'; // Store IV, ciphertext and key together
  }

  // Method to decrypt data
  String decryptData(String encryptedData) {
    final parts = encryptedData.split(':');
    final iv = encrypt.IV.fromBase64(parts[0]); // Extract the IV
    key = encrypt.Key.fromBase64(parts[2]); // Extract the key
    if (key == null) {
      throw Exception('Encryption key is not initialized.');
    }
    final encrypted = encrypt.Encrypted.fromBase64(parts[1]);
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key!));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }
}
