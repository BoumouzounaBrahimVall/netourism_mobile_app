import 'package:flutter/material.dart';
import 'package:netourism_mobile_app/constants/constants.dart';
import 'package:netourism_mobile_app/widgets/model_bottom_sheet_widget.dart';
import 'package:netourism_mobile_app/widgets/random_avatar_widget.dart';
import 'package:netourism_mobile_app/widgets/button_primary_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullname = '';
  String email = '';
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getInfos() async {
    prefs = await SharedPreferences.getInstance();

    fullname = prefs.getString(CacheVariableNames.fullName) ?? " ";
    email = prefs.getString(CacheVariableNames.email) ?? " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.amber,
        body: FutureBuilder(
      future: getInfos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("loading..."),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RandomAvatar(
                    email + fullname,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    fullname,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Divider(),
                  ListTile(
                      title: const Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        modalBottomSheetWidget(context,
                            initialChildSize: 0.8,
                            maxChildSize: 0.9,
                            minChildSize: 0.5,
                            child: aboutUsWidget);
                      }),
                  const Divider(),
                  ListTile(
                      title: const Text(
                        'Terms and Policies',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        modalBottomSheetWidget(context,
                            initialChildSize: 0.8,
                            maxChildSize: 0.9,
                            minChildSize: 0.5,
                            child: termsAndPolociesWidget);
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonPrimaryWidget(
                    title: 'Sign out',
                    onPressed: () {
                      prefs.setBool(CacheVariableNames.isConnected, false);
                      Navigator.of(context).pushReplacementNamed("/");
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    ));
  }

  List<String> aboutUs = [
    "Netourism is a cutting-edge platform catering to users, managers, and administrators, revolutionizing how individuals interact with local experiences.",
    "Users can seamlessly share events, explore media content linked to specific locations, and engage with registered places, enabling direct communication with managers and easy content reservations.",
    " Managers, including restaurant and hotel owners, benefit from effortless place registration, detailed descriptions, and responsive interaction with users.",
    " With features like ephemeral media content, interactive map exploration, and a robust chat system, Netourism is committed to fostering connections, empowering local businesses, and delivering an immersive experience that transcends traditional exploration."
  ];
  Widget aboutUsWidget = Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/netourism-logo.png'),
        const SizedBox(height: 60.0),
        const Text(
          'About Us',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Column(
          children: [
            "Netourism is a cutting-edge platform catering to users, managers, and administrators, revolutionizing how individuals interact with local experiences.",
            "Users can seamlessly share events, explore media content linked to specific locations, and engage with registered places, enabling direct communication with managers and easy content reservations.",
            " Managers, including restaurant and hotel owners, benefit from effortless place registration, detailed descriptions, and responsive interaction with users.",
            " With features like ephemeral media content, interactive map exploration, and a robust chat system, Netourism is committed to fostering connections, empowering local businesses, and delivering an immersive experience that transcends traditional exploration."
          ]
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    e,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    ),
  );
  Widget termsAndPolociesWidget = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Previous content...
        // ... (Terms and Conditions and Privacy Policy sections)

        SizedBox(height: 20.0),

        Text(
          'Cookies Policy',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '''
              Our app uses cookies. By using our app and agreeing to this policy, you consent to our use of cookies in accordance with the terms of this policy.
  
              Cookies are small files that are stored on your device's browser. They are used to remember your preferences and improve your experience.
  
              You can choose to disable cookies through your browser settings. However, please note that disabling cookies may affect the functionality of our app.
  
              We use cookies for authentication, analytics, and to enhance user experience. We do not use cookies for any other purposes.
  
              By using our app, you agree to our use of cookies as described in this policy.
              ''',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: 20.0),

        Text(
          'Changes to These Policies',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '''
              We reserve the right to modify these terms and policies at any time. Changes and clarifications will take effect immediately upon their posting on the app.
  
              If we make material changes to these policies, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.
  
              Your continued use of the app after any such modifications will constitute your acknowledgment of the modified policies and your consent to abide and be bound by the updated terms and policies.
              ''',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
