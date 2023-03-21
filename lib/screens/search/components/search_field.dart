import 'package:flutter/material.dart';
import 'package:movie_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChange;

  const SearchField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final localization = AppLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Center(
        child: TextField(
          onChanged: (value) {
            searchProvider.searchContent(value);
            onChange(value);
          },
          decoration: InputDecoration(
            hintText: localization!.search_hint,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
