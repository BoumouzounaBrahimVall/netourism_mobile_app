import 'package:flutter/material.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/text_form_styled_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                'Créer mon compte',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Veuillez entrer votre Information',
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
              TextFormStyledWidget(
                  label: 'Confirmation de mot de passe',
                  placeholder: 'Confirmation de mot de passe',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: () => {}),
              const SizedBox(height: 16),
              ButtonPrimaryWidget(title: 'Se connecter', onPressed: () => {}),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: 'Vous avez un compte ? ',
                  children: const [
                    TextSpan(
                        text: 'Se connecter',
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
