import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../providers/provider.dart';
import '/data/preference_data.dart';

class PreferencesStep1Screen extends ConsumerStatefulWidget {
  const PreferencesStep1Screen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreferencesStep1Screen> createState() =>
      _PreferencesStep1ScreenState();
}

class _PreferencesStep1ScreenState
    extends ConsumerState<PreferencesStep1Screen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<String> selectedHobbies =
        ref.watch(signUpFormModelProvider).preferedHobbies ?? [];
    return Column(
      children: [
        Text(
          'Veuillez selectionnez depuis la liste des endrois ci dessus ce qui vous interesse',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .merge(const TextStyle(color: Color(0xff3E3E3E))),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: height * 0.5,
          child: ListView.builder(
            itemCount: hobbies.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                checkColor: Colors.white,
                activeColor: const Color(0xffEE9321),
                checkboxShape: const CircleBorder(
                    side: BorderSide(color: Color(0xffEE9321), width: 20)),
                title: Text(
                  hobbies[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: selectedHobbies.contains(hobbies[index]) ? true : false,
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      ref
                          .read(selectedHobbiesProvider.notifier)
                          .state
                          .add(hobbies[index]);
                      // ignore: avoid_print
                      print('addr');
                    } else {
                      ref
                          .read(selectedHobbiesProvider.notifier)
                          .state
                          .remove(hobbies[index]);
                      // ignore: avoid_print
                      print('remove');
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
