import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository signUpRepository;
  SignUpBloc({required this.signUpRepository}) : super(SignUpInitial()) {
    on<SignUpRequest>(_fetchUserSignUpData);
    on<SaveUserData>(_saveUserData);
  }

  Future<void> _fetchUserSignUpData(
      SignUpRequest event, Emitter<SignUpState> emit) async {
    final Map<String, dynamic> response = await signUpRepository.signUpRequest(
      username: event.username,
      email: event.email,
      password: event.password,
    );
    add(SaveUserData(response: response));
  }

  _saveUserData(SaveUserData event, Emitter<SignUpState> emit) async {
    switch (event.response['status']) {
      case 'OK':
        UserSharedPreferences().saveUserId(event.response['user_id']);
        UserSharedPreferences()
            .saveUserData(event.response['username'], event.response['email']);
        emit(SignUpSuccess());
        break;
      case 'FIND_EMAIL':
        logger.i('case notuser');
        emit(SignUpFindEmail());
        break;
      case 'FIND_USER':
        logger.i('case error');
        emit(SignUpFindUser());
        break;
      case 'INVALID_EMAIL':
        logger.i('case error');
        emit(SignUpInvalidEmail());
        break;
      case 'ERROR':
        logger.i('case error');
        emit(SignUpError());
        break;
      default:
    }
  }
}

//
// Events
//

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object> get props => [];
}

class SignUpRequest extends SignUpEvent {
  final String username;
  final String email;
  final String password;

  const SignUpRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

class SaveUserData extends SignUpEvent {
  final Map<String, dynamic> response;

  const SaveUserData({required this.response});
  @override
  List<Object> get props => [response];
}

//
// States
//

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFindEmail extends SignUpState {}

class SignUpFindUser extends SignUpState {}

class SignUpInvalidEmail extends SignUpState {}

class SignUpError extends SignUpState {}

