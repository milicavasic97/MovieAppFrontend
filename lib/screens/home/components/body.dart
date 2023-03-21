import 'package:flutter/material.dart';
import 'package:movie_app/providers/home_provider.dart';
import 'package:movie_app/widgets/horizontal_list_widget.dart';
import 'package:movie_app/widgets/no_content_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  final String type;
  const Body({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: Provider.of<HomeProvider>(context)
                .getContentByReleaseDate(type),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null &&
                            (snapshot.data as List<dynamic>).isNotEmpty
                        ? HorizontalListWidget(
                            title: localization!.recently_released,
                            contentElements: snapshot.data as List<dynamic>,
                          )
                        : const NoContentWidget(),
          ),
          FutureBuilder(
              future:
                  Provider.of<HomeProvider>(context).getContentByRating(type),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center()
                      : snapshot.data != null &&
                              (snapshot.data as List<dynamic>).isNotEmpty
                          ? HorizontalListWidget(
                              title: localization!.best_rate,
                              contentElements: snapshot.data as List<dynamic>,
                            )
                          : const NoContentWidget()),
        ],
      ),
    );
  }
}
