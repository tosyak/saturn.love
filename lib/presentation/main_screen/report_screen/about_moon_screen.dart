import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class AboutMoonScreen extends StatelessWidget {
  const AboutMoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.aboutMoon;
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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AboutMoonHint(),
              gapH24,
              _AboutMoonCards(),

              gapH24,
              // Padding(
              //   padding: ConstantSize.screenPadding,
              //   child: _ConnectTelegram(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutMoonHint extends StatelessWidget {
  const _AboutMoonHint();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        return RichText(
          text: TextSpan(
            // text: AppLocalizations.of(context)!.aboutMoonHint,
            text: state.reportItem.habbyBlock?.about,
            style: AppTextStyle.arsenal16Light,
            children: const <TextSpan>[
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint1,
              //   style: AppTextStyle.arsenal16BeigeBold,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint2,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint3,
              //   style: AppTextStyle.arsenal16BeigeBold,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint4,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint5,
              //   style: AppTextStyle.arsenal16BeigeBold,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint6,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint7,
              //   style: AppTextStyle.arsenal16BeigeBold,
              // ),
              // TextSpan(
              //   text: AppLocalizations.of(context)!.aboutMoonHint8,
              // ),
            ],
          ),
        );
      }
      return Container();
    });
  }
}

class _AboutMoonCards extends StatelessWidget {
  const _AboutMoonCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final List<Widget> cardList = [];
        state.reportItem.habbyBlock?.child?.forEach(
          (key, value) {
            if (state.reportItem.habbyBlock?.child?[key]?.content != '0') {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: DecoratedCardWidget(
                  buttonIsActive: false,
                  isTransparent: false,
                  cardTitle:
                      state.reportItem.habbyBlock?.child?[key]?.title ?? "",
                  bodyText:
                      state.reportItem.habbyBlock?.child?[key]?.content ?? "",
                ),
              );

              cardList.add(card);
            }
          },
        );
        return Column(children: cardList);
      }
      return Container();
    });
  }
}
