import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:flutter_login_yandex/flutter_login_yandex.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:saturn/bloc/main_screen_bloc.dart';
import 'package:saturn/config/app_theme.dart';
import 'package:saturn/bloc/load_progress_bloc.dart';
import 'package:saturn/bloc/splash_screen_bloc.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/bloc/google_auth_bloc.dart';
import 'package:saturn/bloc/vk_auth_bloc.dart';
import 'package:saturn/bloc/yandex_auth_bloc.dart';
import 'package:saturn/bloc/edit_user_data_bloc.dart';
import 'package:saturn/bloc/get_report_screen_bloc.dart';
import 'package:saturn/bloc/moon_screen_bloc.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:saturn/bloc/reports_list_screen_bloc.dart';
import 'package:saturn/bloc/sadisati_screen_bloc.dart';
import 'package:saturn/bloc/sign_in_screen_bloc.dart';
import 'package:saturn/bloc/sign_up_screen_bloc.dart';
import 'package:saturn/bloc/transits_screen_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(
              userIdSharedPreferences: UserSharedPreferences()),
        ),
        BlocProvider(
          create: (context) => CacheManagerCubit(),
        ),
        BlocProvider(
          create: (context) => LoadProgressBarBloc(),
        ),
        BlocProvider(
          create: (context) => MainScreenBloc(),
        ),
        BlocProvider(
          create: (context) => ReportScreenBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
            signInRepository: SignInRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
            signUpRepository: SignUpRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => GoogleAuthBloc(
            googleAuthPlugin: GoogleSignIn(),
            signInRepository: GoogleSignInRepository(),
            signUpRepository: GoogleSignUpRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => VKAuthBloc(
            vkAuthPlugin: VKLogin(),
            signInRepository: SocialSignInRepository(),
            signUpRepository: SocialSignUpRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => YandexAuthBloc(
            yandexAuthPlugin: FlutterLoginYandex(),
            signInRepository: SocialSignInRepository(),
            signUpRepository: SocialSignUpRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => EditUserBloc(
            repository: EditUserDataRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => GetReportBloc(
            repository: CreateReportRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => ReportsListBloc(
            deleteReportRepository: DeleteReportRepository(),
            editFavoriteRepository: EditFavoriteRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SadiSatiBloc(
            repository: SadiSatiRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => MoonBloc(
            repository: MoonRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => TransiteBloc(
            repository: TransitsRepository(),
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<AppRouter>(
            lazy: false,
            create: (BuildContext context) => AppRouter(),
          ),
        ],
        child: Builder(
          builder: (BuildContext context) {
            final router =
                Provider.of<AppRouter>(context, listen: false).router;

            BlocProvider.of<SplashBloc>(context).add(const SplashCheck());

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Saturn',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.darkTheme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
