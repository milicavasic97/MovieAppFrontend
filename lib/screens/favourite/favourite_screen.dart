import 'package:flutter/material.dart';
import 'package:movie_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => FavouritesProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber[800],
            tabs: [
              Tab(
                text: localization!.all,
              ),
              Tab(
                text: localization.movies,
              ),
              Tab(
                text: localization.series,
              ),
            ],
          ),
        ),
        body: Consumer<FavouritesProvider>(
          builder: (context, value, child) => TabBarView(
            controller: _tabController,
            children: const [
              Body(
                type: "C",
              ),
              Body(
                type: "M",
              ),
              Body(
                type: "S",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
