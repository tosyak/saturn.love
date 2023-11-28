import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/expansion_tile_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class YogiScreen extends StatelessWidget {
  const YogiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.planetaryConnections;
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
                  context.pushNamed(AppPage.myAccount.toName);
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
          if (state is ReportScreenReportLoaded) {
            final list = state.reportItem.yogas?.child;
            final cardsList = list?.keys.toList();

            return Container(
              width: screenWidth,
              height: screenHeight,
              padding: ConstantSize.screenPadding,
              child: ListView.builder(
                itemCount: list?.length,
                itemBuilder: (context, index) {
                  final item = list?[cardsList?[index].toString()];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: item?.content != '0'
                        ? ExpansionTileCustomWidget(
                            isExpanded: index == 0,
                            title: item?.title ?? '',
                            titleStyle: AppTextStyle.arsenal22LightBold,
                            body: item?.content
                                    ?.replaceAll('\n', '\n\n')
                                    .replaceAll(RegExp(' {3,}'), '') ??
                                '')
                        : ExpansionTileSubscribeCustomWidget(
                            isExpanded: index == 0,
                            title: item?.title ?? '',
                            titleStyle: AppTextStyle.arsenal22LightBold,
                          ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
