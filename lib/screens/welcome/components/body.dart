import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/screens/login/login_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.96,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/welcome.png",
                height: size.height * 0.3,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                localization!.welcome_title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(localization.signin),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const Text(
                "By Continuing you agree to the Terms and Conditions",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
