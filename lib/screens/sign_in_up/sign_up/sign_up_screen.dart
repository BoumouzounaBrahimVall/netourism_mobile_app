import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netourism_mobile_app/models/sign_up_form_model.dart';
import '../../../models/field_model.dart';
import '../../../providers/provider.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/screen_transitions_widget.dart';
import '../../../widgets/text_form_styled_widget.dart';
import 'sub_screens/preference/preference_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'sign_up';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

String? notEmpty(String? value) {
  if (value!.isEmpty) {
    return 'Ce champ ne devrait pas être vide';
  }
  return null;
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  String? _errorText;

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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    void signUp() {
      if (formKey.currentState!.validate()) {
        print(ref.read(signUpFormModelProvider));
        // Navigator.of(context).pushNamed(PreferenceScreen.routeName);
        Navigator.of(context).push(
          SlideLeftRouteWidget(PreferenceScreen()),
        );
      } else {
        print('not valid');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Veillez rempli tous les champs ')));
      }
      print('clicked');
    }

    List<FieldModel> formFieldsSignUp = [
      FieldModel(
          label: 'First Name',
          controller: TextEditingController(
              text: ref.watch(signUpFormModelProvider).firstName),
          icon: Icons.person,
          placeholder: 'First Name ',
          validator: notEmpty,
          onChanged: (value) {
            print('changed');
            ref.read(signUpFormModelProvider.notifier).state.firstName = value;
          }),
      FieldModel(
          label: 'Last Name',
          controller: TextEditingController(
              text: ref.watch(signUpFormModelProvider).lastName),
          icon: Icons.person,
          placeholder: 'Last Name ',
          errorString: null,
          onChanged: (value) {
            print('changed');
            ref.read(signUpFormModelProvider).lastName = value;
          }),
      FieldModel(
          label: 'Email',
          controller: TextEditingController(
              text: ref.watch(signUpFormModelProvider).mail),
          icon: Icons.mail,
          validator: notEmpty,
          errorString: null,
          placeholder: 'Email ',
          onChanged: (value) {
            ref.read(signUpFormModelProvider).mail = value;
          }),
      FieldModel(
          label: 'Mot de passe',
          controller: TextEditingController(
              text: ref.watch(signUpFormModelProvider).password),
          icon: Icons.lock,
          errorString: null,
          validator: notEmpty,
          placeholder: 'Mot de passe ',
          isPassword: true,
          onChanged: (value) {
            ref.read(signUpFormModelProvider).password = value;
          }),
      FieldModel(
          label: 'Confirmation de Mot de passe',
          controller: TextEditingController(
              text: ref.watch(signUpFormModelProvider).confirmPassword),
          icon: Icons.lock,
          errorString: null,
          validator: notEmpty,
          isPassword: true,
          placeholder: 'Confirmation de Mot de passe ',
          onChanged: (value) {
            ref.read(signUpFormModelProvider).confirmPassword = value;
          }),
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: SizedBox(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
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
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ...formFieldsSignUp.map((field) {
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
              const SizedBox(height: 16),
              ButtonPrimaryWidget(title: 'Je m\'inscris', onPressed: signUp),
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
            ],
          )))),
    ));
  }
}
