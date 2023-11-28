// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:saturn/bloc/main_screen_bloc.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/utils/url_launcher.dart';
import 'package:saturn/presentation/about_jyotish_screen/about_jyotish_screen.dart';
import 'package:saturn/bloc/edit_user_data_bloc.dart';
import 'package:saturn/presentation/main_screen/report_screen/about_moon_screen.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/presentation/widgets/dialog_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:saturn/bloc/sadisati_screen_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jovial_svg/jovial_svg.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.decipheringChart;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateActionsHeight(),
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
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ReportScreenBloc, ReportScreenState>(
                builder: (context, state) {
                  if (state is ReportScreenLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.beige,
                      ),
                    );
                  } else if (state is ReportScreenReportLoaded) {
                    // BlocProvider.of<SadiSatiCubit>(context)
                    //     .fetchSadiSati(int.parse(state.reportItem.source!.id!));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //     onPressed: () {
                        //       throw Exception('crash app');
                        //     },
                        //     child: const Text('crash app')),
                        // gapH8,
                        Padding(
                          padding: ConstantSize.screenPadding,
                          child: Text(
                            state.reportItemCurrent.source?.title ?? '',
                            style: AppTextStyle.playfairDisplay19Beige,
                          ),
                        ),
                        gapH8,
                        // const _ReportButtons(),
                        // const _ReportCards(),
                        state.reportItem.source?.timelite == '0'
                            ? const Padding(
                                padding: ConstantSize.screenPadding,
                                child: _NoDataWidget(),
                              )
                            : const Column(
                                children: [
                                  Padding(
                                    padding: ConstantSize.screenPadding,
                                    child: _DataButtonsAndInfo(),
                                  ),
                                  // gapH4,
                                  Padding(
                                    padding: ConstantSize.screenPadding,
                                    child: _SadeSatieInfoDialog(),
                                  ),
                                  gapH12,
                                  _ReportCard(),
                                  gapH16,
                                  Padding(
                                    padding: ConstantSize.screenPadding,
                                    child: _RectificationInfoDialog(),
                                  ),
                                  _ReportCards(),
                                ],
                              ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: ConstantSize.screenPadding,
                          child: _LinksListWidget(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportButtons extends StatefulWidget {
  const _ReportButtons();

  @override
  State<_ReportButtons> createState() => __ReportButtonsState();
}

class __ReportButtonsState extends State<_ReportButtons> {
  int buttonIndex = 1;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final int dialogOpen = prefs.getInt('dialog_open') ?? 0;
      if (dialogOpen == 0 && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return ShowDialogWidget(
                redColor: true,
                richText: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.attention,
                    style: AppTextStyle.arsenal20LightBold,
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.rectificationWarn,
                        style: AppTextStyle.arsenal20Light,
                      )
                    ],
                  ),
                ),
                dialogText: const Text(''),
              );
            },
          ).then((_) {
            if (mounted) {
              prefs.setInt("dialog_open", 1);
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          final oldDateTime = state.reportItemOld.time?.date!.add(Duration(
              hours: int.parse(state.reportItemCurrent.source!.zone!)));
          final nextDateTime = state.reportItemNext.time?.date!.add(Duration(
              hours: int.parse(state.reportItemCurrent.source!.zone!)));

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(94, 46),
                  textStyle: AppTextStyle.arsenal12Light,
                  side: const BorderSide(width: 1, color: AppColors.beige),
                  backgroundColor: state.pageIndex == 0
                      ? AppColors.beige
                      : Colors.transparent,
                ),
                onPressed: () {
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const SetPageIndex(index: 0));
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const MakeOldReport());
                },
                child: Column(
                  children: [
                    Text(DateFormat("dd.MM.yyyy")
                        .format(oldDateTime ?? DateTime(0000 - 00 - 00))
                        .toString()),
                    Text(DateFormat("HH:mm")
                        .format(oldDateTime ?? DateTime(0000 - 00 - 00))
                        .toString()),
                  ],
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(94, 46),
                  textStyle: AppTextStyle.arsenal12Light,
                  side: const BorderSide(width: 1, color: AppColors.beige),
                  backgroundColor: state.pageIndex == 1
                      ? AppColors.beige
                      : Colors.transparent,
                ),
                onPressed: () {
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const SetPageIndex(index: 1));
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const MakeCurrentReport());
                },
                child: Column(
                  children: [
                    Text(DateFormat("dd.MM.yyyy")
                        .format(state.reportItemCurrent.source?.datar ??
                            DateTime(0000 - 00 - 00))
                        .toString()),
                    Text(state.reportItemCurrent.source?.timer ?? ''),
                  ],
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(94, 46),
                  textStyle: AppTextStyle.arsenal12Light,
                  side: const BorderSide(width: 1, color: AppColors.beige),
                  backgroundColor: state.pageIndex == 2
                      ? AppColors.beige
                      : Colors.transparent,
                ),
                onPressed: () {
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const SetPageIndex(index: 2));
                  BlocProvider.of<ReportScreenBloc>(context)
                      .add(const MakeNextReport());
                },
                child: Column(
                  children: [
                    Text(DateFormat("dd.MM.yyyy")
                        .format(nextDateTime ?? DateTime(0000 - 00 - 00))
                        .toString()),
                    Text(DateFormat("HH:mm")
                        .format(nextDateTime ?? DateTime(0000 - 00 - 00))
                        .toString()),
                  ],
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ReportCards extends StatelessWidget {
  const _ReportCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          return Padding(
            padding: ConstantSize.screenPadding,
            child: Column(
              children: [
                state.reportItem.energy?.content != '0'
                    ? ReportDecoratedCardWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItemCurrent.energy?.about ?? '',
                        cardTitle: state.reportItemCurrent.energy?.title ?? '',
                        bodyText: state.reportItem.energy?.content,
                      )
                    : ReportDecoratedCardSubscribeWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItem.energy?.about ?? '',
                        cardTitle: state.reportItem.energy?.title ?? '',
                      ),
                Column(
                  children: [
                    state.reportItem.happy?.content != '0'
                        ? ReportDecoratedCardWidget(
                            buttonIsActive: true,
                            isTransparent: false,
                            dialogText:
                                state.reportItemCurrent.happy?.about ?? '',
                            cardTitle:
                                state.reportItemCurrent.happy?.title ?? '',
                            bodyText: state.reportItem.happy?.content,
                          )
                        : ReportDecoratedCardSubscribeWidget(
                            buttonIsActive: true,
                            isTransparent: false,
                            dialogText: state.reportItem.happy?.about ?? '',
                            cardTitle: state.reportItem.happy?.title ?? '',
                          ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutMoonScreen(),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.more))
                  ],
                ),
                state.reportItem.rost?.content is Map<String, dynamic>
                    ? ReportDecoratedCardSubscribeWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItem.rost?.about ?? '',
                        cardTitle: state.reportItem.rost?.title ?? '',
                      )
                    : ReportDecoratedCardWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItemCurrent.rost?.about ?? '',
                        cardTitle: state.reportItemCurrent.rost?.title ?? '',
                        bodyText: state.reportItem.rost?.content,
                      ),
                state.reportItem.type?.content != '0'
                    ? DecoratedCardWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItemCurrent.type?.about ?? '',
                        cardTitle: state.reportItemCurrent.type?.title ?? '',
                        bodyTitle:
                            '${AppLocalizations.of(context)!.house} ${state.reportItem.type?.home}: ',
                        bodyText: state.reportItem.type?.content ?? '',
                      )
                    : ReportDecoratedCardSubscribeWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItem.type?.about ?? '',
                        cardTitle: state.reportItem.type?.title ?? '',
                      ),
                state.reportItem.asket?.content != '0'
                    ? ReportDecoratedCardWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItemCurrent.asket?.about ?? '',
                        cardTitle: state.reportItemCurrent.asket?.title ?? '',
                        bodyText: state.reportItem.asket?.content,
                      )
                    : ReportDecoratedCardSubscribeWidget(
                        buttonIsActive: true,
                        isTransparent: false,
                        dialogText: state.reportItem.asket?.about ?? '',
                        cardTitle: state.reportItem.asket?.title ?? '',
                      ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _NoDataWidget extends StatelessWidget {
  const _NoDataWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          return Container(
            width: ScreenSize(context).width,
            margin: const EdgeInsets.only(top: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColors.beige,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 16.0, right: 20, bottom: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.addDate,
                        style: AppTextStyle.arsenal22Light,
                      ),
                      gapH20,
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditUserBloc>(context).add(
                              EditUserLoadReport(index: state.reportIndex));
                          context.goNamed(AppPage.userInputData.toName);
                        },
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context)!.editDataCaps,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _SadeSatieInfoDialog extends StatefulWidget {
  const _SadeSatieInfoDialog();

  @override
  State<_SadeSatieInfoDialog> createState() => _SadeSatieInfoDialogState();
}

class _SadeSatieInfoDialogState extends State<_SadeSatieInfoDialog> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SadiSatiBloc, SadiSatiState>(
        listener: (context, state) {
          if (state is SadiSatiPeriodIsActive) {
            print('widget period active');
            setState(() {
              isActive = true;
            });
          }
        },
        child: isActive
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: ScreenSize(context).width,
                  decoration: BoxDecoration(
                      color: AppColors.beige,
                      borderRadius: BorderRadius.circular(5)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 34, bottom: 16),
                        child: Text(
                          AppLocalizations.of(context)!.sadeSatiePeriod,
                          style: AppTextStyle.arsenal16LightBold,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: -2,
                        child: IconButton(
                          splashRadius: 8,
                          onPressed: () {
                            setState(() {
                              isActive = false;
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink());

    // return BlocListener<SadiSatiCubit, SadiSatiState>(
    //   listener: (context, state) {
    //     if (state is SadiSatiPeriodIsActive) {
    //       isActive = true;

    //     }
    //     child: isActive
    //           ? Container(
    //               width: ScreenSize(context).width,
    //               decoration: BoxDecoration(
    //                   color: AppColors.beige,
    //                   borderRadius: BorderRadius.circular(5)),
    //               child: Stack(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(
    //                         left: 16, top: 16, right: 34, bottom: 16),
    //                     child: Text(
    //                       AppLocalizations.of(context)!.sadeSatiePeriod,
    //                       style: AppTextStyle.arsenal16LightBold,
    //                     ),
    //                   ),
    //                   Positioned(
    //                     top: 2,
    //                     right: -2,
    //                     child: IconButton(
    //                       splashRadius: 8,
    //                       onPressed: () {
    //                         setState(() {
    //                           isActive = false;
    //                         });
    //                       },
    //                       icon: const Icon(Icons.close),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           : const SizedBox.shrink();
    // return Container(
    //   child: const Text('123123'),
    // );
    // },
    // );
  }
}

class _DataButtonsAndInfo extends StatelessWidget {
  const _DataButtonsAndInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        state.reportItemCurrent.ayanamsa ?? '',
                        style: AppTextStyle.arsenal16LightBold,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      bool networkIsConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (!networkIsConnected) {
                        showSnackBarWidget(
                            AppLocalizations.of(context)!.checkNetwork,
                            context);
                      } else {
                        BlocProvider.of<EditUserBloc>(context)
                            .add(EditUserLoadReport(index: state.reportIndex));
                        context.goNamed(AppPage.userInputData.toName);
                      }
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/images/data_icon.png'),
                      color: AppColors.beige,
                      size: 65,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard();

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenSize(context).width;
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          return Stack(
            children: [
              Positioned(
                width: screenWidth * 0.7,
                top: 32,
                left: 0,
                child: Transform.rotate(
                  angle: 15 * math.pi / 180,
                  child: Image.asset('assets/images/report_background_top.png'),
                ),
              ),
              Positioned(
                width: screenWidth * 0.7,
                bottom: 32,
                right: 0,
                child: Transform.rotate(
                  angle: 15 * math.pi / 180,
                  child:
                      Image.asset('assets/images/report_background_bottom.png'),
                ),
              ),
              Padding(
                padding: ConstantSize.screenPadding,
                child: Column(
                  children: [
                    const _ReportButtons(),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutJyotishScreen()),
                        );
                      },
                      child: Text(
                          '${AppLocalizations.of(context)!.whatIsJyotish}?'),
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: state.image != null
                              ? ScalableImageWidget(
                                  si: ScalableImage.fromSvgString(state.image!),
                                )
                              : const SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.beige),
                                  ),
                                )),
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)!.shareReport),
                      ),
                    ),
                    gapH16,
                    SizedBox(
                      child: OutlinedButton(
                        onPressed: () {
                          UrlLauncher()
                              .launchTelegram('https://t.me/astrosaturn');
                        },
                        child: Text(
                            AppLocalizations.of(context)!.telegramDiscussion),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _RectificationInfoDialog extends StatefulWidget {
  const _RectificationInfoDialog();

  @override
  State<_RectificationInfoDialog> createState() =>
      _RectificationInfoDialogState();
}

class _RectificationInfoDialogState extends State<_RectificationInfoDialog> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
            decoration: BoxDecoration(
                color: AppColors.beige, borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 16, right: 34, bottom: 16),
                  child: Text(
                    AppLocalizations.of(context)!.rectificationWarn,
                    style: AppTextStyle.arsenal16Light,
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: IconButton(
                    splashRadius: 8,
                    onPressed: () {
                      setState(() {
                        isActive = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _LinksListWidget extends StatelessWidget {
  const _LinksListWidget();

  @override
  Widget build(BuildContext context) {
    // double _textSize(String text) {
    //   final TextPainter textPainter = TextPainter(
    //     text: TextSpan(
    //       text: text,
    //       style: AppTextStyle.arsenal22Light,
    //     ),
    //     maxLines: 1,
    //     textDirection: ui.TextDirection.ltr,
    //   )..layout(minWidth: 0, maxWidth: double.infinity);
    //   return textPainter.size.width + paddingSize + paddingSize;
    // }

    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              //

              state.reportItem.oneHouse != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                          onPressed: () {
                            context.goNamed(AppPage.yourAscendant.toName);
                          },
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "${AppLocalizations.of(context)!.yourAscendant}\u00a0\u00a0→",
                            style: AppTextStyle.arsenal22Light,
                          )),
                    )
                  : const SizedBox.shrink(),

              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        context.goNamed(AppPage.aboutMoon.toName);
                      },
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '${AppLocalizations.of(context)!.aboutMoon}\u00a0\u00a0→',
                        style: AppTextStyle.arsenal22Light,
                      )),
                ),
              ),

              //
              //

              state.reportItem.downPlanet != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                          onPressed: () {
                            context.goNamed(AppPage.workingMethods.toName);
                          },
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '${AppLocalizations.of(context)!.workingMethods}\u00a0\u00a0→',
                            style: AppTextStyle.arsenal22Light,
                          )),
                    )
                  : const SizedBox.shrink(),

              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                    onPressed: () {
                      context.goNamed(AppPage.yogi.toName);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '${AppLocalizations.of(context)!.planetaryConnections}\u00a0\u00a0→',
                      style: AppTextStyle.arsenal22Light,
                    )),
              ),

              //
              //

              state.reportItem.lagneshBlock != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                          onPressed: () {
                            context.goNamed(AppPage.areaOfLife.toName);
                          },
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '${AppLocalizations.of(context)!.ariaOfLife}\u00a0\u00a0→',
                            style: AppTextStyle.arsenal22Light,
                          )),
                    )
                  : const SizedBox.shrink(),

              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                    onPressed: () {
                      context.goNamed(AppPage.aboutLove.toName);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '${AppLocalizations.of(context)!.aboutLove}\u00a0\u00a0→',
                      style: AppTextStyle.arsenal22Light,
                    )),
              ),

              //
              //

              state.reportItem.homePlanets != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextButton(
                          onPressed: () {
                            context.goNamed(AppPage.planetsInHouses.toName);
                          },
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '${AppLocalizations.of(context)!.planetsInHouses}\u00a0\u00a0→',
                            style: AppTextStyle.arsenal22Light,
                          )),
                    )
                  : const SizedBox.shrink(),

              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                    onPressed: () {
                      // BlocProvider.of<SadiSatiCubit>(context)
                      //     .fetchSadiSati(state.reportIndex);

                      BlocProvider.of<SadiSatiBloc>(context)
                          .add(FetchSadiSati(state.reportIndex));

                      context.goNamed(AppPage.sadeSatie.toName);
                      BlocProvider.of<MainScreenBloc>(context)
                          .add(const SetTabIndex(3));
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '${AppLocalizations.of(context)!.sadeSatie}\u00a0\u00a0→',
                      style: AppTextStyle.arsenal22Light,
                    )),
              ),

              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                    onPressed: () {
                      context.goNamed(AppPage.nakshatras.toName);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '${AppLocalizations.of(context)!.degreesNakshatras}\u00a0\u00a0→',
                      style: AppTextStyle.arsenal22Light,
                    )),
              ),
              gapH24,
            ],
          );
        }
        return Container();
      },
    );
  }
}
