import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/providers/localization_provider.dart';
import 'package:movie_app/providers/login_provider.dart';
import 'package:movie_app/providers/user_provider.dart';
import 'package:movie_app/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    final localizationProvider = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Provider.of<UserProvider>(context).getUserDetails(),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : Text(
                      (snapshot.data as Map<String, dynamic>)['firstName'] +
                          " " +
                          (snapshot.data as Map<String, dynamic>)['lastName'],
                      style: const TextStyle(
                        fontSize: 35,
                      ),
                    ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    decoration:
                        localizationProvider.locale == const Locale('bs')
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              )
                            : null,
                    child: IconButton(
                      icon: Image.asset("assets/images/srb.png"),
                      iconSize: size.width * 0.15,
                      onPressed: () {
                        if (localizationProvider.locale != const Locale('bs')) {
                          localizationProvider.setLocale(
                            const Locale('bs'),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    decoration:
                        localizationProvider.locale == const Locale('en')
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              )
                            : null,
                    child: IconButton(
                      icon: Image.asset(
                        "assets/images/uk.png",
                      ),
                      iconSize: size.width * 0.15,
                      onPressed: () {
                        if (localizationProvider.locale != const Locale('en')) {
                          localizationProvider.setLocale(
                            const Locale('en'),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            TextButton(
              onPressed: () async {
                Provider.of<LoginProvider>(context, listen: false)
                    .logOut()
                    .then((value) => Navigator.of(context)
                        .pushReplacementNamed(WelcomeScreen.routeName));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localization!.logout + " ",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
