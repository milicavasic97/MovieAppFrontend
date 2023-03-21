import 'package:flutter/material.dart';
import 'package:movie_app/providers/search_provider.dart';
import 'package:movie_app/widgets/horizontal_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchingBody extends StatelessWidget {
  const SearchingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final localization = AppLocalizations.of(context);

    return HorizontalListWidget(
        title: localization!.search_results,
        contentElements: searchProvider.searchList);
  }
}
