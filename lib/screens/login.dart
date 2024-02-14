import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voco/screens/register.dart';
import 'package:voco/widgets/centered_button.dart';
import 'package:voco/widgets/text_button.dart';
import 'package:voco/widgets/text_field_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:voco/screens/homepage.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _appbarTitle = "Voco Case";
  final _logo = "Welcome Voco";
  final _emailText = "Lütfen mail adresinizi giriniz";
  final _passwordText = "Lütfen şifrenizi giriniz";
  final _loginButton = "Giriş Yap";
  final _registerSentence = "Henüz bir hesabın yok mu?";
  final _registerButton = "Üye Ol.";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); 
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userStatus = prefs.getInt('userStatus');
    if (userStatus == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse('https://reqres.in/api/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userStatus', 1);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hata'),
          content: Text('E-posta veya şifre hatalı. Lütfen tekrar deneyin.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appbarTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
          child: Padding(
        padding: PagePaggins().pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/voco.jpeg",
              height: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _logo,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldInput(
                hintText: _emailText,
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
              hintText: _passwordText,
              textEditingController: _passwordController,
              textInputType: TextInputType.emailAddress,
              isPass: true,
            ),
            const SizedBox(
              height: 30,
            ),
            _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),) : CenteredButton(onPress: _isLoading ? null : _login, text: _loginButton),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _registerSentence,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                LoginTextButton(
                    onPress: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const RegisterView()));
                    },
                    text: _registerButton)
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      )),
    );
  }
}

class PagePaggins {
  final pagePadding = const EdgeInsets.symmetric(horizontal: 20) +
      const EdgeInsets.symmetric(vertical: 5);
}
