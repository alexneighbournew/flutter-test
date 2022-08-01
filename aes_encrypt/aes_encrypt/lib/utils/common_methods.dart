import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as encrypt;

class CommonMethods {

  static dynamic encryptText({String? key, required String text}) {
    if (text.isNotEmpty) {
      final encrypterKey = key != null
          ? encrypt.Key.fromBase64(key)
          : encrypt.Key.fromSecureRandom(32);
      final encrypterIv = encrypt.IV.fromLength(16);
      final encrypter =
          encrypt.Encrypter(encrypt.AES(encrypterKey, mode: encrypt.AESMode.cbc));
      final encrypted = encrypter.encrypt(text, iv: encrypterIv);

      return {
        'key': encrypterKey.base64,
        'text': encrypted.base64,
      };
    } else {
      return {
        'key': '',
        'text': '',
      };
    }
  }

  static dynamic decryptText({String? key, required Encrypted encrypted}) {
    if (encrypted.toString().isNotEmpty) {
      final encrypterKey = key != null
          ? encrypt.Key.fromBase64(key)
          : encrypt.Key.fromSecureRandom(32);
      final encrypterIv = encrypt.IV.fromLength(16);
      final encrypter =
          encrypt.Encrypter(encrypt.AES(encrypterKey, mode: encrypt.AESMode.cbc));
      final decrypted = encrypter.decrypt(encrypted, iv: encrypterIv);

      return {
        'key': encrypterKey.base64,
        'text': decrypted,
      };
    } else {
      return {
        'key': '',
        'text': '',
      };
    }
  }

  static showToast(BuildContext context, String text) {
    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        SnackBar(
          content: Text(text)
        )
      );  
  }
}