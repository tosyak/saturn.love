import 'package:flutter/material.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/utils/logger.dart';

class LocaleManager {
  final LocaleHiveBox _localeHiveBox = LocaleHiveBox();

  void setLocale(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    logger.i('device locale $myLocale');

    if (myLocale.toString() == 'ru') {
      _localeHiveBox.putLocaleHive('ru');
    } else {
      _localeHiveBox.putLocaleHive('en');
    }
  }
}
