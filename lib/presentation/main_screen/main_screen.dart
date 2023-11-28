import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saturn/bloc/main_screen_bloc.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/bloc/moon_screen_bloc.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:saturn/bloc/sadisati_screen_bloc.dart';
import 'package:saturn/bloc/transits_screen_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        int tabIndex = state.tabIndex;
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/images/report_button1.png',
                  ),
                ),
                label: AppLocalizations.of(context)!.report,
                backgroundColor: AppColors.dark,
              ),
              BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/images/transit_button1.png',
                  ),
                ),
                label: AppLocalizations.of(context)!.transite,
                backgroundColor: AppColors.dark,
              ),
              BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/images/lunar_button1.png',
                  ),
                ),
                label: AppLocalizations.of(context)!.lunar,
                backgroundColor: AppColors.dark,
              ),
              BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage(
                    'assets/images/sadi_sati_button1.png',
                  ),
                ),
                label: AppLocalizations.of(context)!.sadi,
                backgroundColor: AppColors.dark,
              ),
            ],
            showUnselectedLabels: true,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            iconSize: 37,
            selectedItemColor: AppColors.beige,
            unselectedItemColor: AppColors.beige50,
            currentIndex: tabIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int idx) => _onItemTapped(idx, context),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    final reportIndex = context.read<ReportScreenBloc>().reportIndex;
    switch (index) {
      case 0:
        BlocProvider.of<MainScreenBloc>(context).add(const SetTabIndex(0));
        BlocProvider.of<ReportScreenBloc>(context).add(const EmitReportItem());
        context.goNamed(AppPage.reportScreen.toName);
        break;
      case 1:
        BlocProvider.of<MainScreenBloc>(context).add(const SetTabIndex(1));
        BlocProvider.of<TransiteBloc>(context).add(FetchTransite(
            reportIndex: reportIndex,
            date: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())));

        context.goNamed(AppPage.transits.toName);
        break;
      case 2:
        BlocProvider.of<MainScreenBloc>(context).add(const SetTabIndex(2));
        BlocProvider.of<MoonBloc>(context).add(FetchMoon(
            reportIndex: reportIndex,
            date: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())));
        context.goNamed(AppPage.lunarCalendar.toName);
        break;
      case 3:
        BlocProvider.of<MainScreenBloc>(context).add(const SetTabIndex(3));
        BlocProvider.of<SadiSatiBloc>(context).add(FetchSadiSati(reportIndex));
        context.goNamed(AppPage.sadeSatie.toName);
        break;
    }
  }
}
