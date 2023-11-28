import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserSharedPreferences userIdSharedPreferences;
  SplashBloc({required this.userIdSharedPreferences}) : super(SplashInitial()) {
    on<SplashCheck>(checkNetwork);
  }

  void checkNetwork(SplashEvent event, Emitter<SplashState> emit) async {
    bool userId = await userIdSharedPreferences.checkUserId();

    bool networkIsConnected = await InternetConnectionChecker().hasConnection;

    if (networkIsConnected && userId) {
      emit(SplashNetworkConnectedAndLoggedIn());
    } else if (networkIsConnected && !userId) {
      emit(SplashNetworkConnectedAndNotLoggedIn());
    } else if (!networkIsConnected && userId) {
      emit(SplashNetworkNotConnectedAndLoggedIn());
    } else if (!networkIsConnected && !userId) {
      emit(SplashNetworkNotConnectedAndNotLoggedIn());
    } else {
      logger.e('Splash Cubit app init error');
      throw Exception('Splash Cubit app init error');
    }
  }
}

//
// Events
//

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashCheck extends SplashEvent {
  const SplashCheck();

  @override
  List<Object> get props => [];
}

//
// States
//

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashNetworkConnectedAndLoggedIn extends SplashState {}

class SplashNetworkConnectedAndNotLoggedIn extends SplashState {}

class SplashNetworkNotConnectedAndLoggedIn extends SplashState {}

class SplashNetworkNotConnectedAndNotLoggedIn extends SplashState {}
