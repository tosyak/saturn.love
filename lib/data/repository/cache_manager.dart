import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:saturn/data/models/report_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/data/repository/image_cache_manager.dart';
import 'package:saturn/utils/logger.dart';



class CacheManagerCubit extends Cubit<CacheManagerState> {
  CacheManagerCubit() : super(CacheManagerInitial());

  final reportsListRepository = ReportsListRepository();
  final reportRepository = ReportRepository();

  void resetState() {
    emit(CacheManagerInitial());
  }

  void runCacheManager() async {
    final ReportsListHiveBox reportListHiveBox = ReportsListHiveBox();
    final Map<String, dynamic> reportsListResponse =
        await reportsListRepository.getReportsListResponse();
    final bool reportsListBoxIsEmpty =
        await reportListHiveBox.isEmptyReportsBox();
    if (reportsListBoxIsEmpty) {
      emit(CacheManagerReportsListIsEmpty());
      final List<dynamic> reportsList = reportsListResponse['reports'];
      if (reportsList.isNotEmpty) {
        await ReportsListHiveBox().putReportsListHive(reportsListResponse);
        cacheReportsFromList(reportsListResponse);
      } else {
        logger.i('response is empty');
        emit(CacheManagerReportsListIsEmptyResponseIsEmpty());
      }
    } else {
      logger.i('reports list not empty');
      emit(CacheManagerReportsListNotEmpty());
      final bool listAndResponseAreEqual =
          await reportListHiveBox.checkReportsListUpdated(reportsListResponse);
      if (listAndResponseAreEqual) {
        logger.i('reports list and response are equal');
        emit(CacheManagerReportsListAndResponseAreEqual());
        emit(CacheManagerReportsCached());
      } else {
        logger.i('reports list and response are not equal');
        emit(CacheManagerReportsListAndResponseNotEqual());
        final reportsList = await cacheReportsList();
        cacheReportsFromList(reportsList);
      }
    }
  }

  void runOffLineCacheManager() async {
    final reportListHiveBox = ReportsListHiveBox();
    final bool reportsListBoxIsEmpty =
        await reportListHiveBox.isEmptyReportsBox();
    if (reportsListBoxIsEmpty) {
      logger.i('reports list is empty');
      emit(CacheManagerReportsListIsEmpty());
    } else {
      logger.i('reports list not empty');
      emit(CacheManagerOffLineReportsListIsNotEmpty());
    }
  }

  Future<void> cacheReportsFromList(
      Map<String, dynamic> reportsListResponse) async {
    final List<dynamic> reportsList = reportsListResponse['reports'];
    final List<String> imageUrlList = [];
    for (var i = 0; i < reportsList.length; i++) {
      await cacheReportItem(int.parse(reportsList[i]['id']));
      await cacheReportItemAlternate(int.parse(reportsList[i]['id']));
      final ReportModel model =
          await ReportHiveBox().getReportHive(int.parse(reportsList[i]['id']));
      if (model.source?.timelite != '0') {
        imageUrlList.add(model.image!);
        final String oldUrl = model.image!.replaceAll('start', 'old');
        final String nextUrl = model.image!.replaceAll('start', 'next');
        imageUrlList.add(oldUrl);
        imageUrlList.add(nextUrl);
      }
      emit(CacheManagerReportLoadPercent(
          listLength: reportsList.length, reportIndex: i));
    }
    await SvgImageCacheManager().cacheImageFile(imageUrlList);
    emit(const CacheManagerImageLoadPercent(imageCached: 0.9));
    emit(CacheManagerReportsCached());
  }

  Future<Map<String, dynamic>> cacheReportsList() async {
    try {
      final Map<String, dynamic> reportsList =
          await reportsListRepository.getReportsListResponse();
      if (reportsList.isNotEmpty) {
        await ReportsListHiveBox().putReportsListHive(reportsList);
        emit(CacheManagerReportsListCached());
        return reportsList;
      }
    } catch (e, stackTrace) {
      throw Exception('cacheReportList error $e, stackTrace $stackTrace');
    }
    throw Exception('cacheReportList error');
  }

  Future<Map<String, dynamic>> cacheReportItem(int reportId) async {
    try {
      final reportItem = await reportRepository.getReportResponse(reportId);

      if (reportItem.isNotEmpty) {
        await ReportHiveBox().putReportHive(reportItem, reportId);
        return reportItem;
      } else {
        throw Exception('cacheReportItem Report item is empty');
      }
    } catch (e, stackTrace) {
      throw Exception(
          'cacheReportItem Report item is empty $e, stackTrace $stackTrace');
    }
  }

  Future<void> cacheReportItemAlternate(int reportId) async {
    try {
      final reportItemAlternate =
          await reportRepository.getReportAlternateResponse(reportId);
      if (reportItemAlternate['alternate'] != null) {
        await ReportHiveBox().putReportHive(
            reportItemAlternate['alternate']['old'], '${reportId}old');
        await ReportHiveBox().putReportHive(
            reportItemAlternate['alternate']['next'], '${reportId}next');
      }
    } catch (e, stackTrace) {
      throw Exception('cacheReportItemAlternate error $e, stackTrace $stackTrace');
    }
  }

  Future<void> cacheSingleReport(int reportId) async {
    final List<String> imageUrlList = [];
    await cacheReportItem(reportId);
    await cacheReportItemAlternate(reportId);
    final ReportModel model = await ReportHiveBox().getReportHive(reportId);
    if (model.source?.timelite != '0') {
      imageUrlList.add(model.image!);
      final String oldUrl = model.image!.replaceAll('start', 'old');
      final String nextUrl = model.image!.replaceAll('start', 'next');
      imageUrlList.add(oldUrl);
      imageUrlList.add(nextUrl);
    }
    await SvgImageCacheManager().cacheImageFile(imageUrlList);
    emit(CacheManagerReportItemCached(reportId: reportId));
    emit(CacheManagerInitial());
  }
}

abstract class CacheManagerState extends Equatable {
  const CacheManagerState();

  @override
  List<Object?> get props => [];
}

class CacheManagerInitial extends CacheManagerState {}

class CacheManagerReportsListIsEmpty extends CacheManagerState {}

class CacheManagerOffLineReportsListIsNotEmpty extends CacheManagerState {}

class CacheManagerReportsListIsEmptyResponseIsEmpty extends CacheManagerState {}

class CacheManagerReportsListNotEmpty extends CacheManagerState {}

class CacheManagerReportsListAndResponseAreEqual extends CacheManagerState {}

class CacheManagerReportsListAndResponseNotEqual extends CacheManagerState {}

class CacheManagerReportsCached extends CacheManagerState {}

class CacheManagerReportsListCached extends CacheManagerState {}

class CacheManagerReportItemCached extends CacheManagerState {
  final int reportId;

  const CacheManagerReportItemCached({required this.reportId});

  @override
  List<Object?> get props => [reportId];
}

class CacheManagerReportLoadPercent extends CacheManagerState {
  const CacheManagerReportLoadPercent({
    required this.listLength,
    required this.reportIndex,
  });

  final int listLength;
  final int reportIndex;

  @override
  List<Object> get props => [listLength, reportIndex];
}

class CacheManagerImageLoadPercent extends CacheManagerState {
  const CacheManagerImageLoadPercent({
    required this.imageCached,
  });

  final double imageCached;

  @override
  List<Object> get props => [imageCached];
}
