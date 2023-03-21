import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/providers/home_provider.dart';
import 'package:movie_app/screens/home/components/body.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber[800],
            tabs: <Widget>[
              Tab(
                text: localization!.movies,
              ),
              Tab(
                text: localization.series,
              )
            ],
          ),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, value, child) => TabBarView(
            controller: _tabController,
            children: const [
              Body(
                type: 'M',
              ),
              Body(
                type: 'S',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
