import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_providers.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeObserver = RouteObserver<ModalRoute>();
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        // ),
        // routes: AppRoutes.routes,
        // color: AppColors.blue,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales:
        //     AppLocalizations.supportedLocales, // Use the list from L10n
        // locale: locale, // Dynamically set the locale
      ),
    );
  }
}
