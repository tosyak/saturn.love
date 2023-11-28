import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class VKAuthBloc extends Bloc<VKAuthEvent, VKAuthState> {
  VKAuthBloc({
    required this.vkAuthPlugin,
    required this.signInRepository,
    required this.signUpRepository,
  }) : super(VKAuthInitial()) {
    on<VKAuthResetStateEvent>((event, emit) => emit(VKAuthInitial()));
    on<SignInWithVK>(_signInWithVK);
    on<SignUpWithVK>(_signUpWithVK);
    on<CheckVKAuthResponse>(_checkVKAuthResponse);
  }

  final VKLogin vkAuthPlugin;
  final SocialSignInRepository signInRepository;
  final SocialSignUpRepository signUpRepository;

  void _signInWithVK(SignInWithVK event, Emitter<VKAuthState> emit) async {
    await vkAuthPlugin.initSdk();
    final isLoggedIn = await vkAuthPlugin.isLoggedIn;
    if (isLoggedIn) {
      await vkAuthPlugin.logOut();
      await _signInVKRequest();
    } else {
      await _signInVKRequest();
    }
  }

  Future<void> _signInVKRequest() async {
    final vkLoginResult = await vkAuthPlugin.logIn(scope: [
      VKScope.email,
    ]);

    if (vkLoginResult.isValue) {
      logger.i('vk login result $vkLoginResult');

      final VKLoginResult result = vkLoginResult.asValue!.value;

      if (result.isCanceled) {
        logger.i('vk login was canceled');
      } else {
        final plugin = vkAuthPlugin;
        final accessToken = await plugin.accessToken;
        if (accessToken != null) {
          logger.i('Access token: ${accessToken.token}');

          final email = await vkAuthPlugin.getUserEmail();
          final profileRes = await vkAuthPlugin.getUserProfile();
          final profile = profileRes.asValue?.value;
          // final userId = int.parse(profile!.userId);

          logger.i('vkontakte user profile $profile');
          logger.i('vkontakte user profile ${profile!.userId}');
          logger.i('And your email is $email');
          if (email != null) {
            _fetchUserLoginData(email: email, sloginId: profile.userId);
          } else {
            logger.i('email is null');
          }
        } else {
          logger.i('Something goes wrong');
        }
      }
    } else {
      final errorRes = vkLoginResult.asError!;
      logger.i('Error while log in: ${errorRes.error}');
      throw Exception('Error while log in: ${errorRes.error}');
    }
  }

  Future<void> _fetchUserLoginData({
    required String email,
    required int sloginId,
  }) async {
    final Map<String, dynamic> response =
        await signInRepository.socialSignInRequest(
      email: email,
      provider: 'vkontakte',
      sloginId: sloginId,
    );
    add(CheckVKAuthResponse(response: response));
  }

//
// Sign Up
//

  Future<void> _signUpWithVK(
      SignUpWithVK event, Emitter<VKAuthState> emit) async {
    await vkAuthPlugin.initSdk();
    final isLoggedIn = await vkAuthPlugin.isLoggedIn;
    if (isLoggedIn) {
      await vkAuthPlugin.logOut();
      await signUpVKRequest();
    } else {
      await signUpVKRequest();
    }
  }

  Future<void> signUpVKRequest() async {
    final vkSignUpResult = await vkAuthPlugin.logIn(scope: [
      VKScope.email,
    ]);

    if (vkSignUpResult.isValue) {
      logger.i('this is res $vkSignUpResult');
      final VKLoginResult result = vkSignUpResult.asValue!.value;
      if (result.isCanceled) {
        logger.i('login was canceled');
      } else {
        final plugin = vkAuthPlugin;
        final accessToken = await plugin.accessToken;
        if (accessToken != null) {
          logger.i('Access token: ${accessToken.token}');
          final email = await vkAuthPlugin.getUserEmail();
          final profileRes = await vkAuthPlugin.getUserProfile();
          print('profileRes $profileRes');
          print('profileRes $profileRes');
          final profile = profileRes.asValue?.value;
          print('profile $profile');
          print('profile ${profile!.userId}');
          // print('profile ${profile!.}');
          logger.i('And your email is $email');
          if (email != null) {
            fetchUserSignUpData(email: email, sloginId: profile.userId);
          } else {
            logger.i('email is null');
          }
        } else {
          logger.i('Something goes wrong');
        }
      }
    } else {
      final errorRes = vkSignUpResult.asError!;
      logger.i('Error while log in: ${errorRes.error}');
      throw Exception('Error while log in: ${errorRes.error}');
    }
  }

  Future<void> fetchUserSignUpData(
      {required String email, required int sloginId}) async {
    final Map<String, dynamic> response =
        await signUpRepository.socialSignUpRequest(
      email: email,
      provider: 'vkontakte',
      sloginId: sloginId,
    );
    add(CheckVKAuthResponse(response: response));
  }

  void _checkVKAuthResponse(
      CheckVKAuthResponse event, Emitter<VKAuthState> emit) {
    switch (event.response['status']) {
      case 'OK':
        _saveUserData(event.response);
        emit(VKAuthSuccess());
        break;
      case 'FIND_EMAIL':
        logger.i('VK FIND_EMAIL');
        _saveUserData(event.response);
        emit(VKAuthFindEmail());
        break;
      case 'FIND_SUSER':
        logger.i('VK FIND_SUSER');
        _saveUserData(event.response);
        emit(VKAuthFindUser());
        break;
      case 'NOTTUSER':
        logger.i('VK NOTTUSER');
        emit(VKAuthNotTUser());
        break;
      case 'ERROR':
        logger.i('VK ERROR');
        emit(VKAuthError());
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

abstract class VKAuthEvent extends Equatable {
  const VKAuthEvent();

  @override
  List<Object> get props => [];
}

class VKAuthResetStateEvent extends VKAuthEvent {}

class SignInWithVK extends VKAuthEvent {}

class SignUpWithVK extends VKAuthEvent {}

class CheckVKAuthResponse extends VKAuthEvent {
  final Map<String, dynamic> response;
  const CheckVKAuthResponse({required this.response});

  @override
  List<Object> get props => [response];
}

//
// States
//

abstract class VKAuthState extends Equatable {
  const VKAuthState();

  @override
  List<Object> get props => [];
}

class VKAuthInitial extends VKAuthState {}

class VKAuthSuccess extends VKAuthState {}

class VKAuthNotTUser extends VKAuthState {}

class VKAuthError extends VKAuthState {}

class VKAuthFindUser extends VKAuthState {}

class VKAuthFindEmail extends VKAuthState {}
