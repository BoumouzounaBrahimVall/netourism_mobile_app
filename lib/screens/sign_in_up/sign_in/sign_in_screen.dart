import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../sign_up/sign_up_screen.dart';
import '/widgets/screen_transitions_widget.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/text_form_styled_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = 'sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              const SizedBox(
                height: 32,
              ),
              Text(
                'Acceder a mon compte',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Veuillez entrer votre login',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .merge(const TextStyle(color: Color(0xff3E3E3E))),
              ),
              const SizedBox(height: 16),
              TextFormStyledWidget(
                  label: 'Email',
                  placeholder: 'Email',
                  icon: Icons.email,
                  validator: () => {}),
              const SizedBox(height: 16),
              TextFormStyledWidget(
                  label: 'Mot de passe',
                  placeholder: 'Mot de passe',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: () => {}),
              const SizedBox(height: 16),
              ButtonPrimaryWidget(title: 'Se connecter', onPressed: () => {}),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "Vous n'avez pas de compte ? ",
                  children: [
                    TextSpan(
                        text: "S'inscrire",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              SlideTopRouteWidget(
                                const SignUpScreen(),
                              ),
                            );
                          },
                        style: const TextStyle(
                            color: Color(0xffEE9321),
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                  ],
                  style: Theme.of(context).textTheme.bodySmall!.merge(
                      const TextStyle(color: Color(0xff979797), fontSize: 14)),
                ),
              ),
              const SizedBox(height: 16),
              /* Divider(
                color: Color(0xffC7C7C7),
                thickness: 0.5,
              )*/
            ],
          )))),
    );
  }
}
