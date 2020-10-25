import 'package:core/external/custom_screen_utils.dart';
import 'package:core/external/localization_key/settings_locale_key.dart';
import 'package:core/external/route_strings.dart';
import 'package:feature_settings/presentation/pages/settings_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:feature_settings/presentation/blocs/change_language_bloc.dart';

class FeatureSettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((_) => RouteStrings()),
        Bind((_) => SettingsLocaleKey()),
        Bind((_) => CustomScreenUtils()),
        Bind((_) => ChangeLanguageBloc()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, __) => SettingsScreen(),
        ),
      ];
}
