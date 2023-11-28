import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:saturn/data/models/transite_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';

class TransiteBloc extends Bloc<TransiteEvent, TransiteState> {
  final TransitsRepository repository;
  String? selectedDate;
  late String languageCode;
  TransiteBloc({required this.repository}) : super(TransiteInitial()) {
    on<FetchTransite>(_fetchTransite);
  }

  Future<void> _fetchTransite(
      FetchTransite event, Emitter<TransiteState> emit) async {
    emit(TransiteInitial());
    bool networkIsConnected = await InternetConnectionChecker().hasConnection;
    if (!networkIsConnected) {
      emit(TransiteNetworkNotConnected());
    } else {
      languageCode = await LocaleHiveBox().getLocaleHive();
      final Map<String, dynamic> response =
          await repository.getTransitsResponse(event.reportIndex, event.date);
      final TransitsModel model = TransitsModel.fromJson(response);
      selectedDate = event.date;
      emit(TransiteLoaded(
        transitsReportItem: model,
        selectedDate: event.date,
        languageCode: languageCode,
      ));
    }
  }
}

//
// Events
//

abstract class TransiteEvent extends Equatable {
  const TransiteEvent();
  @override
  List<Object> get props => [];
}

class FetchTransite extends TransiteEvent {
  final int reportIndex;
  final String date;
  const FetchTransite({required this.reportIndex, required this.date});
}

abstract class TransiteState extends Equatable {
  const TransiteState();
  @override
  List<Object> get props => [];
}

//
// States
//

class TransiteInitial extends TransiteState {}

class TransiteLoaded extends TransiteState {
  final String selectedDate;
  final String languageCode;
  final TransitsModel transitsReportItem;
  const TransiteLoaded(
      {required this.transitsReportItem,
      required this.selectedDate,
      required this.languageCode});
  @override
  List<Object> get props => [transitsReportItem, selectedDate, languageCode];
}

class TransiteNetworkNotConnected extends TransiteState {}
