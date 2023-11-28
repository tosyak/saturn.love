import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReportScreenBloc, ReportScreenState>(
          listener: (context, state) {
            if (state is ReportScreenReportLoaded) {
              context.goNamed(AppPage.reportScreen.toName);
            }
          },
        ),
        BlocListener<CacheManagerCubit, CacheManagerState>(
          listener: (context, state) {
            if (state is CacheManagerReportItemCached) {
              BlocProvider.of<ReportScreenBloc>(context)
                  .add(GetReportItem(state.reportId));
              // context.read<ReportScreenBloc>().getReportItem(state.reportId);
            } else if (state is CacheManagerReportsListIsEmptyResponseIsEmpty) {
              context.goNamed(AppPage.getReportForm.toName);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SizedBox(
          width: ScreenSize(context).width,
          height: ScreenSize(context).height,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      // )
    );
  }
}
