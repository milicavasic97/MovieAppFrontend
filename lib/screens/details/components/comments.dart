import 'package:flutter/material.dart';
import 'package:movie_app/providers/single_content_provider.dart';
import 'package:movie_app/providers/user_provider.dart';
import 'package:movie_app/screens/details/components/single_comment.dart';
import 'package:movie_app/widgets/no_content_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final detailsProvider = Provider.of<SingleContentProvider>(context);
    final localization = AppLocalizations.of(context);
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _commentController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.19,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        detailsProvider.coverLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    width: size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detailsProvider.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          detailsProvider.year.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: double.infinity,
              child: Text(
                localization!.comments,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.amber.shade800,
              thickness: size.height * 0.0001,
            ),
            Consumer<SingleContentProvider>(
              builder: (context, provider, child) => Column(children: [
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: detailsProvider.contentComments.isEmpty
                        ? Container(
                            padding: EdgeInsets.only(top: size.height * 0.01),
                            child: Text(
                              localization.no_content,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: detailsProvider.contentComments.length,
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: UserProvider(),
                                builder: (context, child) => SingleComment(
                                  commentData:
                                      detailsProvider.contentComments[index],
                                ),
                              );
                            }),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _commentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.empty_field_validation;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: localization.enter_comment,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: const Icon(
                            Icons.comment,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  width: double.infinity,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        provider.addComment(
                          detailsProvider.contentId,
                          _commentController.text,
                        );
                      }
                    },
                    child: Text(localization.send_comment),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
