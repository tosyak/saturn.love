import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/my_account_screen.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class YourAscendantScreen extends StatelessWidget {
  const YourAscendantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.yourAscendant;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingAndActionsHeight(),
        title: Text(title, maxLines: 4),
        actions: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 4),
              child: IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/images/account_icon.png'),
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAccountScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
          if (state is ReportScreenReportLoaded) {
            return Container(
              width: screenWidth,
              height: screenHeight,
              padding: ConstantSize.screenPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.reportItem.oneHouse?.content == '0'
                        ? ReportDecoratedCardSubscribeWidget(
                            buttonIsActive: false,
                            isTransparent: false,
                            cardTitle:
                                state.reportItem.oneHouse?.subtitle ?? '',
                          )
                        : DecoratedCardWidget(
                            buttonIsActive: false,
                            isTransparent: false,
                            cardTitle:
                                state.reportItem.oneHouse?.subtitle ?? '',
                            bodyText: state.reportItem.oneHouse?.content ?? '',
                          ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
