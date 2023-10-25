import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pages/preference/provider.dart';

import '../../components/button_primary_widget.dart';

List<Widget> steps = [
  StepOnePageContent(),
  StepTwoPageContent(),
];
List<String> hobbies = [
  'Beaches',
  'Mountains',
  'Forests',
  'Deserts',
  'National parks',
  'Caves',
  'Waterfalls',
  'Hot springs',
  'Glaciers',
  'Volcanoes',
  // Add more hobbies as needed
];
List<String> preferences = [
  'Hiking',
  'Biking',
  'Swimming',
  'Skiing',
  'Surfing',
  'Snorkeling',
  'Diving',
  'Kayaking',
  'Fishing',
  'Camping',
  // Add more hobbies as needed
];

class PreferencePage extends StatefulWidget {
  const PreferencePage({Key? key}) : super(key: key);

  static const String routeName = 'preference';
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  PageController? _pageController;
  int _pageIndex = 0;
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);

    // TODO: implement initState
  }

  List<String> selectedHobbies = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SizedBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 48,
              ),
              Image.asset(
                'assets/images/netourism-logo.png',
                scale: 1.5,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Aidez nous a personaliser votre centres d’interet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16),
              Container(
                child: Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemCount: steps.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => steps[index],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                            text: 'Skip',
                            style: TextStyle(
                                color: Color(0xffEE9321),
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                      ],
                      style: Theme.of(context).textTheme.bodySmall!.merge(
                          const TextStyle(
                              color: Color(0xff979797), fontSize: 14)),
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    width: width * 0.4,
                    child: ButtonPrimaryWidget(
                        title: 'Continuer', onPressed: () => {}),
                  ),
                ],
              ),
              SizedBox(height: 32),
              /* Divider(
                color: Color(0xffC7C7C7),
                thickness: 0.5,
              )*/
            ],
          ))),
    );
  }
}

class StepOnePageContent extends ConsumerStatefulWidget {
  const StepOnePageContent({Key? key}) : super(key: key);

  @override
  _StepOnePageContentState createState() => _StepOnePageContentState();
}

class _StepOnePageContentState extends ConsumerState<StepOnePageContent> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> selectedHobbies = ref.watch(selectedHobbiesProvider);
    return Column(
      children: [
        Text(
          'Veuillez selectionnez depuis la liste des endrois ci dessus ce qui vous interesse',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .merge(TextStyle(color: Color(0xff3E3E3E))),
        ),
        SizedBox(height: 16),
        Container(
          height: height * 0.5,
          child: ListView.builder(
            itemCount: hobbies.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Color(0xffEE9321),
                checkboxShape: CircleBorder(
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
                      print('addr');
                    } else {
                      ref
                          .read(selectedHobbiesProvider.notifier)
                          .state
                          .remove(hobbies[index]);
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

class StepTwoPageContent extends ConsumerStatefulWidget {
  const StepTwoPageContent({Key? key}) : super(key: key);

  @override
  _StepTwoPageContentState createState() => _StepTwoPageContentState();
}

class _StepTwoPageContentState extends ConsumerState<StepTwoPageContent> {
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
              .merge(TextStyle(color: Color(0xff3E3E3E))),
        ),
        SizedBox(height: 16),
        Container(
          height: height * 0.5,
          child: ListView.builder(
            itemCount: preferences.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Color(0xffEE9321),
                checkboxShape: CircleBorder(
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
