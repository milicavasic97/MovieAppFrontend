import 'package:flutter/material.dart';
import 'package:movie_app/providers/single_content_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentDetails extends StatelessWidget {
  const ContentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final detailsProvider = Provider.of<SingleContentProvider>(context);
    final localization = AppLocalizations.of(context);

    final _youtubeController = YoutubePlayerController(
      initialVideoId: detailsProvider.trailerLink,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detailsProvider.title,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              detailsProvider.year.toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<SingleContentProvider>(
                    builder: (context, value, child) => IconButton(
                      onPressed: () {
                        value.addToFavorites();
                      },
                      icon: detailsProvider.isFavourite
                          ? const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.height * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: YoutubePlayer(
                  controller: _youtubeController,
                  liveUIColor: Colors.amber,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade800,
                ),
                Text(
                  " " + detailsProvider.rating.toString() + "/10",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  localization!.duration + ": ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  detailsProvider.duration.toString() + "min",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              localization.genres + " ",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              width: double.infinity,
              height: size.height * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detailsProvider.genres.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.amber.shade800),
                      color: Colors.grey.shade900),
                  child: Text(
                    detailsProvider.genres[index]['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
