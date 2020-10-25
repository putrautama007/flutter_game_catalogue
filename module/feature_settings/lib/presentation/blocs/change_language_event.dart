part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent extends Equatable {
  const ChangeLanguageEvent();
}

class CheckLanguage extends ChangeLanguageEvent {
  final String locale;

  CheckLanguage({@required this.locale});

  @override
  List<Object> get props => [locale];
}

class ChangeLanguageToEnglish extends ChangeLanguageEvent {
  @override
  List<Object> get props => [];
}

class ChangeLanguageToIndonesia extends ChangeLanguageEvent {
  @override
  List<Object> get props => [];
}
