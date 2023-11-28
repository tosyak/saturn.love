// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/models/report_model.dart';
import 'package:saturn/data/models/reports_list_model.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/data/repository/image_cache_manager.dart';

class ReportScreenBloc extends Bloc<ReportScreenEvent, ReportScreenState> {
  ReportScreenBloc() : super(ReportScreenInitial()) {
    on<SetPageIndex>(_setPageIndex);
    on<MakeOldReport>(_makeOldReport);
    on<MakeCurrentReport>(_makeCurrentReport);
    on<MakeNextReport>(_makeNextReport);
    on<EmitReportItem>(_emitReportItem);
    on<GetReportItem>(_getReportItem);
    on<GetInitialReportItem>(_getInitialReportItem);
    on<LoadReportItem>(_loadReportItem);
  }

  String? cachedImage;
  var pageIndex = 1;
  late int reportIndex;
  late ReportModel reportItem = ReportModel();
  late ReportModel reportItemCurrent = ReportModel();
  late ReportModel reportItemNext = ReportModel();
  late ReportModel reportItemOld = ReportModel();

  void _setPageIndex(SetPageIndex event, Emitter<ReportScreenState> emit) {
    pageIndex = event.index;
  }

  _makeOldReport(MakeOldReport event, Emitter<ReportScreenState> emit) async {
    reportItem = reportItemOld;
    if (reportItem.source?.timelite != '0') {
      final imageUrl = reportItemOld.image;
      await _getCachedImage(imageUrl!);
    }
    emit(ReportScreenReportLoaded(
      image: cachedImage,
      pageIndex: pageIndex,
      reportIndex: reportIndex,
      reportItem: reportItem,
      reportItemCurrent: reportItemCurrent,
      reportItemNext: reportItemNext,
      reportItemOld: reportItemOld,
    ));
  }

  _makeCurrentReport(
      MakeCurrentReport event, Emitter<ReportScreenState> emit) async {
    reportItem = reportItemCurrent;
    if (reportItem.source?.timelite != '0') {
      final imageUrl = reportItemCurrent.image;
      await _getCachedImage(imageUrl!);
    }
    emit(ReportScreenReportLoaded(
      image: cachedImage,
      pageIndex: pageIndex,
      reportIndex: reportIndex,
      reportItem: reportItem,
      reportItemCurrent: reportItemCurrent,
      reportItemNext: reportItemNext,
      reportItemOld: reportItemOld,
    ));
  }

  _makeNextReport(MakeNextReport event, Emitter<ReportScreenState> emit) async {
    reportItem = reportItemNext;
    if (reportItem.source?.timelite != '0') {
      final imageUrl = reportItemNext.image;
      await _getCachedImage(imageUrl!);
    }
    emit(ReportScreenReportLoaded(
      image: cachedImage,
      pageIndex: pageIndex,
      reportIndex: reportIndex,
      reportItem: reportItem,
      reportItemCurrent: reportItemCurrent,
      reportItemNext: reportItemNext,
      reportItemOld: reportItemOld,
    ));
  }

  _getCachedImage(String url) async {
    final cachedFile = await SvgImageCacheManager().getCachedFile(url);
    final file = cachedFile;
    final String svgString = await file!.readAsString();
    cachedImage = svgString;
  }

  _getInitialReportItem(
      GetInitialReportItem event, Emitter<ReportScreenState> emit) async {
    ReportsListModel item = await ReportsListHiveBox().getReportsListHive();
    int itemIndex = int.parse(item.reports[0].id);
    add(GetReportItem(itemIndex));
  }

  _loadReportItem(LoadReportItem event, Emitter<ReportScreenState> emit) async {
    final ReportModel report = await ReportHiveBox().getReportHive(event.index);
    reportItem = report;
    reportItemCurrent = report;
    reportIndex = int.parse(reportItem.source!.id!);
    if (report.source?.timelite != '0') {
      final ReportModel reportOld =
          await ReportHiveBox().getReportHive('${event.index}old');
      final ReportModel reportNext =
          await ReportHiveBox().getReportHive('${event.index}next');
      reportItemOld = reportOld;
      reportItemNext = reportNext;
    }
    if (reportItem.source?.timelite != '0') {
      final imageUrl = reportItem.image;
      await _getCachedImage(imageUrl!);
    }
  }

  _emitReportItem(EmitReportItem event, Emitter<ReportScreenState> emit) async {
    emit(ReportScreenReportLoaded(
      image: cachedImage,
      pageIndex: pageIndex,
      reportIndex: reportIndex,
      reportItem: reportItem,
      reportItemCurrent: reportItemCurrent,
      reportItemNext: reportItemNext,
      reportItemOld: reportItemOld,
    ));
  }

  _getReportItem(GetReportItem event, Emitter<ReportScreenState> emit) async {
    final ReportModel report = await ReportHiveBox().getReportHive(event.index);
    reportItem = report;
    reportItemCurrent = report;
    reportIndex = int.parse(reportItem.source!.id!);
    if (report.source?.timelite != '0') {
      final ReportModel reportOld =
          await ReportHiveBox().getReportHive('${event.index}old');
      final ReportModel reportNext =
          await ReportHiveBox().getReportHive('${event.index}next');
      reportItemOld = reportOld;
      reportItemNext = reportNext;
    }
    if (reportItem.source?.timelite != '0') {
      final imageUrl = reportItem.image;
      await _getCachedImage(imageUrl!);
    }
    emit(ReportScreenReportLoaded(
      image: cachedImage,
      pageIndex: pageIndex,
      reportIndex: reportIndex,
      reportItem: reportItem,
      reportItemCurrent: reportItemCurrent,
      reportItemNext: reportItemNext,
      reportItemOld: reportItemOld,
    ));
  }
}

//
// Event
//

abstract class ReportScreenEvent extends Equatable {
  const ReportScreenEvent();
}

class SetPageIndex extends ReportScreenEvent {
  final int index;
  const SetPageIndex({required this.index});
  @override
  List<Object> get props => [index];
}

class MakeOldReport extends ReportScreenEvent {
  const MakeOldReport();
  @override
  List<Object> get props => [];
}

class MakeCurrentReport extends ReportScreenEvent {
  const MakeCurrentReport();
  @override
  List<Object> get props => [];
}

class MakeNextReport extends ReportScreenEvent {
  const MakeNextReport();
  @override
  List<Object> get props => [];
}

class EmitReportItem extends ReportScreenEvent {
  const EmitReportItem();
  @override
  List<Object> get props => [];
}

class GetReportItem extends ReportScreenEvent {
  final int index;
  const GetReportItem(this.index);

  @override
  List<Object> get props => [index];
}

class LoadReportItem extends ReportScreenEvent {
  final int index;
  const LoadReportItem(this.index);

  @override
  List<Object> get props => [index];
}

class GetInitialReportItem extends ReportScreenEvent {
  const GetInitialReportItem();

  @override
  List<Object> get props => [];
}

//
// State
//

abstract class ReportScreenState extends Equatable {
  const ReportScreenState();
  @override
  List<Object?> get props => [];
}

class ReportScreenInitial extends ReportScreenState {}

class ReportScreenLoading extends ReportScreenState {}

class ReportScreenReportLoaded extends ReportScreenState {
  final String? image;
  final int pageIndex;
  final int reportIndex;
  final ReportModel reportItem;
  final ReportModel reportItemCurrent;
  final ReportModel reportItemNext;
  final ReportModel reportItemOld;
  const ReportScreenReportLoaded({
    this.image,
    required this.pageIndex,
    required this.reportIndex,
    required this.reportItem,
    required this.reportItemCurrent,
    required this.reportItemNext,
    required this.reportItemOld,
  });
  @override
  List<Object?> get props => [
        image,
        pageIndex,
        reportIndex,
        reportItem,
        reportItemCurrent,
        reportItemNext,
        reportItemOld,
      ];
}
