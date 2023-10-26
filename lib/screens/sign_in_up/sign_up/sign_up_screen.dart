import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netourism_mobile_app/models/sign_un_form_model.dart';
import '../../../models/field_model.dart';
import '../../../providers/provider.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/text_form_styled_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    void signUp() {
      if (formKey.currentState!.validate()) {
        print('valid');
      } else {
        print('not valid');
      }
      print('clicked');
      print(ref.read(signupFormModelProvider));
    }

    final firstNameController = TextEditingController(
        text: ref.watch(signupFormModelProvider).firstName);
    List<FieldModel> formFields = [
      /* FieldModel(
          label: 'First Name',
          controller: TextEditingController(
              text: ref.watch(signupFormModelProvider).firstName),
          icon: Icons.person,
          placeholder: 'First Name ',
          validator: notEmpty,
          onChanged: (value) {
            print('changed');
            ref.read(signupFormModelProvider.notifier).state.firstName = value;
          }),*/
      FieldModel(
          label: 'Last Name',
          controller: TextEditingController(
              text: ref.watch(signupFormModelProvider).lastName),
          icon: Icons.person,
          validator: notEmpty,
          placeholder: 'Last Name ',
          onChanged: (value) {
            print('changed');
            ref.read(signupFormModelProvider).lastName = value;
          }),
      FieldModel(
          label: 'Email',
          controller: TextEditingController(
              text: ref.watch(signupFormModelProvider).mail),
          icon: Icons.mail,
          validator: notEmpty,
          placeholder: 'Email ',
          onChanged: (value) {
            print('changed');
            ref.read(signupFormModelProvider).mail = value;
          }),
      FieldModel(
          label: 'Mot de passe',
          controller: TextEditingController(
              text: ref.watch(signupFormModelProvider).password),
          icon: Icons.lock,
          validator: notEmpty,
          placeholder: 'Mot de passe ',
          isPassword: true,
          onChanged: (value) {
            ref.read(signupFormModelProvider).password = value;
          }),
      FieldModel(
          label: 'Confirmation de Mot de passe',
          controller: TextEditingController(
              text: ref.watch(signupFormModelProvider).confirmPassword),
          icon: Icons.lock,
          validator: notEmpty,
          isPassword: true,
          placeholder: 'Confirmation de Mot de passe ',
          onChanged: (value) {
            ref.read(signupFormModelProvider).confirmPassword = value;
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
                      ...formFields.map((field) {
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
                              validator: notEmpty,
                              onChanged: (value) {
                                print('sajcasc');
                                field.onChanged!(value);
                              },
                              isPassword: field.isPassword ?? false,
                            )
                          ],
                        );
                      }).toList(),
                    ],
                  )),
              const SizedBox(height: 16),
              /* TextFormStyledWidget(
                label: 'First Name',
                placeholder: 'First Name',
                controller: firstNameController,
                icon: Icons.person,
                validator: notEmpty,
                onChanged: (value) {
                  print('cscs');

                  ref.read(signupFormModelProvider).firstName = value;
                },
              )*/
              /*
              ,
              const SizedBox(height: 16),
              TextFormStyledWidget(
                label: 'Last Name',
                placeholder: 'Last Name',
                controller: lastNameController,
                icon: Icons.person,
                validator: notEmpty,
                onChanged: (value) {
                  ref.read(signupFormModelProvider).lastName = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormStyledWidget(
                label: 'Email',
                placeholder: 'Email',
                controller: mailController,
                icon: Icons.email,
                validator: notEmpty,
                onChanged: (value) {
                  ref.read(signupFormModelProvider).mail = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormStyledWidget(
                label: 'Mot de passe',
                placeholder: 'Mot de passe',
                controller: passwordController,
                icon: Icons.lock,
                isPassword: true,
                validator: notEmpty,
                onChanged: (value) {
                  ref.read(signupFormModelProvider).password = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormStyledWidget(
                label: 'Confirmation de mot de passe',
                placeholder: 'Confirmation de mot de passe',
                icon: Icons.lock,
                isPassword: true,
                validator: notEmpty,
                onChanged: (value) {
                  ref.read(signupFormModelProvider).confirmPassword = value;
                },
              ),*/

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
              /* Divider(
                color: Color(0xffC7C7C7),
                thickness: 0.5,
              )*/
            ],
          )))),
    ));
  }
}
