import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:aes_encrypt/utils/utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Encriptado AES256'),
        ),
        body: const MainForm(),
      ),
    );
  }
}

class MainForm extends StatefulWidget {
  const MainForm({
    Key? key,    
  }) : super(key: key);

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {

  final txtController = TextEditingController();
  String encryptedText = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: txtController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese un texto para encriptar',
              ),
              onChanged: (text) => setState(() {
                encryptedText = (_getEncryptedText(text) )['text'];
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txtController.text),
                Row(
                  children: [
                    SelectableText(encryptedText),
                    encryptedText.isNotEmpty
                      ? IconButton(
                        tooltip: 'Copiar',
                        onPressed: () => Clipboard
                          .setData(ClipboardData(text: encryptedText))
                          .then((value) => CommonMethods.showToast(context, "Clave copiada al Portapapeles") ), 
                        icon: const Icon(
                          Icons.copy
                        )
                      ) : Container()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getEncryptedText(String txt) {
    dynamic encrypted = encryptText(
      text: txt,
      key: 'zhjhpyQ4hoHn2t6PFfdD1DXPOhe/EEq+uahHJYzNhF8='
    );
    return encrypted;
  }
}

dynamic encryptText({String? key, required String text}) {
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