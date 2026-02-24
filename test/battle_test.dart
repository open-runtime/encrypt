import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('Battle test', () {
    test('Emoji', () {
      const encoded = 'iPC4DII05qnIJsFm6/RUp6OQEnvLSTq1pW+4/cjHf4c=';
      final encrypter = Encrypter(AES(Key.allZerosOfLength(32)));

      expect(
        Encrypted.fromBase64(encoded),
        equals(
          encrypter.encrypt('Text to encrypt 😀', iv: IV.allZerosOfLength(16)),
        ),
      );
    });

    test('AES CBC decrypt must use the original IV', () {
      const plainText = 'Persist your IV with ciphertext.';
      final key = Key.allZerosOfLength(32);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final originalIv = IV.fromSecureRandom(16);
      final encrypted = encrypter.encrypt(plainText, iv: originalIv);
      final wrongIv = IV.fromSecureRandom(16);

      final decryptedWithWrongIv = encrypter.decryptBytes(
        encrypted,
        iv: wrongIv,
      );
      expect(decryptedWithWrongIv, isNot(equals(utf8.encode(plainText))));
      expect(encrypter.decrypt(encrypted, iv: originalIv), equals(plainText));
    });

    test('AES GCM enforces a 12-byte IV', () {
      final key = Key.allZerosOfLength(32);
      final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

      expect(
        () => encrypter.encrypt('hello', iv: IV.fromSecureRandom(16)),
        throwsArgumentError,
      );
      expect(
        () => encrypter.encrypt('hello', iv: IV.fromSecureRandom(12)),
        returnsNormally,
      );
    });
  });
}
