import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/bloc/splash_screen_bloc.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/bloc/google_auth_bloc.dart';
import 'package:saturn/bloc/vk_auth_bloc.dart';
import 'package:saturn/bloc/yandex_auth_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';

class SignInLoaderScreen extends StatelessWidget {
  const SignInLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleAuthBloc, GoogleAuthState>(
          listener: (context, state) {
            if (state is GoogleAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is GoogleAuthNottUser) {
              Navigator.pop(context);
              showSnackBarWidget(
                  AppLocalizations.of(context)!.noSocialRegistered, context);
              BlocProvider.of<GoogleAuthBloc>(context)
                  .add(GoogleAuthResetStateEvent());
            }
          },
        ),
        BlocListener<YandexAuthBloc, YandexAuthState>(
          listener: (context, state) {
            if (state is YandexAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is YandexAuthNotTUser) {
              Navigator.pop(context);
              showSnackBarWidget(
                  AppLocalizations.of(context)!.noSocialRegistered, context);
              BlocProvider.of<YandexAuthBloc>(context)
                  .add(YandexAuthResetStateEvent());
            } else if (state is YandexAuthError) {}
          },
        ),
        BlocListener<VKAuthBloc, VKAuthState>(
          listener: (context, state) {
            if (state is VKAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is VKAuthNotTUser) {
              Navigator.pop(context);
              showSnackBarWidget(
                  AppLocalizations.of(context)!.noSocialRegistered, context);
              BlocProvider.of<VKAuthBloc>(context).add(VKAuthResetStateEvent());
            } else if (state is VKAuthError) {}
          },
        ),
      ],
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.beige,
        ),
      ),
    );
  }
}

class SignUpLoaderScreen extends StatelessWidget {
  const SignUpLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleAuthBloc, GoogleAuthState>(
          listener: (context, state) {
            if (state is GoogleAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is GoogleAuthFindEmail) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget(
                    AppLocalizations.of(context)!.alreadyRegistered, context);
              });
            } else if (state is GoogleAuthFindUser) {
              showSnackBarWidget(
                  AppLocalizations.of(context)!.alreadyRegistered, context);
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            }
          },
        ),
        BlocListener<YandexAuthBloc, YandexAuthState>(
          listener: (context, state) {
            if (state is YandexAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is YandexAuthFindEmail) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget(
                    AppLocalizations.of(context)!.alreadyRegistered, context);
              });
            } else if (state is YandexAuthFindUser) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget(
                    AppLocalizations.of(context)!.alreadyRegistered, context);
              });
            } else if (state is YandexAuthError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget('Sign up error', context);
              });
            }
          },
        ),
        BlocListener<VKAuthBloc, VKAuthState>(
          listener: (context, state) {
            if (state is VKAuthSuccess) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
            } else if (state is VKAuthFindEmail) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget(
                    AppLocalizations.of(context)!.alreadyRegistered, context);
              });
            } else if (state is VKAuthFindUser) {
              BlocProvider.of<SplashBloc>(context).add(const SplashCheck());
              context.goNamed(AppPage.splash.toName);
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget(
                    AppLocalizations.of(context)!.alreadyRegistered, context);
              });
            } else if (state is VKAuthError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                showSnackBarWidget('Sign up error', context);
              });
            }
          },
        ),
      ],
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.beige,
        ),
      ),
    );
  }
}
