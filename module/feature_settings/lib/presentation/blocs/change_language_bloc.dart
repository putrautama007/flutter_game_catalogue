import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'change_language_event.dart';

part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageInitialState());

  @override
  Stream<ChangeLanguageState> mapEventToState(
      ChangeLanguageEvent event) async* {
    if (event is CheckLanguage) {
      yield ChangeLanguageCheckState();
      switch(event.locale){
        case "en_US":
          yield ChangeLanguageEnglishState();
          break;
        case "id_ID":
          yield ChangeLanguageIndonesiaState();
          break;
      }
    }else if(event is ChangeLanguageToEnglish){
      yield ChangeLanguageEnglishState();
    }else if(event is ChangeLanguageToIndonesia){
      yield ChangeLanguageIndonesiaState();
    }
  }
}
