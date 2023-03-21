import 'package:flutter/material.dart';
import 'package:movie_app/providers/single_content_provider.dart';
import 'package:movie_app/widgets/single_content_widget.dart';
import 'package:provider/provider.dart';

class VerticalListWidget extends StatelessWidget {
  final List<dynamic> contentElements;
  const VerticalListWidget({
    Key? key,
    required this.contentElements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: size.height * 0.76,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: contentElements.length,
          itemBuilder: (BuildContext context, int index) =>
              ChangeNotifierProvider.value(
            value: SingleContentProvider(),
            builder: (context, child) => SingleContentWidget(
              horizontal: false,
              contentElement: contentElements[index] as Map<String, dynamic>,
              size: size,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
