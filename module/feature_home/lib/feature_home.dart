import 'package:core/external/api_constant.dart';
import 'package:core/external/route_strings.dart';
import 'package:dio/dio.dart';
import 'package:feature_contributor/presentation/pages/profile_screen.dart';
import 'package:feature_game/data/remote/dataresources/game_api_provider.dart';
import 'package:feature_game/data/remote/repositories/game_repository_impl.dart';
import 'package:feature_game/domain/usecases/game_detail_use_case.dart';
import 'package:feature_game/domain/usecases/game_list_use_case.dart';
import 'package:feature_game/presentation/bloc/game_bloc.dart';
import 'package:feature_game/presentation/bloc/game_detail_bloc/game_detail_bloc.dart';
import 'package:feature_game/presentation/pages/game_detail_screen.dart';
import 'package:feature_game/presentation/pages/game_list_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/home_screen.dart';

class FeatureHomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((_) => RouteStrings()),
    Bind((_) => GameListScreen()),
    Bind((_) => ProfileScreen()),
    Bind((_) => ApiConstant()),
    Bind((_) =>
        Dio(BaseOptions(baseUrl: Modular.get<ApiConstant>().baseUrl))),
    Bind((_) => GameApiProviderImpl(dio: Modular.get<Dio>())),
    Bind((_) => GameRepositoryImpl(
        gameApiProvider: Modular.get<GameApiProviderImpl>())),
    Bind((_) =>
        GameListUseCaseImpl(gameRepository: Modular.get<GameRepositoryImpl>())),
    Bind((_) => GameBLoc(gameUseCase: Modular.get<GameListUseCaseImpl>())),
    Bind((_) => GameDetailUseCaseImpl(
        gameRepository: Modular.get<GameRepositoryImpl>())),
    Bind((_) => GameDetailBloc(
        gameDetailUseCase: Modular.get<GameDetailUseCaseImpl>()),singleton: false),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(
      Modular.initialRoute,
      child: (_, __) => HomeScreen(),
    ),
    ModularRouter(
      '/gameDetailRoute',
      child: (_, args) => GameDetailScreen(gameId: args.data),
    ),
  ];
}