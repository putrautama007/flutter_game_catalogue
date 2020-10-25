import 'package:core/external/api_constant.dart';
import 'package:core/external/custom_screen_utils.dart';
import 'package:core/external/localization_key/home_locale_key.dart';
import 'package:core/external/localization_key/settings_locale_key.dart';
import 'package:core/external/route_strings.dart';
import 'package:dio/dio.dart';
import 'package:feature_game/data/remote/dataresources/game_api_provider.dart';
import 'package:feature_game/data/remote/repositories/game_repository_impl.dart';
import 'package:feature_game/domain/usecases/game_detail_use_case.dart';
import 'package:feature_game/domain/usecases/game_list_use_case.dart';
import 'package:feature_game/presentation/bloc/game_detail_bloc/game_detail_bloc.dart';
import 'package:feature_game/presentation/bloc/game_list_bloc/game_bloc.dart';
import 'package:feature_game/presentation/pages/game_detail_screen.dart';
import 'package:feature_game/presentation/pages/game_list_screen.dart';
import 'package:feature_settings/presentation/pages/settings_screen.dart';
import 'package:feature_settings/presentation/blocs/change_language_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/home_screen.dart';

class FeatureHomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((_) => RouteStrings()),
        Bind((_) => CustomScreenUtils()),
        Bind((_) => HomeLocaleKey()),
        Bind((_) => SettingsLocaleKey()),
        Bind((_) => GameListScreen()),
        Bind((_) => SettingsScreen()),
        Bind((_) => ApiConstant()),
        Bind((_) =>
            Dio(BaseOptions(baseUrl: Modular.get<ApiConstant>().baseUrl))),
        Bind((_) => GameApiProviderImpl(dio: Modular.get<Dio>())),
        Bind((_) => GameRepositoryImpl(
            gameApiProvider: Modular.get<GameApiProviderImpl>())),
        Bind((_) => GameListUseCaseImpl(
            gameRepository: Modular.get<GameRepositoryImpl>())),
        Bind((_) => GameBLoc(gameUseCase: Modular.get<GameListUseCaseImpl>())),
        Bind((_) => GameDetailUseCaseImpl(
            gameRepository: Modular.get<GameRepositoryImpl>())),
        Bind(
            (_) => GameDetailBloc(
                gameDetailUseCase: Modular.get<GameDetailUseCaseImpl>()),
            singleton: false),
    Bind((_) => ChangeLanguageBloc(),singleton: false),
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
