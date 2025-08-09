import 'package:intl/intl.dart';

class LanguageHelper {
  static bool isArabic() {
    final currentLocale = Intl.getCurrentLocale();
    return currentLocale.startsWith('ar');
  }

  static bool isEnglish() {
    final currentLocale = Intl.getCurrentLocale();
    return currentLocale.startsWith('en');
  }
}
