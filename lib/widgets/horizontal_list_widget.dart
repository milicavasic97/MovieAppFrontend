import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/providers/single_content_provider.dart';
import 'package:movie_app/widgets/single_content_widget.dart';
import 'package:provider/provider.dart';

class HorizontalListWidget extends StatelessWidget {
  final String title;
  final List<dynamic> contentElements;
  const HorizontalListWidget({
    Key? key,
    required this.title,
    required this.contentElements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
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
            height: size.height * 0.3,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contentElements.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider.value(
                value: SingleContentProvider(),
                builder: (context, child) => SingleContentWidget(
                  horizontal: true,
                  contentElement:
                      contentElements[index] as Map<String, dynamic>,
                  size: size,
                  index: index,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
