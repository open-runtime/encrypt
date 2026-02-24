part of '../../encrypt.dart';

/// Wraps the AES Algorithm.
class AES implements Algorithm {
  final Key key;
  final AESMode mode;
  final String? padding;
  late final BlockCipher _cipher;
  final StreamCipher? _streamCipher;

  AES(this.key, {this.mode = AESMode.sic, this.padding = 'PKCS7'})
    : _streamCipher = padding == null && _streamable.contains(mode) ? StreamCipher('AES/${_modes[mode]}') : null {
    if (key.bytes.length != 16 && key.bytes.length != 24 && key.bytes.length != 32) {
      throw ArgumentError(
        'AES key must be 16, 24, or 32 bytes (128, 192, or 256 bits). '
        'Got ${key.bytes.length} bytes.',
      );
    }
    if (mode == AESMode.gcm) {
      _cipher = GCMBlockCipher(AESEngine());
    } else {
      _cipher = padding != null
          ? PaddedBlockCipher('AES/${_modes[mode]}/$padding')
          : BlockCipher('AES/${_modes[mode]}');
    }
  }

  @override
  Encrypted encrypt(Uint8List bytes, {IV? iv, Uint8List? associatedData}) {
    if (mode != AESMode.ecb && iv == null) {
      throw StateError('IV is required.');
    }
    if (iv != null) {
      if (mode == AESMode.gcm && iv.bytes.length != 12) {
        throw ArgumentError('GCM mode requires a 12-byte IV (96 bits). Got ${iv.bytes.length} bytes.');
      } else if (mode != AESMode.ecb && mode != AESMode.gcm && iv.bytes.length != 16) {
        throw ArgumentError('AES ${_modes[mode]} mode requires a 16-byte IV (128 bits). Got ${iv.bytes.length} bytes.');
      }
    }

    if (_streamCipher != null) {
      _streamCipher
        ..reset()
        ..init(true, _buildParams(iv, associatedData: associatedData));

      return Encrypted(_streamCipher.process(bytes));
    }

    _cipher
      ..reset()
      ..init(true, _buildParams(iv, associatedData: associatedData));

    if (padding != null) {
      return Encrypted(_cipher.process(bytes));
    }

    return Encrypted(_processBlocks(bytes));
  }

  @override
  Uint8List decrypt(Encrypted encrypted, {IV? iv, Uint8List? associatedData}) {
    if (mode != AESMode.ecb && iv == null) {
      throw StateError('IV is required.');
    }
    if (iv != null) {
      if (mode == AESMode.gcm && iv.bytes.length != 12) {
        throw ArgumentError('GCM mode requires a 12-byte IV (96 bits). Got ${iv.bytes.length} bytes.');
      } else if (mode != AESMode.ecb && mode != AESMode.gcm && iv.bytes.length != 16) {
        throw ArgumentError('AES ${_modes[mode]} mode requires a 16-byte IV (128 bits). Got ${iv.bytes.length} bytes.');
      }
    }

    if (_streamCipher != null) {
      _streamCipher
        ..reset()
        ..init(false, _buildParams(iv, associatedData: associatedData));

      return _streamCipher.process(encrypted.bytes);
    }

    _cipher
      ..reset()
      ..init(false, _buildParams(iv, associatedData: associatedData));

    if (padding != null) {
      return _cipher.process(encrypted.bytes);
    }

    return _processBlocks(encrypted.bytes);
  }

  Uint8List _processBlocks(Uint8List input) {
    var output = Uint8List(input.lengthInBytes);

    for (int offset = 0; offset < input.lengthInBytes;) {
      offset += _cipher.processBlock(input, offset, output, offset);
    }

    return output;
  }

  CipherParameters _buildParams(IV? iv, {Uint8List? associatedData}) {
    if (mode == AESMode.ecb || iv == null) {
      if (padding != null) {
        return PaddedBlockCipherParameters(KeyParameter(key.bytes), null);
      } else {
        return KeyParameter(key.bytes);
      }
    }

    if (mode == AESMode.gcm) {
      return AEADParameters(KeyParameter(key.bytes), 128, iv.bytes, associatedData ?? Uint8List.fromList([]));
    }

    if (padding != null) {
      return _paddedParams(iv);
    }

    return ParametersWithIV<KeyParameter>(KeyParameter(key.bytes), iv.bytes);
  }

  PaddedBlockCipherParameters _paddedParams(IV iv) {
    if (mode == AESMode.ecb) {
      return PaddedBlockCipherParameters(KeyParameter(key.bytes), null);
    }

    return PaddedBlockCipherParameters(ParametersWithIV<KeyParameter>(KeyParameter(key.bytes), iv.bytes), null);
  }
}

enum AESMode {
  cbc,
  cfb64,
  ctr,

  /// ECB mode encrypts each block independently, leaking plaintext patterns.
  /// Use [AESMode.gcm] or [AESMode.cbc] instead.
  @Deprecated('ECB mode is insecure - it leaks plaintext patterns. Use gcm or cbc instead.')
  ecb,

  ofb64Gctr,
  ofb64,
  sic,
  gcm,
}

const Map<AESMode, String> _modes = {
  AESMode.cbc: 'CBC',
  AESMode.cfb64: 'CFB-64',
  AESMode.ctr: 'CTR',
  AESMode.ecb: 'ECB',
  AESMode.ofb64Gctr: 'OFB-64/GCTR',
  AESMode.ofb64: 'OFB-64',
  AESMode.sic: 'SIC',
  AESMode.gcm: 'GCM',
};

const List<AESMode> _streamable = [AESMode.sic, AESMode.ctr];
