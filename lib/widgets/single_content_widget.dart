import 'package:flutter/material.dart';
import 'package:movie_app/providers/single_content_provider.dart';
import 'package:movie_app/screens/details/details_screen.dart';
import 'package:provider/provider.dart';

class SingleContentWidget extends StatelessWidget {
  final bool horizontal;
  final Map<String, dynamic> contentElement;
  final Size size;
  final int index;

  const SingleContentWidget({
    Key? key,
    required this.horizontal,
    required this.contentElement,
    required this.size,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<SingleContentProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            elevation: 5,
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: 250,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          ),
        );

        contentProvider
            .getContentDetails(contentElement['contentId'])
            .then((value) {
          Navigator.of(context).pop();
          if (value != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                      value: SingleContentProvider.value(
                        value,
                        contentElement['contentId'],
                      ),
                      builder: (cntx, child) => DetailsScreen(),
                    )));
          }
        });
      },
      child: horizontal
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.239,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          contentElement['coverLink'],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        contentElement['title'],
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    )
                  ],
                  color: const Color(0xff5c6063),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: size.width * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          contentElement['coverLink'],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Flexible(
                              child: Text(
                                contentElement['title'],
                                style: const TextStyle(fontSize: 25),
                                maxLines: 4,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Text(contentElement['year'].toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
