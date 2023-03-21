import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:movie_app/helpers/token.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/navigation/home_navigation.dart';
import 'package:movie_app/providers/localization_provider.dart';
import 'package:movie_app/providers/login_provider.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/screens/welcome/welcome_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => LoginProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) =>
                      LocalizationProvider(snapshot.data as SharedPreferences),
                ),
              ],
              builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                supportedLocales: L10n.all,
                locale: Provider.of<LocalizationProvider>(context).locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                theme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.grey,
                ),
                home: FutureBuilder(
                  future: Token.getJwtToken(),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? const Center()
                      : snapshot.data != null &&
                              !JwtDecoder.isExpired(snapshot.data.toString())
                          ? const HomeNavigation()
                          : const WelcomeScreen(),
                ),
                initialRoute: "/",
                routes: {
                  HomeNavigation.routeName: (context) => const HomeNavigation(),
                  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                },
              ),
            ),
    );
  }
}
