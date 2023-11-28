import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class AboutLoveScreen extends StatelessWidget {
  const AboutLoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.aboutLove;
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
                  context.goNamed(AppPage.myAccount.toName);
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
              // _AboutLoveHint(),
              // gapH24,
              _AboutLoveCards(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// class _AboutLoveHint extends StatelessWidget {
//   const _AboutLoveHint();

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         text: AppLocalizations.of(context)!.aboutLoveHint,
//         style: AppTextStyle.arsenal16Light,
//         children: <TextSpan>[
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint1,
//             style: AppTextStyle.arsenal16BeigeBold,
//           ),
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint2,
//           ),
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint3,
//             style: AppTextStyle.arsenal16BeigeBold,
//           ),
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint4,
//           ),
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint5,
//             style: AppTextStyle.arsenal16BeigeBold,
//           ),
//           TextSpan(
//             text: AppLocalizations.of(context)!.aboutLoveHint6,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _AboutLoveCards extends StatelessWidget {
  const _AboutLoveCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final List<Widget> cardList = [];

        if (state.reportItem.love?.child is List<dynamic>) {
          final List<dynamic> list = state.reportItem.love?.child;

          for (var i = 0; i < list.length; i++) {
            if (state.reportItem.love?.child[i]['content'] != '0') {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: DecoratedCardWidget(
                  buttonIsActive: false,
                  isTransparent: false,
                  cardTitle: state.reportItem.love?.child[i]['title'] ?? '',
                  bodyText: state.reportItem.love?.child[i]['content']
                          .replaceFirst(RegExp('^\\r\\n'), '')
                          .replaceAll(RegExp(' {3,}'), '') ??
                      '',
                ),
              );
              cardList.add(card);
            }
          }
        } else {
          final Map<String, dynamic> map = state.reportItem.love?.child;
          map.forEach((key, value) {
            if (state.reportItem.love?.child?[key]['content'] != '0' &&
                state.reportItem.love?.child?[key]['content'] != null) {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: DecoratedCardWidget(
                  buttonIsActive: false,
                  isTransparent: false,
                  cardTitle: state.reportItem.love?.child[key]['title'] ?? '',
                  bodyText: state.reportItem.love?.child?[key]['content']
                          .replaceFirst(RegExp('^\\r\\n'), '')
                          .replaceAll(RegExp(' {3,}'), '') ??
                      '',
                ),
              );
              cardList.add(card);
            }
          });
        }

        return Column(children: cardList);
      }
      return Container();
    });
  }
}
