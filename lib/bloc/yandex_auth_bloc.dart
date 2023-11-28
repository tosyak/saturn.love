import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_yandex/flutter_login_yandex.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:saturn/utils/logger.dart';

class YandexAuthBloc extends Bloc<YandexAuthEvent, YandexAuthState> {
  YandexAuthBloc({
    required this.yandexAuthPlugin,
    required this.signInRepository,
    required this.signUpRepository,
  }) : super(YandexAuthInitial()) {
    on<YandexAuthResetStateEvent>((event, emit) => emit(YandexAuthInitial()));
    on<YandexAuthSignIn>(_signInWithYandex);
    on<YandexAuthSignUp>(_signUpWithYandex);
    on<CheckYandexAuthResponse>(_checkYandexAuthResponse);
  }

  final FlutterLoginYandex yandexAuthPlugin;
  final SocialSignInRepository signInRepository;
  final SocialSignUpRepository signUpRepository;

  String _signInToken = '';

  _signInWithYandex(
      YandexAuthSignIn event, Emitter<YandexAuthState> emit) async {
    if (Platform.isIOS) {
      await yandexAuthPlugin.signOut();
    }
    try {
      final response = await yandexAuthPlugin.signIn();
      if (response != null) {
        if (response['token'] != null) {
          _signInToken = response['token'] as String;
          _userSignInDataRequest();
        } else {
          _signInToken = response['error'] as String;
          throw Exception('yandexAuthSignIn error $_signInToken');
        }
      }
    } catch (e) {
      throw Exception('yandexAuthSignIn error $e');
    }
  }

  Future<void> _userSignInDataRequest() async {
    const String url = 'https://login.yandex.ru/info?format=jwt';
    final Map<String, String> headers = {
      'Authorization': 'OAuth $_signInToken'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      logger.i(response.statusCode);
      logger.i('response.body yandex ${response.body}');
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        _decodeJWTSignInToken(responseBody);
      } else {
        throw Exception('yandex response.statusCode ${response.statusCode}');
      }
    } catch (e) {
      logger.i('Error: $e');
      throw Exception('yandex fetchSignInInfo error $e');
    }
  }

  void _decodeJWTSignInToken(jwtToken) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    _fetchUserSignInData(
      email: decodedToken['email'],
      sloginId: decodedToken['uid'],
    );
  }

  Future<void> _fetchUserSignInData(
      {required String email, required int sloginId}) async {
    final Map<String, dynamic> response =
        await signInRepository.socialSignInRequest(
            email: email, provider: 'yandex', sloginId: sloginId);
    add(CheckYandexAuthResponse(response: response));
  }

  //
  // Sign up
  //

  _signUpWithYandex(
      YandexAuthSignUp event, Emitter<YandexAuthState> emit) async {
    if (Platform.isIOS) {
      await yandexAuthPlugin.signOut();
    }
    try {
      final response = await yandexAuthPlugin.signIn();
      if (response != null) {
        if (response['token'] != null) {
          _signInToken = response['token'] as String;
          _userSignUpDataRequest();
        } else {
          _signInToken = response['error'] as String;
          throw Exception('yandexAuthSignUp error $_signInToken');
        }
      }
    } catch (e) {
      throw Exception('yandexAuthSignUp error $e');
    }
  }

  Future<void> _userSignUpDataRequest() async {
    const String url = 'https://login.yandex.ru/info?format=jwt';
    final headers = {'Authorization': 'OAuth $_signInToken'};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _decodeJWTSignUpToken(responseBody);
      } else {
        throw Exception('yandex response.statusCode ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error: $e');
      throw Exception('yandex fetchLoginInfo $e');
    }
  }

  void _decodeJWTSignUpToken(jwtToken) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    _fetchUserSignUpData(
      email: decodedToken['email'],
      sloginId: decodedToken['uid'],
    );
  }

  Future<void> _fetchUserSignUpData(
      {required String email, required int sloginId}) async {
    final Map<String, dynamic> response =
        await signInRepository.socialSignInRequest(
            email: email, provider: 'yandex', sloginId: sloginId);
    add(CheckYandexAuthResponse(response: response));
  }

  _checkYandexAuthResponse(
      CheckYandexAuthResponse event, Emitter<YandexAuthState> emit) async {
    switch (event.response['status']) {
      case 'OK':
        _saveUserData(event.response);
        emit(YandexAuthSuccess());
        break;
      case 'FIND_EMAIL':
        logger.i('yandex FIND_EMAIL');
        _saveUserData(event.response);
        emit(YandexAuthFindEmail());
        break;
      case 'FIND_USER':
        logger.i('yandex FIND_USER');
        _saveUserData(event.response);
        emit(YandexAuthFindUser());
        break;
      case 'NOTTUSER':
        logger.i('case notuser');
        emit(YandexAuthNotTUser());
        break;
      case 'ERROR':
        logger.i('case error');
        emit(YandexAuthError());
        break;
      default:
    }
  }

  void _saveUserData(Map<String, dynamic> response) {
    if (response['user_id'] is int) {
      UserSharedPreferences().saveUserId(response['user_id']);
    } else {
      UserSharedPreferences().saveUserId(int.parse(response['user_id']));
    }
    UserSharedPreferences()
        .saveUserData(response['username'], response['email']);
  }
}

//
// Events
//

abstract class YandexAuthEvent extends Equatable {
  const YandexAuthEvent();

  @override
  List<Object> get props => [];
}

class YandexAuthResetStateEvent extends YandexAuthEvent {}

class YandexAuthSignIn extends YandexAuthEvent {}

class YandexAuthSignUp extends YandexAuthEvent {}

class CheckYandexAuthResponse extends YandexAuthEvent {
  final Map<String, dynamic> response;
  const CheckYandexAuthResponse({required this.response});

  @override
  List<Object> get props => [response];
}

//
// States
//

abstract class YandexAuthState extends Equatable {
  const YandexAuthState();

  @override
  List<Object> get props => [];
}

class YandexAuthInitial extends YandexAuthState {}

class YandexAuthLoading extends YandexAuthState {}

class YandexAuthSuccess extends YandexAuthState {}

class YandexAuthNotTUser extends YandexAuthState {}

class YandexAuthError extends YandexAuthState {}

class YandexAuthFindUser extends YandexAuthState {}

class YandexAuthFindEmail extends YandexAuthState {}
