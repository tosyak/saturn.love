import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class GetReportBloc extends Bloc<GetReportEvent, GetReportState> {
  GetReportBloc({required this.repository}) : super(GetReportInitial()) {
    on<GetReportRequest>(_fetchResourcesListApi);
  }

  final CreateReportRepository repository;

  _fetchResourcesListApi(
    GetReportRequest event,
    Emitter<GetReportState> emit,
  ) async {
    final int? userId = await UserSharedPreferences().getUserId();

    final Map<String, dynamic> response = await repository.createReportRequest(
        userId!,
        event.name,
        event.datetime,
        event.timelite,
        event.city,
        event.timezone,
        event.offset,
        event.lat,
        event.lng,
        event.transite,
        event.moon);

    if (response['status'] == 'OK') {
      emit(GetReportLoaded(reportId: response['ord_id']));
    } else if (response['status'] == 'AVAILABLE') {
      emit(GetReportAvailable(reportId: response['ord_id']));
    } else {
      logger.e('fetchResourcesListApi response[status] ${response['status']}');
      throw Exception(
          'fetchResourcesListApi response[status] ${response['status']}');
    }
  }
}

//
// Events
//

abstract class GetReportEvent extends Equatable {
  const GetReportEvent();
  @override
  List<Object> get props => [];
}

class GetReportRequest extends GetReportEvent {
  final String name;
  final String datetime;
  final int timelite;
  final String city;
  final String timezone;
  final int offset;
  final double lat;
  final double lng;
  final int transite;
  final int moon;
  const GetReportRequest(
      {required this.name,
      required this.datetime,
      required this.timelite,
      required this.city,
      required this.timezone,
      required this.offset,
      required this.lat,
      required this.lng,
      required this.transite,
      required this.moon});

  @override
  List<Object> get props => [
        name,
        datetime,
        timelite,
        city,
        timezone,
        offset,
        lat,
        lng,
        transite,
        moon
      ];
}

//
// States
//

abstract class GetReportState extends Equatable {
  const GetReportState();
  @override
  List<Object> get props => [];
}

class GetReportInitial extends GetReportState {}

class GetReportLoading extends GetReportState {}

class GetReportLoaded extends GetReportState {
  final int reportId;
  const GetReportLoaded({required this.reportId});
  @override
  List<Object> get props => [reportId];
}

class GetReportAvailable extends GetReportState {
  final String reportId;
  const GetReportAvailable({required this.reportId});
  @override
  List<Object> get props => [reportId];
}
