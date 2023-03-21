import 'package:flutter/material.dart';
import 'package:movie_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Scaffold(
        body: Consumer<UserProvider>(
          builder: (context, value, child) => Body(),
        ),
      ),
    );
  }
}
