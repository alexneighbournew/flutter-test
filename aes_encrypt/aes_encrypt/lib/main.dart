import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aes_encrypt/utils/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Encriptado AES256'),
        ),
        body: MainForm(),
      ),
    );
  }
}

class MainForm extends StatefulWidget {  

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {

  final txtEncryptController = TextEditingController();
  final txtDecryptController = TextEditingController();
  String encryptedText = '';
  String decryptedText = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    txtEncryptController.dispose();
    txtDecryptController.dispose();
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
              controller: txtEncryptController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese un texto para encriptar',
                label: Text('Texto a encriptar'),
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
                Text(txtEncryptController.text),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: txtDecryptController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese un texto para desencriptar',
                label: Text('Texto a desencriptar'),
              ),
              onChanged: (text) => setState(() {
                decryptedText = _getDecryptedText(text);
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txtDecryptController.text),
                Row(
                  children: [
                    SelectableText(decryptedText),
                    decryptedText.isNotEmpty
                      ? IconButton(
                        tooltip: 'Copiar',
                        onPressed: () => Clipboard
                          .setData(ClipboardData(text: decryptedText))
                          .then((value) => CommonMethods.showToast(context, "Clave desencriptada copiada al Portapapeles") ), 
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

  String _getDecryptedText(String encrypted) {
    Encrypted tmpEncrypted;
    try {
      tmpEncrypted = Encrypted.fromBase64(encrypted);
      print('tmpEncrypted: $tmpEncrypted');
      if( tmpEncrypted.toString().isNotEmpty ) {
        String decrypted = CommonMethods.decryptText(
          encrypted: tmpEncrypted,
          key: 'zhjhpyQ4hoHn2t6PFfdD1DXPOhe/EEq+uahHJYzNhF8='
        );
        return decrypted;
      }
    } catch (e) {
      print('error Encrypted.fromBase64: $e');
    }
    return '';
  }

  _getEncryptedText(String txt) {
    dynamic encrypted = CommonMethods.encryptText(
      text: txt,
      key: 'zhjhpyQ4hoHn2t6PFfdD1DXPOhe/EEq+uahHJYzNhF8='
    );
    return encrypted;
  }
}