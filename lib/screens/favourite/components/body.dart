import 'package:flutter/material.dart';
import 'package:movie_app/providers/favourites_provider.dart';
import 'package:movie_app/widgets/no_content_widget.dart';
import 'package:movie_app/widgets/vertical_list_widget.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final String type;

  const Body({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future:
                Provider.of<FavouritesProvider>(context).getAllFavourites(type),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null &&
                            (snapshot.data as List<dynamic>).isNotEmpty
                        ? VerticalListWidget(
                            contentElements: snapshot.data as List<dynamic>,
                          )
                        : const NoContentWidget(),
          ),
        ],
      ),
    );
  }
}
