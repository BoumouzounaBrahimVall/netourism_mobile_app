import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/components/button_primary_widget.dart';
import '/pages/sign_in/text_form_styled.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String routeName = 'sign_in';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: SizedBox(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/netourism-logo.png',
                scale: 1.5,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Acceder a mon compte',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16),
              Text(
                'Veuillez entrer votre login',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .merge(TextStyle(color: Color(0xff3E3E3E))),
              ),
              SizedBox(height: 16),
              TextFormStyled(
                  label: 'Email',
                  placeholder: 'Email',
                  icon: Icons.email,
                  validator: () => {}),
              SizedBox(height: 16),
              TextFormStyled(
                  label: 'Mot de passe',
                  placeholder: 'Mot de passe',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: () => {}),
              SizedBox(height: 16),
              ButtonPrimaryWidget(title: 'Se connecter', onPressed: () => {}),
              SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: 'Vous n\'avez pas de compte ? ',
                  children: [
                    TextSpan(
                        text: 'S\'inscrire',
                        style: TextStyle(
                            color: Color(0xffEE9321),
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                  ],
                  style: Theme.of(context).textTheme.bodySmall!.merge(
                      const TextStyle(color: Color(0xff979797), fontSize: 14)),
                ),
              ),
              SizedBox(height: 16),
              /* Divider(
                color: Color(0xffC7C7C7),
                thickness: 0.5,
              )*/
            ],
          )))),
    );
  }
}
