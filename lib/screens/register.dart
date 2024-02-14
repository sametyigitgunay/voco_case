import 'package:flutter/material.dart';
import 'package:voco/screens/login.dart';
import 'package:voco/widgets/centered_button.dart';
import 'package:voco/widgets/text_button.dart';
import 'package:voco/widgets/text_field_input.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _appbarTitle = "Voco Case";
  final _logo = "Welcome Voco";
  final _emailText = "Lütfen mail adresinizi giriniz";
  final _nameText = "Lütfen adınızı ve soyadınızı giriniz";
  final _passwordText = "Lütfen şifrenizi giriniz";
  final _loginButton = "Üye Ol";
  final _registerSentence = "Zaten bir hesabın var mı?";
  final _registerButton = "Giriş Yap.";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
                hintText: _nameText,
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
            CenteredButton(onPress: () {}, text: _loginButton),
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
                          builder: (context) => const LoginView()));
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
