import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer_market/constants.dart';
import 'package:tawfeer_market/cubits/language/language_cubit.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          String currentLang = 'en';
          if (state is LanguageChanged) {
            currentLang = state.locale.languageCode;
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<LanguageCubit>().changeLanguage('en');
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: currentLang == 'en'
                          ? const Color(kprimarycolor)
                          : Colors.grey.shade300,
                      width: currentLang == 'en' ? 2 : 1,
                    ),
                    color: currentLang == 'en'
                        ? const Color(kprimarycolor).withOpacity(0.05)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Text('🇺🇸', style: TextStyle(fontSize: 30)),
                      const SizedBox(width: 16),
                      const Text(
                        'English',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (currentLang == 'en')
                        const Icon(Icons.check_circle, color: Color(kprimarycolor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  context.read<LanguageCubit>().changeLanguage('ar');
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: currentLang == 'ar'
                          ? const Color(kprimarycolor)
                          : Colors.grey.shade300,
                      width: currentLang == 'ar' ? 2 : 1,
                    ),
                    color: currentLang == 'ar'
                        ? const Color(kprimarycolor).withOpacity(0.05)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Text('🇪🇬', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 16),
                      const Text(
                        'العربية',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (currentLang == 'ar')
                        const Icon(Icons.check_circle, color: Color(kprimarycolor)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}