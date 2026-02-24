# encrypt

[![Pub Package](https://img.shields.io/pub/v/encrypt.svg)](https://pub.dartlang.org/packages/encrypt)
[![CI](https://github.com/pieces-app/encrypt/actions/workflows/ci.yaml/badge.svg)](https://github.com/pieces-app/encrypt/actions/workflows/ci.yaml)

A set of high-level APIs over PointyCastle for two-way cryptography.

> **Note:** This is a maintained fork of the original [encrypt](https://github.com/leocavalcante/encrypt) package. The original repository has been archived. This fork includes CI/CD improvements (with a 6-platform test matrix across Linux, macOS, and Windows) and automated release management.

> Looking for password hashing? Please, visit [password](https://github.com/leocavalcante/password-dart).

### Secure random

You can generate cryptographically secure random keys and IVs for you project.

Activate the encrypt package:

```bash
pub global activate encrypt
```

Then use the `secure-random` command-line tool:

```bash
$ secure-random
CBoaDQIQAgceGg8dFAkMDBEOECEZCxgMBiAUFQwKFhg=
```

You can set the length and the base output.

```bash
$ secure-random --help
-l, --length       The length of the bytes
                   (defaults to "32")

-b, --base         Bytes represented as base 64 or base 16 (Hexdecimal)
                   (defaults to "64")

-h, --[no-]help    Show this help message
```

## Algorithms

Current status is:

- AES with PKCS7 padding
- RSA with PKCS1 and OAEP encoding
- Salsa20

### Signing

- SHA256 with RSA

## Usage

### Symmetric

#### AES

AES requires keys of 16, 24, or 32 bytes in length.

- Use a 16-byte IV for CBC/CTR/CFB/SIC/OFB modes.
- Use a 12-byte IV for GCM mode.
- `IV.fromLength()` and `IV.fromSecureRandom()` generate fresh random bytes on each call. You must decrypt with the same IV value used for encryption.

```dart
import 'package:encrypt/encrypt.dart';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
}
```

##### Persist IV with ciphertext (important)

```dart
import 'package:encrypt/encrypt.dart';

void main() {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final encrypted = encrypter.encrypt('sensitive payload', iv: iv);
  final payload = '${iv.base64}:${encrypted.base64}';

  final parts = payload.split(':');
  final ivForDecrypt = IV.fromBase64(parts[0]);
  final cipherForDecrypt = Encrypted.fromBase64(parts[1]);
  final decrypted = encrypter.decrypt(cipherForDecrypt, iv: ivForDecrypt);

  print(decrypted); // sensitive payload
}
```

##### Modes of operation

Default mode is SIC `AESMode.sic`, you can override it using the `mode` named parameter:

```dart
final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
```

###### Supported modes are:

- CBC `AESMode.cbc`
- CFB-64 `AESMode.cfb64`
- CTR `AESMode.ctr`
- ECB `AESMode.ecb` *(deprecated — leaks plaintext patterns)*
- GCM `AESMode.gcm` *(authenticated encryption with associated data)*
- OFB-64/GCTR `AESMode.ofb64Gctr`
- OFB-64 `AESMode.ofb64`
- SIC `AESMode.sic`

GCM usage example (12-byte IV):

```dart
import 'dart:convert';
import 'package:encrypt/encrypt.dart';

void main() {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(12);
  final aad = utf8.encode('context');
  final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

  final encrypted = encrypter.encrypt('hello', iv: iv, associatedData: aad);
  final decrypted = encrypter.decrypt(encrypted, iv: iv, associatedData: aad);

  print(decrypted); // hello
}
```

##### No/zero padding

To remove padding, pass `null` to the `padding` named parameter on the constructor:

```dart
final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
```

#### Salsa20

```dart
import 'package:encrypt/encrypt.dart';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(8);
  final encrypter = Encrypter(Salsa20(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // CR+IAWBEx3sA/dLkkFM/orYr9KftrGa7lIFSAAmVPbKIOLDOzGwEi9ohstDBqDLIaXMEeulwXQ==
}
```

#### [Fernet](https://github.com/fernet/spec/blob/master/Spec.md)

```dart
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

  final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0,32));
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  final fernet = Fernet(b64key);
  final encrypter = Encrypter(fernet);

  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // random cipher text
  print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
}
```

### Asymmetric

#### RSA

```dart
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

Future<void> main() async {
  final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');

  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));

  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // kO9EbgbrSwiq0EYz0aBdljHSC/rci2854Qa+nugbhKjidlezNplsEqOxR+pr1RtICZGAtv0YGevJBaRaHS17eHuj7GXo1CM3PR6pjGxrorcwR5Q7/bVEePESsimMbhHWF+AkDIX4v0CwKx9lgaTBgC8/yJKiLmQkyDCj64J3JSE=
}
```

`RSAKeyParser` is provided by `package:encrypt/encrypt.dart` (not by PointyCastle).  
If your private key PEM is encrypted with a passphrase (`Proc-Type: 4,ENCRYPTED`), decrypt it first before parsing.

### Signature and verification

#### RSA

```dart
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

Future<void> main() async {
 final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
 final privateKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');
 final signer = Signer(
   RSASigner(
     RSASignDigest.sha256,
     publicKey: publicKey,
     privateKey: privateKey,
   ),
 );

 print(signer.sign('hello world').base64);
 print(signer.verify64('hello world', 'jfMhNM2v6hauQr6w3ji0xNOxGInHbeIH3DHlpf2W3vmSMyAuwGHG0KLcunggG4XtZrZPAib7oHaKEAdkHaSIGXAtEqaAvocq138oJ7BEznA4KVYuMcW9c8bRy5E4tUpikTpoO+okHdHr5YLc9y908CAQBVsfhbt0W9NClvDWegs='));
}
```

## Platform and compliance notes

- Random key/IV generation in this package uses Dart `Random.secure()` via `SecureRandom`.
- This is a pure Dart package; it does not bundle native iOS binaries. If your app targets App Store distribution, privacy manifest declarations are owned by the app and its shipped SDKs.
- Export/compliance requirements for encryption are app- and jurisdiction-specific; verify your own distribution obligations.
