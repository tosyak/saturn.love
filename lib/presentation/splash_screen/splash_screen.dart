import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/bloc/load_progress_bloc.dart';
import 'package:saturn/bloc/splash_screen_bloc.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:saturn/utils/locale_manager.dart';
import 'package:saturn/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleManager localeManager = LocaleManager();
    localeManager.setLocale(context);

    BlocProvider.of<SplashBloc>(context).add(const SplashCheck());

    return MultiBlocListener(
      listeners: [
        BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashNetworkConnectedAndLoggedIn) {
              logger.i('internet is connected and user is logged in');
              context.read<CacheManagerCubit>().runCacheManager();
            } else if (state is SplashNetworkConnectedAndNotLoggedIn) {
              logger.i('internet is connected and user Not logged in');
              context.goNamed(AppPage.loginSelect.toName);
            } else if (state is SplashNetworkNotConnectedAndLoggedIn) {
              logger.i('internet is not connected and user is Logged in');
              showSnackBarWidget(
                  AppLocalizations.of(context)!.checkNetwork, context);
              BlocProvider.of<CacheManagerCubit>(context)
                  .runOffLineCacheManager();
            } else if (state is SplashNetworkNotConnectedAndNotLoggedIn) {
              logger.i('internet is not connected and user is Not Logged in');
              showSnackBarWidget(
                  AppLocalizations.of(context)!.checkNetwork, context);
            }
          },
        ),
        BlocListener<CacheManagerCubit, CacheManagerState>(
          listener: (context, state) {
            if (state is CacheManagerReportsCached) {
              logger.i('all cached, go to report screen');
              BlocProvider.of<ReportScreenBloc>(context)
                  .add(const GetInitialReportItem());
              context.goNamed(AppPage.reportScreen.toName);
            } else if (state is CacheManagerReportsListIsEmptyResponseIsEmpty) {
              context.goNamed(AppPage.getReportForm.toName);
            } else if (state is CacheManagerOffLineReportsListIsNotEmpty) {
              BlocProvider.of<ReportScreenBloc>(context)
                  .add(const GetInitialReportItem());
              context.goNamed(AppPage.reportScreen.toName);
            } else if (state is CacheManagerReportLoadPercent) {
              BlocProvider.of<LoadProgressBarBloc>(context).add(ReportCached(
                  listLength: state.listLength, listIndex: state.reportIndex));
            } else if (state is CacheManagerImageLoadPercent) {
              BlocProvider.of<LoadProgressBarBloc>(context)
                  .add(const ImageCached(i: 0.9));
            }
          },
        ),
      ],
      child: Scaffold(
        body: SizedBox(
          width: ScreenSize(context).width,
          height: ScreenSize(context).height,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              BlocBuilder<LoadProgressBarBloc, LoadProgressBarState>(
                builder: (context, state) {
                  if (state is LoadProgressUpdated) {
                    return Positioned(
                      bottom: 5,
                      child: LinearPercentIndicator(
                        width: ScreenSize(context).width,
                        lineHeight: 7.0,
                        percent: state.loadProgressPercent,
                        backgroundColor: Colors.transparent,
                        progressColor: AppColors.beige,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      // )
    );
  }
}
