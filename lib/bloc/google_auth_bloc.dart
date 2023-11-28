import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc({
    required this.googleAuthPlugin,
    required this.signInRepository,
    required this.signUpRepository,
  }) : super(GoogleAuthInitial()) {
    on<GoogleAuthResetStateEvent>((event, emit) => emit(GoogleAuthInitial()));
    on<GoogleAuthSignIn>(_signInWithGoogle);
    on<GoogleAuthSignUp>(_signUpWithGoogle);
    on<CheckGoogleAuthResponse>(_checkGoogleAuthResponse);
  }

  final GoogleSignIn googleAuthPlugin;
  // final SocialSignInRepository _signInRepository = SocialSignInRepository();
  final GoogleSignInRepository signInRepository;
  final GoogleSignUpRepository signUpRepository;
  // final SocialSignUpRepository _signUpRepository = SocialSignUpRepository();

  Future<void> _signInWithGoogle(
      GoogleAuthSignIn event, Emitter<GoogleAuthState> emit) async {
    try {
      await googleAuthPlugin.signOut();
      final GoogleSignInAccount? googleUser = await googleAuthPlugin.signIn();

      if (googleUser == null) {
        logger.i("User cancelled the sign-in process.");
      } else {
        logger.i('googleUser.id ${googleUser.id}');
        _fetchUserSignInData(
          email: googleUser.email,
          // sloginId: num.parse(googleUser.id)
        );
      }
    } catch (e, stackTrace) {
      logger.e("Error signing in with Google: $e, stackTrace $stackTrace");
      throw Exception('signInWithGoogle error $e, stackTrace $stackTrace');
    }
  }

  Future<void> _fetchUserSignInData({
    required String email,
    // required num sloginId,
  }) async {
    final Map<String, dynamic> response =
        await signInRepository.socialSignInRequest(
      email: email,
      provider: 'google',
      // sloginId: sloginId,
    );
    add(CheckGoogleAuthResponse(response: response));
  }

  //
  // Sign Up
  //

  Future<void> _signUpWithGoogle(
      GoogleAuthSignUp event, Emitter<GoogleAuthState> emit) async {
    try {
      await googleAuthPlugin.signOut();
      final GoogleSignInAccount? googleUser = await googleAuthPlugin.signIn();
      if (googleUser == null) {
        logger.i("User cancelled the sign-up process.");
        throw Exception('signUpWithGoogle googleUser == null');
      }
      _fetchUserSignUpData(
        email: googleUser.email,
        //  sloginId: int.parse(googleUser.id)
      );
      logger.i("googleUser.id ${googleUser.id}");
    } catch (error) {
      logger.e("Error signing in with Google: $error");
      throw Exception('signUpWithGoogle $error');
    }
  }

  Future<void> _fetchUserSignUpData({
    required String email,
    // required int sloginId,
  }) async {
    final Map<String, dynamic> response =
        await signUpRepository.socialSignUpRequest(
      email: email,
      provider: 'google',
      // sloginId: sloginId,
    );
    add(CheckGoogleAuthResponse(response: response));
  }

  void _checkGoogleAuthResponse(
      CheckGoogleAuthResponse event, Emitter<GoogleAuthState> emit) {
    switch (event.response['status']) {
      case 'OK':
        _saveUserData(event.response);
        emit(GoogleAuthSuccess());
        break;
      case 'FIND_EMAIL':
        logger.i('case FIND_EMAIL');
        _saveUserData(event.response);
        emit(GoogleAuthFindEmail());
        break;
      case 'FIND_SUSER':
        logger.i('case FIND_SUSER');
        _saveUserData(event.response);
        emit(GoogleAuthFindUser());
        break;
      case 'NOTTUSER':
        logger.i('case notuser');
        emit(GoogleAuthNottUser());
        break;
      case 'ERROR':
        logger.i('case error');
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

abstract class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}

class GoogleAuthResetStateEvent extends GoogleAuthEvent {}

class GoogleAuthSignIn extends GoogleAuthEvent {}

class GoogleAuthSignUp extends GoogleAuthEvent {}

class CheckGoogleAuthResponse extends GoogleAuthEvent {
  final Map<String, dynamic> response;
  const CheckGoogleAuthResponse({required this.response});

  @override
  List<Object> get props => [response];
}

//
// States
//

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthNottUser extends GoogleAuthState {}

class GoogleAuthPasswordFailure extends GoogleAuthState {}

class GoogleAuthFindEmail extends GoogleAuthState {}

class GoogleAuthFindUser extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {}

class GoogleAuthError extends GoogleAuthState {}
