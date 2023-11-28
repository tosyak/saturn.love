// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saturn/data/models/report_model.dart';
import 'package:saturn/data/models/reports_list_model.dart';
import 'package:saturn/utils/logger.dart';

class ReportsListHiveBox {
  final String reportsListBox = 'reportsListBox';

  Future<bool> putReportsListHive(response) async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportsListBox);
      await box.put(0, response as Map<String, dynamic>);
      return true;
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while storing the reports list: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while storing the reports list: $e, stackTrace $stackTrace');
    }
  }

  Future<ReportsListModel> getReportsListHive() async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportsListBox);
      if (box.length != 0) {
        final dynamic data = await box.getAt(0);
        final Map<String, dynamic> convertedMap = Map.from(data);
        final ReportsListModel model = ReportsListModel.fromJson(convertedMap);
        return model;
      } else {
        logger.i("The reportsListBox is empty");
        throw Exception("The reportsListBox is empty");
      }
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while getting the reports list: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while getting the reports list: $e, stackTrace $stackTrace');
    }
  }

  Future<bool> isEmptyReportsBox() async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportsListBox);
      if (box.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      logger.e("An error occurred: $e, stackTrace $stackTrace");
      throw Exception("An error occurred: $e, stackTrace $stackTrace");
    }
  }

  Future<bool> checkReportsListUpdated(response) async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportsListBox);
      final dynamic data = await box.getAt(0);
      final Map<String, dynamic> convertedMap = Map.from(data);
      if (const DeepCollectionEquality().equals(convertedMap, response)) {
        logger.i('Item #1 and item #2 are equal');
        return true;
      } else {
        logger.i('Item #1 and item #2 are not equal');
        return false;
      }
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while checking if the reports list is updated: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while checking if the reports list is updated: $e, stackTrace $stackTrace');
    }
  }
}

class ReportHiveBox {
  final String reportBox = 'reportBox';

  Future<bool> putReportHive(index, response) async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportBox);
      await box.put(response, index);
      return true;
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while storing the report: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while storing the report: $e, stackTrace $stackTrace');
    }
  }

  Future<ReportModel> getReportHive(index) async {
    logger.i('getting report by index $index');
    try {
      final Box<dynamic> box = await Hive.openBox(reportBox);
      if (box.length != 0) {
        final dynamic data = await box.get(index);
        Map<String, dynamic> stringKeyedMap = {};
        convert(dynamic input) {
          if (input is Map<dynamic, dynamic>) {
            Map<String, dynamic> stringKeyedNestedMap = {};
            input.forEach((dynamic key, dynamic value) {
              stringKeyedNestedMap[key.toString()] = convert(value);
            });
            return stringKeyedNestedMap;
          } else if (input is List) {
            List<dynamic> outputList = [];
            for (var value in input) {
              outputList.add(convert(value));
            }
            return outputList;
          } else {
            return input;
          }
        }

        stringKeyedMap = convert(data);
        final ReportModel model = ReportModel.fromJson(stringKeyedMap);
        return model;
      } else {
        throw Exception('The report box is empty');
      }
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while getting the report: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while getting the report: $e, stackTrace $stackTrace');
    }
  }

  Future<void> deleteReportHive(index) async {
    try {
      final Box<dynamic> box = await Hive.openBox(reportBox);
      await box.delete(index);
      logger.i('report $index deleted');
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while deleting the report: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while deleting the report: $e, stackTrace $stackTrace');
    }
  }
}

class LocaleHiveBox {
  final String localeBox = 'localeBox';

  Future<bool> putLocaleHive(String locale) async {
    try {
      final Box<dynamic> box = await Hive.openBox(localeBox);
      await box.put(0, locale);
      return true;
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while storing the locale: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while storing the locale: $e, stackTrace $stackTrace');
    }
  }

  Future<String> getLocaleHive() async {
    try {
      final Box<dynamic> box = await Hive.openBox(localeBox);
      if (box.length != 0) {
        final String? locale = box.getAt(0);

        if (locale != null) {
          return locale;
        }
        throw Exception('The locale box is null');
      } else {
        throw Exception('The locale box is empty');
      }
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while getting the locale: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while getting the locale: $e, stackTrace $stackTrace');
    }
  }

  Future<void> deleteLocaleHive() async {
    try {
      final Box<dynamic> box = await Hive.openBox(localeBox);
      await box.delete(0);
      logger.i('locale deleted');
    } catch (e, stackTrace) {
      logger.e(
          'An error occurred while deleting the locale: $e, stackTrace $stackTrace');
      throw Exception(
          'An error occurred while deleting the locale: $e, stackTrace $stackTrace');
    }
  }
}

Future<void> deleteHiveBoxes() async {
  try {
    final Box<dynamic> reportsListBox = await Hive.openBox('reportsListBox');
    final Box<dynamic> reportBox = await Hive.openBox('reportBox');
    final Box<dynamic> localeBox = await Hive.openBox('localeBox');

    await reportsListBox.clear();
    await reportBox.clear();
    await localeBox.clear();

    logger.i('Boxes cleared successfully');
  } catch (e, stackTrace) {
    logger.e(
        'An error occurred while deleting hive boxes: $e, stackTrace $stackTrace');
    throw Exception(
        'An error occurred while deleting hive boxes: $e, stackTrace $stackTrace');
  }
}
