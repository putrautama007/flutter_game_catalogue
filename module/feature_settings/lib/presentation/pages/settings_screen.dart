import 'package:core/external/custom_screen_utils.dart';
import 'package:core/external/localization_key/settings_locale_key.dart';
import 'package:feature_settings/presentation/widget/change_language_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feature_settings/presentation/blocs/change_language_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isEnglish;
  bool _isIndonesia;

  @override
  Widget build(BuildContext context) {
    String _locale = context.locale.toString();
    Modular.get<CustomScreenUtils>().initScreenUtils(context);
    return BlocProvider(
      create: (context) => Modular.get<ChangeLanguageBloc>()
        ..add(CheckLanguage(locale: _locale)),
      child: Scaffold(
          backgroundColor: Colors.white38,
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              Modular.get<SettingsLocaleKey>().settings.tr(),
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
          ),
          body: BlocListener<ChangeLanguageBloc, ChangeLanguageState>(
            listener: (context, state) {
              if (state is ChangeLanguageEnglishState) {
                setState(() {
                  context.locale =
                  EasyLocalization.of(context).supportedLocales[0];
                  _isEnglish = true;
                  _isIndonesia = false;
                });
              } else if (state is ChangeLanguageIndonesiaState) {
                setState(() {
                  context.locale =
                  EasyLocalization.of(context).supportedLocales[1];
                  _isEnglish = false;
                  _isIndonesia = true;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 16.w),
              child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ChangeLanguageButton(
                            text: Modular.get<SettingsLocaleKey>()
                                .english
                                .tr(),
                            textSize: 14.sp,
                            isIconActive: _isEnglish,
                            icon: Icons.check,
                            iconActiveColor: Colors.green,
                            iconInactiveColor: Colors.grey,
                            onTap: () => context
                                .bloc<ChangeLanguageBloc>()
                                .add(ChangeLanguageToEnglish())),
                        ChangeLanguageButton(
                            text: Modular.get<SettingsLocaleKey>()
                                .indonesia
                                .tr(),
                            textSize: 14.sp,
                            isIconActive: _isIndonesia,
                            icon: Icons.check,
                            iconActiveColor: Colors.green,
                            iconInactiveColor: Colors.grey,
                            onTap: () => context
                                .bloc<ChangeLanguageBloc>()
                                .add(ChangeLanguageToIndonesia())),
                      ],
                    );
                  }),
            ),
          )),
    );
  }
}
