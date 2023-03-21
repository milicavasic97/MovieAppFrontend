import 'package:flutter/material.dart';
import 'package:movie_app/providers/search_provider.dart';
import 'package:movie_app/widgets/horizontal_list_widget.dart';
import 'package:movie_app/widgets/no_content_widget.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final String type;
  const Body({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return FutureBuilder(
      future: searchProvider.getAllGenres(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.data != null
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => FutureBuilder(
                        future: searchProvider.getContentByGenreAndType(
                            snapshot.data![index]['genreId'], type),
                        builder: (context, contentsSnapshot) =>
                            contentsSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const Center()
                                : Column(children: [
                                    if (contentsSnapshot.data != null &&
                                        (contentsSnapshot.data as List<dynamic>)
                                            .isNotEmpty)
                                      HorizontalListWidget(
                                        title: snapshot.data![index]['name'],
                                        contentElements:
                                            searchProvider.getContentsList(
                                          snapshot.data![index]['genreId'],
                                          type,
                                        ),
                                      )
                                  ]),
                      ),
                    )
                  : const NoContentWidget(),
    );
  }
}
