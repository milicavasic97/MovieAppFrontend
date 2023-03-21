import 'package:flutter/material.dart';
import 'package:movie_app/screens/details/components/comments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/screens/details/components/content_details.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization!.detailed),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber[800],
          tabs: [
            Tab(
              text: localization.details,
            ),
            Tab(
              text: localization.comments,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ContentDetails(),
          Comments(),
        ],
      ),
    );
  }
}
