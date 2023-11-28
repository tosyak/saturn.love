import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:saturn/data/models/sadi_sati_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/utils/logger.dart';

class SadiSatiBloc extends Bloc<SadiSatiEvent, SadiSatiState> {
  final SadiSatiRepository repository;
  bool sadiSatiPeriod = false;
  late String languageCode;

  SadiSatiBloc({required this.repository}) : super(SadiSatiInitial()) {
    on<FetchSadiSati>(_fetchSadiSati);
    on<CheckPeriod>(_checkPeriod);
  }

  Future<void> _fetchSadiSati(
      FetchSadiSati event, Emitter<SadiSatiState> emit) async {
    emit(SadiSatiInitial());
    bool networkIsConnected = await InternetConnectionChecker().hasConnection;
    if (!networkIsConnected) {
     
      emit(SadiSatiNetworkNotConnected());
    } else {
      languageCode = await LocaleHiveBox().getLocaleHive();
      final response = await repository.getSadiSatiResponse(event.reportIndex);
      final SadiSatiModel model = SadiSatiModel.fromJson(response);
      // add(CheckPeriod(model)); // Dispatch CheckPeriod event
      emit(SadiSatiLoaded(
        sadiSatiReportItem: model,
        languageCode: languageCode,
      ));
    }
  }

  void _checkPeriod(CheckPeriod event, Emitter<SadiSatiState> emit) {
    sadiSatiPeriod = false;
    DateTime currentDate = DateTime.now();
    final reportCardList = event.model.sadisati?.child?[0].child;

    if (reportCardList != null) {
      for (var i = 0; i < 3; i++) {
        final child = reportCardList[i];
        if (child.time!.start != null && child.time!.end != null) {
          DateTime startDate = child.time!.start![0].date!;
          DateTime endDate = child.time!.end!.last.date!;
          if (startDate.isBefore(currentDate) && endDate.isAfter(currentDate)) {
            sadiSatiPeriod = true;
            emit(SadiSatiPeriodIsActive());
            logger.i('Period is ongoing');
          } else {
            logger.i('Period is not ongoing');
          }
        }
      }
    }

    if (sadiSatiPeriod) {
      emit(SadiSatiPeriodIsActive());
    }
  }
}

//
//  State
//

abstract class SadiSatiState extends Equatable {
  const SadiSatiState();
  @override
  List<Object> get props => [];
}

class SadiSatiInitial extends SadiSatiState {}

class SadiSatiPeriodIsActive extends SadiSatiState {}

class SadiSatiLoaded extends SadiSatiState {
  final SadiSatiModel sadiSatiReportItem;
  final String languageCode;
  const SadiSatiLoaded({
    required this.sadiSatiReportItem,
    required this.languageCode,
  });
  @override
  List<Object> get props => [sadiSatiReportItem, languageCode];
}

class SadiSatiNetworkNotConnected extends SadiSatiState {}

//
//  Event
//

abstract class SadiSatiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSadiSati extends SadiSatiEvent {
  final int reportIndex;

  FetchSadiSati(this.reportIndex);

  @override
  List<Object> get props => [reportIndex];
}

class CheckPeriod extends SadiSatiEvent {
  final SadiSatiModel model;

  CheckPeriod(this.model);

  @override
  List<Object> get props => [model];
}
