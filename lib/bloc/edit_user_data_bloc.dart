import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/models/report_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/utils/logger.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc({required this.repository}) : super(EditUserInitial()) {
    on<EditUserLoadReport>(_getReportItem);
    on<EditUserData>(_editUserData);
  }

  late ReportModel reportItem = ReportModel();
  final EditUserDataRepository repository;

  _getReportItem(EditUserLoadReport event, Emitter<EditUserState> emit) async {
    final ReportModel report = await ReportHiveBox().getReportHive(event.index);
    reportItem = report;
    emit(EditUserModelLoaded(reportItem: report));
  }

  _editUserData(
    EditUserData event,
    Emitter<EditUserState> emit,
  ) async {
    final int userId = int.parse(reportItem.source!.users ?? '');
    final int reportId = int.parse(reportItem.source!.id ?? '');

    final Map<String, dynamic> response = await repository.editUserDataRequest(
      userId: userId,
      reportId: reportId,
      title: event.title,
      datar: event.datar,
      timer: event.timer,
      city: event.city,
      dl: event.dl,
      sh: event.sh,
      p: event.p,
      timelite: event.timelite,
    );

    if (response['status'] == 'OK') {
      emit(EditUserApiStatusOk());
    } else {
      logger.e('editUserDataRequest response[status] ${response['status']}');
      throw Exception(
          'editUserDataRequest response[status] ${response['status']}');
    }
  }
}

//
// Event
//

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();
  @override
  List<Object?> get props => [];
}

class EditUserData extends EditUserEvent {
  final String? title;
  final String? datar;
  final String? timer;
  final String? city;
  final double? dl;
  final double? sh;
  final String? p;
  final int? timelite;

  const EditUserData({
    required this.title,
    required this.datar,
    required this.timer,
    required this.city,
    required this.dl,
    required this.sh,
    required this.p,
    required this.timelite,
  });

  @override
  List<Object?> get props => [
        title,
        datar,
        timer,
        city,
        dl,
        sh,
        p,
        timelite,
      ];
}

class EditUserLoadReport extends EditUserEvent {
  final int index;

  const EditUserLoadReport({required this.index});

  @override
  List<Object> get props => [index];
}

//
// State
//

class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object?> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserApiStatusOk extends EditUserState {}

class EditUserModelLoaded extends EditUserState {
  final ReportModel reportItem;

  const EditUserModelLoaded({required this.reportItem});

  @override
  List<Object?> get props => [reportItem];
}

