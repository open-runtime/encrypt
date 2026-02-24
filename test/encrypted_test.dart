import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('Encrypted', () {
    test('Encrypted', () {
      final encrypted = Encrypted(Uint8List(3));
      expect(encrypted.bytes, equals([0, 0, 0]));
    });

    test('fromBase16', () {
      final encrypted = Encrypted.fromBase16('000102');
      expect(encrypted.bytes, equals([0, 1, 2]));
    });

    test('fromBase64', () {
      final encrypted = Encrypted.fromBase64('AAEC');
      expect(encrypted.bytes, equals([0, 1, 2]));
    });

    test('allZerosOfLength', () {
      final encrypted = Encrypted.allZerosOfLength(3);
      expect(encrypted.bytes.length, equals(3));
      expect(encrypted.bytes, equals([0, 0, 0]));
    });

    test('fromLength', () {
      final encrypted = Encrypted.fromLength(20);
      final encrypted2 = Encrypted.fromLength(20);
      expect(encrypted.bytes.length, equals(20));
      expect(encrypted2.bytes.length, equals(20));
      expect(encrypted.bytes, isNot(equals(encrypted2.bytes)));
    });

    test('fromSecureRandom', () {
      final encrypted = Encrypted.fromSecureRandom(20);
      final encrypted2 = Encrypted.fromSecureRandom(20);
      expect(encrypted.bytes.length, equals(20));
      expect(encrypted2.bytes.length, equals(20));
      expect(encrypted.bytes, isNot(equals(encrypted2.bytes)));
    });

    test('fromUtf8', () {
      final encrypted = Encrypted.fromUtf8('\u0000\u0001\u0002');
      expect(encrypted.bytes, equals([0, 1, 2]));
    });

    test('Key.stretch with explicit legacy iteration count', () {
      final desiredLength = 32;
      final salt = Uint8List(16);
      final shortKey = Key.fromUtf8('short');
      final stretchedKey = shortKey.stretch(desiredLength, iterationCount: 100, salt: salt);

      expect(stretchedKey.bytes.length, equals(desiredLength));
      expect(stretchedKey.base64, equals('ykT8qFmrPp7TJyzY+E2NoBNjfWymzKOs1OCbRsO67fo='));
    });

    test('Key.stretch uses 600k iterations by default', () {
      final desiredLength = 32;
      final salt = Uint8List(16);
      final shortKey = Key.fromUtf8('short');
      final stretchedKey = shortKey.stretch(desiredLength, salt: salt);

      expect(stretchedKey.bytes.length, equals(desiredLength));
      // Default 600k iterations produces a different key than 100 iterations.
      expect(stretchedKey.base64, isNot(equals('ykT8qFmrPp7TJyzY+E2NoBNjfWymzKOs1OCbRsO67fo=')));
    });

    test('Key.length', () {
      final key = Key.fromLength(32);
      expect(key.length, equals(32));
    });
  });
}
