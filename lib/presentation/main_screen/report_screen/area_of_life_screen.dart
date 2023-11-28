import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/utils/string_highlighter.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class AreaOfLifeScreen extends StatelessWidget {
  const AreaOfLifeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.ariaOfLife;
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
              _AreaOfLifeHint(),
              gapH24,
              _AreaOfLIfeCards(),
              gapH24,
              // model.reportItem.lagnesh?.content != 0
              //     ? const _LagneshCard()
              //     : const SizedBox.shrink(),
              // gapH24,
            ],
          ),
        ),
      ),
    );
  }
}

class _AreaOfLifeHint extends StatelessWidget {
  const _AreaOfLifeHint();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final lagneshAbout = StringHighlighterSpan()
            .arsenal16pxHighlighter(state.reportItem.lagneshBlock?.about ?? '');
        return lagneshAbout;
      }
      return const SizedBox.shrink();
    });

    // return RichText(
    //   text: TextSpan(
    //     text: model.reportItem.lagneshBlock?.about,
    //     // text: AppLocalizations.of(context)!.areaOfLifeHint,
    //     style: AppTextStyle.arsenal16Light,
    //     children: const <TextSpan>[
    //       // TextSpan(
    //       //   text: AppLocalizations.of(context)!.areaOfLifeHint1,
    //       //   style: AppTextStyle.arsenal16BeigeBold,
    //       // ),
    //       // TextSpan(
    //       //   text: AppLocalizations.of(context)!.areaOfLifeHint2,
    //       // ),
    //       // TextSpan(
    //       //   text: AppLocalizations.of(context)!.areaOfLifeHint3,
    //       //   style: AppTextStyle.arsenal16BeigeBold,
    //       // ),
    //       // TextSpan(
    //       //   text: AppLocalizations.of(context)!.areaOfLifeHint4,
    //       // ),
    //     ],
    //   ),
    // );
  }
}

class _AreaOfLIfeCards extends StatelessWidget {
  const _AreaOfLIfeCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final List<Widget> cardList = [];
        final lagneshBlockList = state.reportItem.lagneshBlock?.child;
        for (var i = 0; i < lagneshBlockList!.length; i++) {
          if (lagneshBlockList[i].about != null) {
            if (lagneshBlockList[i].content == '0') {
              final planetCard = ReportDecoratedCardSubscribeWidget(
                buttonIsActive:
                    state.reportItem.lagneshBlock?.child?[i].about != null
                        ? true
                        : false,
                isTransparent: false,
                dialogText:
                    state.reportItem.lagneshBlock?.child?[i].about ?? '',
                cardTitle: state.reportItem.lagneshBlock?.child?[i].title ?? '',
              );
              cardList.add(planetCard);
            } else {
              final planetCard = DecoratedCardWidget(
                buttonIsActive:
                    state.reportItem.lagneshBlock?.child?[i].about != null
                        ? true
                        : false,
                isTransparent: false,
                dialogText:
                    state.reportItem.lagneshBlock?.child?[i].about ?? '',
                cardTitle: state.reportItem.lagneshBlock?.child?[i].title ?? '',
                bodyText: state.reportItem.lagneshBlock?.child?[i].content!
                        .replaceAll('\r\n', '')
                        .replaceAll(RegExp(' {3,}'), ' ') ??
                    '',
              );
              cardList.add(planetCard);
            }
          } else {
            if (lagneshBlockList[i].content == '0') {
              final planetCard = ReportDecoratedCardSubscribeWidget(
                buttonIsActive:
                    state.reportItem.lagneshBlock?.child?[i].about != null
                        ? true
                        : false,
                isTransparent: false,
                dialogText:
                    state.reportItem.lagneshBlock?.child?[i].about ?? '',
                cardTitle: state.reportItem.lagneshBlock?.child?[i].title ?? '',
                // bodyText: model.reportItem.lagneshBlock?.child?[i].content!
                //         .replaceAll('\r\n', '')
                //         .replaceAll(RegExp(' {3,}'), ' ') ??
                //     '',
              );
              cardList.add(planetCard);
            } else {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: DecoratedCardWidget(
                  buttonIsActive:
                      state.reportItem.lagneshBlock?.child?[i].about != null
                          ? true
                          : false,
                  isTransparent: false,
                  dialogText:
                      state.reportItem.lagneshBlock?.child?[i].about ?? '',
                  cardTitle:
                      state.reportItem.lagneshBlock?.child?[i].title ?? '',
                  bodyText:
                      state.reportItem.lagneshBlock?.child?[i].content ?? '',
                ),
              );
              cardList.add(card);
            }
          }
        }

        return Column(children: cardList);
      }
      return Container();
    });
  }
}

// class _LagneshCard extends StatelessWidget {
//   const _LagneshCard();

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<ReportViewModel>();
//     final List<Widget> list = [];
//     final String contentString =
//         model.reportItem.lagnesh?.content!.split('\r\n');

//     final convertedString = RichText(
//       text: TextSpan(
//         text: contentString[0].replaceAll('\r\n', ''),
//         style: AppTextStyle.arsenal16LightBold,
//         children: <TextSpan>[
//           TextSpan(
//             text: contentString[1].trimLeft(),
//             style: AppTextStyle.arsenal16Light,
//           ),
//         ],
//       ),
//     );

//     list.add(convertedString);

//     return Column(
//       children: [
//         gapH16,
//         ReportDecoratedCardWidget(
//           buttonIsActive: true,
//           isTransparent: false,
//           dialogText: model.reportItem.lagnesh?.about ?? '',
//           cardTitle: model.reportItem.lagnesh?.title ?? '',
//           bodyText: list,
//         ),
//         // DecoratedCardWidget(
//         //   buttonIsActive: true,
//         //   isTransparent: false,
//         //   dialogText: model.reportItem.lagnesh?.about ?? '',
//         //   cardTitle: model.reportItem.lagnesh?.title ?? '',
//         //   bodyText: model.reportItem.lagnesh?.content ?? '',
//         // ),
//       ],
//     );
//   }
// }

// class _SubscribeWidget extends StatelessWidget {
//   const _SubscribeWidget();

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = ScreenSize(context).width;

//     return BlocBuilder<ReportScreenCubit, ReportScreenState>(
//         builder: (context, state) {
//       if (state is ReportScreenReportLoaded) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               state.reportItem.lagneshBlock?.child?[0].title ?? '',
//               style: AppTextStyle.arsenal22Light,
//             ),
//             Stack(
//               children: [
//                 Container(
//                   width: screenWidth - paddingSize * 2,
//                   margin: const EdgeInsets.only(
//                     top: 16,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.beige10,
//                       border: Border.all(
//                         width: 2,
//                         color: AppColors.beige,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20, top: 16.0, right: 20, bottom: 16),
//                       child: Column(
//                         children: [
//                           Text(
//                             AppLocalizations.of(context)!.toAccess,
//                             style: AppTextStyle.playfairDisplay19Beige,
//                           ),
//                           gapH16,
//                           SizedBox(
//                             height: 40,
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 // foregroundColor: AppColors.beige,
//                                 backgroundColor: Colors.transparent,
//                               ),
//                               onPressed: () {
//                                 context.pushNamed(AppPage.tariffs.toName);
//                               },
//                               child: Text(
//                                 AppLocalizations.of(context)!
//                                     .checkoutSubscription,
//                                 style: const TextStyle(fontSize: 19),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Positioned(
//                   top: 1,
//                   right: 15,
//                   child: ImageIcon(
//                     AssetImage("assets/images/card_icon.png"),
//                     color: AppColors.beige,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       }
//       return Container();
//     });
//   }
// }
