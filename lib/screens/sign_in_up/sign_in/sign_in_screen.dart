import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netourism_mobile_app/models/field_model.dart';
import 'package:netourism_mobile_app/screens/main/home/home_screen_navigation_widget.dart';
import 'package:netourism_mobile_app/widgets/show_dialog_widget.dart';
import '../../../providers/provider.dart';
import '../sign_up/sign_up_screen.dart';
import '/widgets/screen_transitions_widget.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/text_form_styled_widget.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = 'sign_in';

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    void validateField(FieldModel field, String value) {
      if (value.isEmpty) {
        setState(() {
          field.errorString = 'Ce champ ne devrait pas être vide';
        });
      } else {
        setState(() {
          field.errorString = null; // Clear the error message
        });
      }
    }

    void signIn() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        print(ref.read(signInFormModelProvider));
        // Navigator.of(context).pushNamed(PreferenceScreen.routeName);
        /*Navigator.of(context).push(
          SlideLeftRouteWidget(PreferenceScreen()),
        );*/
        final signinResult = await ref.read(signinServiceProvider).login(
            ref.read(signInFormModelProvider).mail!,
            ref.read(signInFormModelProvider).password!);
        setState(() {
          isLoading = false;
        });
        signinResult.fold(
          (l) {
            showDialogWidget(context, 'Connexion échouée', l.message);
            debugPrint(l.message);
          },
          (r) {
            showDialogWidget(context, 'Connexion réussie', r.message);
            /*ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Connexion réussie')));*/
            //   ref.read(userUpdateTrigger.notifier).state++;
            /* Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);*/
            Navigator.of(context).push(
              SlideLeftRouteWidget(const HomeScreenNavigationWidget()),
            );
          },
        );
      }
    }

    List<FieldModel> formFieldsLogin = [
      FieldModel(
          label: 'Email',
          controller: TextEditingController(
              text: ref.watch(signInFormModelProvider).mail),
          icon: Icons.mail,
          validator: notEmpty,
          errorString: null,
          placeholder: 'Email ',
          onChanged: (value) {
            ref.read(signInFormModelProvider).mail = value;
          }),
      FieldModel(
          label: 'Mot de passe',
          controller: TextEditingController(
              text: ref.watch(signInFormModelProvider).password),
          icon: Icons.lock,
          errorString: null,
          validator: notEmpty,
          placeholder: 'Mot de passe ',
          isPassword: true,
          onChanged: (value) {
            ref.read(signInFormModelProvider).password = value;
          }),
    ];
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
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ...formFieldsLogin.map((field) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            TextFormStyledWidget(
                              label: field.label ?? '',
                              placeholder: field.placeholder ?? '',
                              controller: field.controller,
                              icon: field.icon ?? Icons.abc,
                              validator: (value) {
                                validateField(field, value);
                                if (value == '')
                                  return 'veuillez remplir';
                                else
                                  return null;
                              },
                              onChanged: (value) {
                                //  validateField(field, value);
                                // if (value == '') field.errorString = value;
                                field.onChanged!(value);
                              },
                              errorText: field.errorString,
                              isPassword: field.isPassword ?? false,
                            )
                          ],
                        );
                      }).toList(),
                    ],
                  )),
              const SizedBox(height: 16),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.orange,
                    )
                  : ButtonPrimaryWidget(
                      title: 'Se connecter', onPressed: signIn),
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
