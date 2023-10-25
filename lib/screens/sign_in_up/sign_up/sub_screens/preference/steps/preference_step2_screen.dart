import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/data/preference_data.dart';
import 'provider.dart';

class PreferencesStep2Screen extends ConsumerStatefulWidget {
  const PreferencesStep2Screen({Key? key}) : super(key: key);

  @override
  _PreferencesStep2ScreenState createState() => _PreferencesStep2ScreenState();
}

class _PreferencesStep2ScreenState
    extends ConsumerState<PreferencesStep2Screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> selectedPreferences = ref.watch(selectedPreferencesProvider);
    return Column(
      children: [
        Text(
          'Veuillez selectionnez depuis la liste des preferences ci dessus ce qui vous interesses',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .merge(const TextStyle(color: Color(0xff3E3E3E))),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: height * 0.5,
          child: ListView.builder(
            itemCount: preferences.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                checkColor: Colors.white,
                activeColor: const Color(0xffEE9321),
                checkboxShape: const CircleBorder(
                    side: BorderSide(color: Color(0xffEE9321), width: 20)),
                title: Text(
                  preferences[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: selectedPreferences.contains(preferences[index])
                    ? true
                    : false,
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      ref
                          .read(selectedPreferencesProvider.notifier)
                          .state
                          .add(preferences[index]);
                      print('addr');
                    } else {
                      ref
                          .read(selectedPreferencesProvider.notifier)
                          .state
                          .remove(preferences[index]);
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
