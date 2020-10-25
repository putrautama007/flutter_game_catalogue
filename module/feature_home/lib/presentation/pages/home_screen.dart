import 'package:core/external/localization_key/home_locale_key.dart';
import 'package:feature_game/presentation/pages/game_list_screen.dart';
import 'package:feature_settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feature_settings/presentation/blocs/change_language_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgets = <Widget>[
    Modular.get<GameListScreen>(),
    Modular.get<SettingsScreen>(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _locale = context.locale.toString();
    return BlocProvider(
      create: (context) => Modular.get<ChangeLanguageBloc>()
        ..add(CheckLanguage(locale: _locale)),
      child: Scaffold(
        body: _widgets.elementAt(_selectedIndex),
        bottomNavigationBar:
            BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: Modular.get<HomeLocaleKey>().home.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: Modular.get<HomeLocaleKey>().settings.tr(),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            );
          },
        ),
      ),
    );
  }
}
