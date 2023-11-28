import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository signInRepository;

  SignInBloc({required this.signInRepository}) : super(SignInInitial()) {
    on<SignInRequest>(_fetchUserLoginData);
    on<SaveUserData>(_saveUserData);
  }

  Future<void> _fetchUserLoginData(
      SignInRequest event, Emitter<SignInState> emit) async {
    final Map<String, dynamic> response = await signInRepository.signInRequest(
      username: event.username,
      password: event.password,
      email: event.email,
    );
    add(SaveUserData(response: response));
  }

  _saveUserData(SaveUserData event, Emitter<SignInState> emit) async {
    switch (event.response['status']) {
      case 'OK':
        UserSharedPreferences()
            .saveUserId(int.parse(event.response['user_id']));
        UserSharedPreferences()
            .saveUserData(event.response['username'], event.response['email']);
        emit(SignInSuccess());
        break;
      case 'NOTTUSER':
        logger.i('case notuser');
        emit(SignInNotTUser());
        emit(SignInInitial());
        break;
      case 'ERROR':
        logger.i('case error');
        emit(SignInError());
        emit(SignInInitial());
        break;
      default:
    }
  }
}

//
// Events
//

abstract class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object> get props => [];
}

class SignInRequest extends SignInEvent {
  final String username;
  final String password;
  final String email;

  const SignInRequest({
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  List<Object> get props => [username, email, password];
}

class SaveUserData extends SignInEvent {
  final Map<String, dynamic> response;

  const SaveUserData({required this.response});
  @override
  List<Object> get props => [response];
}

//
// States
//

abstract class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInNotTUser extends SignInState {}

class SignInError extends SignInState {}

