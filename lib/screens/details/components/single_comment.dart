import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SingleComment extends StatelessWidget {
  final Map<String, dynamic> commentData;
  const SingleComment({
    Key? key,
    required this.commentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.amber.shade800),
          color: Colors.grey.shade600,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              commentData['user']['firstName'] +
                  " " +
                  commentData['user']['lastName'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              commentData['comment'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('HH:mm - dd.MM.yyyy.')
                  .format(DateTime.parse(commentData['commentDate'])),
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
