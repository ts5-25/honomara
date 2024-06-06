import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ホノマラ フルマラソンの記録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/logo.jpg'), // 画像ファイルのパスを指定
              width: 150,
              height: 150,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'ユーザー名'),
              style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
              obscureText: true,
            ),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                    email: _emailController.text == 'honomara' ? 'honomara1715@gmail.com' : 'abcd@example.com',
                    password: _passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/recordPage');
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    if (e.code == 'user-not-found' || e.code == 'invalid-email' || e.code == 'invalid-credential' || e.code == 'wrong-password') {
                      _errorMessage = 'ユーザー名またはパスワードが違います。';
                    } else if (e.code == 'channel-error') {
                      _errorMessage = 'パスワードを入力してください。';
                    } else {
                      _errorMessage = 'エラーが発生しました: ${e.code}';
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}