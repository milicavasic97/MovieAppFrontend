import 'package:flutter/material.dart';
import 'package:movie_app/providers/search_provider.dart';
import 'package:movie_app/screens/search/components/search_field.dart';
import 'package:movie_app/screens/search/components/searching_body.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var searchingText = "";
  var searching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Focus(
            onFocusChange: (value) {
              if (searchingText.isEmpty) {
                setState(() {
                  searching = false;
                });
              } else {
                setState(() {
                  searching = true;
                });
              }
            },
            child: SearchField(
              onChange: (text) {
                searchingText = text;
              },
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber[800],
            tabs: <Widget>[
              Tab(
                text: localization!.all,
              ),
              Tab(
                text: localization.movies,
              ),
              Tab(
                text: localization.series,
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            searching ? const SearchingBody() : const Body(type: "A"),
            searching ? const SearchingBody() : const Body(type: "M"),
            searching ? const SearchingBody() : const Body(type: "S"),
          ],
        ),
      ),
    );
  }
}
