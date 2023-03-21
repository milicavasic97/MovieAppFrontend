import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/navigation/home_navigation.dart';
import 'package:movie_app/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final localization = AppLocalizations.of(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.95,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                localization!.login,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.empty_field_validation;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: localization.username,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: const Icon(
                          Icons.account_circle_sharp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localization.empty_field_validation;
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: localization.password,
                        border:
                            const OutlineInputBorder(borderSide: BorderSide()),
                        prefixIcon: const Icon(Icons.vpn_key),
                        // suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Consumer<LoginProvider>(
                  builder: (context, loginProvide, child) => ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        loginProvide
                            .login(usernameController.text,
                                passwordController.text)
                            .then(
                          (value) {
                            if (value) {
                              Navigator.of(context).pop();
                              Navigator.pushReplacementNamed(
                                  context, HomeNavigation.routeName);
                            } else {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Text(localization.error),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    child: Text(localization.login),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Align(
              //   alignment: FractionalOffset.bottomCenter,
              //   child: InkWell(
              //     child: const Text("Forgot password?"),
              //     onTap: () => print("forgot pass"),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
