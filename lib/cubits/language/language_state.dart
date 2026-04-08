part of 'language_cubit.dart';

abstract class LanguageState {
  final Locale locale;
  const LanguageState({required this.locale});
}

class LanguageInitial extends LanguageState {
  const LanguageInitial({required super.locale});
}

class LanguageChanged extends LanguageState {
  const LanguageChanged({required super.locale});
}