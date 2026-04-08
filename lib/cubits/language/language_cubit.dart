import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  // intial state with default language (English)
  LanguageCubit() : super(const LanguageInitial(locale: Locale('en')));

  // function to get the saved language from shared preferences and emit the state
  Future<void> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String cachedLanguageCode = prefs.getString('LOCALE') ?? 'en';
    emit(LanguageChanged(locale: Locale(cachedLanguageCode)));
  }
  
  // function to change the language and save it to shared preferences
  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('LOCALE', languageCode);
    emit(LanguageChanged(locale: Locale(languageCode)));
  }
}