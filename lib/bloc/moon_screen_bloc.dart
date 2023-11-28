import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:saturn/data/models/moon_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';

class MoonBloc extends Bloc<MoonEvent, MoonState> {
  MoonBloc({
    required this.repository,
  }) : super(MoonInitial()) {
    on<FetchMoon>(_fetchMoon);
  }

  final MoonRepository repository;
  String? selectedDate;
  late String languageCode;

  Future<void> _fetchMoon(FetchMoon event, Emitter<MoonState> emit) async {
    emit(MoonInitial());
    bool networkIsConnected = await InternetConnectionChecker().hasConnection;
    if (!networkIsConnected) {
      emit(MoonNetworkNotConnected());
    } else {
      languageCode = await LocaleHiveBox().getLocaleHive();
      final response = await repository.getMoonCalendarResponse(
          event.reportIndex, event.date);
      final MoonModel model = MoonModel.fromJson(response);
      selectedDate = event.date;
      emit(MoonLoaded(
          moonReportItem: model,
          selectedDate: event.date,
          languageCode: languageCode));
    }
  }
}

//
// Event
//

abstract class MoonEvent extends Equatable {
  const MoonEvent();
  @override
  List<Object> get props => [];
}

class FetchMoon extends MoonEvent {
  final int reportIndex;
  final String date;
  const FetchMoon({required this.reportIndex, required this.date});
}

//
// States
//

abstract class MoonState extends Equatable {
  const MoonState();
  @override
  List<Object> get props => [];
}

class MoonInitial extends MoonState {}

class MoonLoaded extends MoonState {
  final MoonModel moonReportItem;
  final String selectedDate;
  final String languageCode;
  const MoonLoaded(
      {required this.moonReportItem,
      required this.selectedDate,
      required this.languageCode});

  @override
  List<Object> get props => [moonReportItem, selectedDate, languageCode];
}

class MoonNetworkNotConnected extends MoonState {}
