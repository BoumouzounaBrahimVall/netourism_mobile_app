import 'package:flutter/material.dart';
import '../preference/steps/preference_step1_screen.dart';
import '../preference/steps/preference_step2_screen.dart';
import '../../../../../widgets/button_primary_widget.dart';

List<Widget> steps = [
  const PreferencesStep1Screen(),
  const PreferencesStep2Screen(),
];

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  static const String routeName = 'preference';
  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    _pageIndex = 0;
  }

  List<String> selectedHobbies = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SizedBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 48,
              ),
              Image.asset(
                'assets/images/netourism-logo.png',
                scale: 1.5,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Aidez nous a personaliser votre centres d’interet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Container(
                height: 450,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: const [
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
                  const SizedBox(height: 32),
                  SizedBox(
                    width: width * 0.4,
                    child: ButtonPrimaryWidget(
                        title: 'Continuer',
                        onPressed: () => {
                              if (_pageIndex == 1)
                                {
                                  // Navigator.of(context).pushNamed(routeName)
                                }
                              else
                                {
                                  _pageIndex++,
                                  _pageController!.animateToPage(_pageIndex,
                                      curve: Curves.easeIn,
                                      duration: const Duration(
                                          days: 0,
                                          hours: 0,
                                          microseconds: 500,
                                          seconds: 0,
                                          minutes: 0,
                                          milliseconds: 0))
                                }
                            }),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              /* Divider(
                color: Color(0xffC7C7C7),
                thickness: 0.5,
              )*/
            ],
          ))),
    );
  }
}
