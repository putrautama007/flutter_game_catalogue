import 'package:feature_contributor/feature_contributor.dart';
import 'package:feature_game/feature_game.dart';
import 'package:flutter/material.dart';
import 'package:core/external/route_strings.dart';
import 'package:flutter_game_catalogue/presentation/blocs/splash_bloc.dart';
import 'package:flutter_game_catalogue/presentation/pages/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:core/core.dart';
import 'package:feature_home/feature_home.dart';

void main() {
  Modular.init(CoreModule());
  runApp(ModularApp(
    module: AppModule(),
  ));
}

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((_) => SplashBloc()),
      ];

  @override
  Widget get bootstrap => MyApp();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.get<RouteStrings>().splashScreenRoute,
          child: (context, args) => SplashScreen(),
        ),
        ModularRouter(
          Modular.get<RouteStrings>().gameListRoute,
          module: FeatureGameModule(),
        ),
        ModularRouter(
          Modular.get<RouteStrings>().homeScreenRoute,
          module: FeatureHomeModule(),
        ),
        ModularRouter(
          Modular.get<RouteStrings>().profileRoute,
          module: FeatureContributorModule(),
        ),
        ModularRouter(
          Modular.get<RouteStrings>().settingsRoute,
          module: FeatureContributorModule(),
        ),
      ];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Catalogue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Modular.get<RouteStrings>().splashScreenRoute,
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
