import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoContentWidget extends StatelessWidget {
  const NoContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        localization!.no_content,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
