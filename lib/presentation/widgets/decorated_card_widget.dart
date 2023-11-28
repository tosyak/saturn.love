// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/dialog_widget.dart';

class DecoratedCardWidget extends StatelessWidget {
  DecoratedCardWidget({
    Key? key,
    required this.buttonIsActive,
    required this.isTransparent,
    this.dialogText,
    required this.cardTitle,
    this.bodyTitle,
    required this.bodyText,
    this.bodyTitleSecond,
    this.bodyTextSecond,
    this.bodyTitleThird,
    this.bodyTextThird,
  }) : super(key: key);

  final bool buttonIsActive;
  final String? dialogText;
  final bool isTransparent;
  final String cardTitle;
  final String? bodyTitle;
  final String bodyText;
  String? bodyTextSecond;
  String? bodyTitleSecond;
  String? bodyTextThird;
  String? bodyTitleThird;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    cardTitle,
                    style: AppTextStyle.arsenal22Light,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              buttonIsActive
                  ? IconButton(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(2),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ShowDialogWidget(
                            dialogText: Text(
                              dialogText ?? "",
                              style: AppTextStyle.arsenal16Light,
                            ),
                          ),
                        );
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/images/info_icon.png'),
                        color: AppColors.beige,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: ScreenSize(context).width,
              margin: const EdgeInsets.only(top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: isTransparent ? Colors.transparent : AppColors.beige10,
                  border: Border.all(
                    width: 2,
                    color: AppColors.beige,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, top: 16.0, right: 20, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: bodyTitle,
                          style: AppTextStyle.arsenal16LightBold,
                          children: <TextSpan>[
                            TextSpan(
                              text: bodyText,
                              style: AppTextStyle.arsenal16Light,
                            ),
                          ],
                        ),
                      ),
                      bodyTextSecond != null || bodyTitleSecond != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  text: bodyTitleSecond,
                                  style: AppTextStyle.arsenal16LightBold,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: bodyTextSecond,
                                      style: AppTextStyle.arsenal16Light,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      bodyTextThird != null || bodyTitleThird != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  text: bodyTitleThird,
                                  style: AppTextStyle.arsenal16LightBold,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: bodyTextThird,
                                      style: AppTextStyle.arsenal16Light,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 1,
              right: 15,
              child: ImageIcon(
                AssetImage("assets/images/card_icon.png"),
                color: AppColors.beige,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DecoratedCardListWidget extends StatelessWidget {
  const DecoratedCardListWidget({
    Key? key,
    this.cardTitle,
    this.forMen,
    this.forWomen,
    required this.stringsList,
  }) : super(key: key);

  final String? cardTitle;
  final String? forMen;
  final String? forWomen;
  final List<String> stringsList;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cardTitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        cardTitle ?? '',
                        style: AppTextStyle.arsenal22Light,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        Stack(
          children: [
            Container(
              width: screenWidth - paddingSize * 2,
              margin: const EdgeInsets.only(top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.beige10,
                  border: Border.all(
                    width: 2,
                    color: AppColors.beige,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 16.0, right: 20, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      forMen == null && forWomen == null
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: ImageIcon(
                                        AssetImage(
                                            "assets/images/star_icon.png"),
                                        color: AppColors.beige,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SizedBox(
                                      width: screenWidth - 85,
                                      child: RichText(
                                        // maxLines: 100,
                                        text: TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .forMen,
                                          style:
                                              AppTextStyle.arsenal16LightBold,
                                          children: [
                                            TextSpan(
                                              text: forMen,
                                              style:
                                                  AppTextStyle.arsenal16Light,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                gapH12,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: ImageIcon(
                                        AssetImage(
                                            "assets/images/star_icon.png"),
                                        color: AppColors.beige,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SizedBox(
                                      width: screenWidth - 85,
                                      child: RichText(
                                        text: TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .forWomen,
                                          style:
                                              AppTextStyle.arsenal16LightBold,
                                          children: [
                                            TextSpan(
                                              text: forWomen,
                                              style:
                                                  AppTextStyle.arsenal16Light,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                gapH8
                              ],
                            ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: ImageIcon(
                                    AssetImage("assets/images/star_icon.png"),
                                    color: AppColors.beige,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: screenWidth - 85,
                                  child: Text(
                                    stringsList[index],
                                    style: AppTextStyle.arsenal16Light,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: stringsList.length,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 1,
              right: 15,
              child: ImageIcon(
                AssetImage("assets/images/card_icon.png"),
                color: AppColors.beige,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ReportDecoratedCardWidget extends StatelessWidget {
  ReportDecoratedCardWidget({
    Key? key,
    required this.buttonIsActive,
    required this.isTransparent,
    this.dialogText,
    required this.cardTitle,
    required this.bodyText,
    // this.bodyTitle,
    // required this.bodyText,
    // this.bodyTitleSecond,
    // this.bodyTextSecond,
    // this.bodyTitleThird,
    // this.bodyTextThird,
  }) : super(key: key);

  final bool buttonIsActive;
  final String? dialogText;
  final bool isTransparent;
  final String cardTitle;
  List<dynamic> bodyText;
  // final String? bodyTitle;
  // final String bodyText;
  // String? bodyTextSecond;
  // String? bodyTitleSecond;
  // String? bodyTextThird;
  // String? bodyTitleThird;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stringsList = [];
    for (var element in bodyText) {
      final text = Text(
        element,
        style: AppTextStyle.arsenal16Light,
      );
      stringsList.add(text);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  cardTitle,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              const SizedBox(width: 15),
              buttonIsActive
                  ? IconButton(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(2),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ShowDialogWidget(
                            dialogText: Text(
                              dialogText ?? "",
                              style: AppTextStyle.arsenal16Light,
                            ),
                          ),
                        );
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/images/info_icon.png'),
                        color: AppColors.beige,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: ScreenSize(context).width,
              margin: const EdgeInsets.only(top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: isTransparent ? Colors.transparent : AppColors.beige10,
                  border: Border.all(
                    width: 2,
                    color: AppColors.beige,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, top: 16.0, right: 20, bottom: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: stringsList),
                ),
              ),
            ),
            const Positioned(
              top: 1,
              right: 15,
              child: ImageIcon(
                AssetImage("assets/images/card_icon.png"),
                color: AppColors.beige,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ReportDecoratedCardSubscribeWidget extends StatelessWidget {
  const ReportDecoratedCardSubscribeWidget({
    Key? key,
    required this.buttonIsActive,
    required this.isTransparent,
    this.dialogText,
    required this.cardTitle,
  }) : super(key: key);

  final bool buttonIsActive;
  final String? dialogText;
  final bool isTransparent;
  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  cardTitle,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              const SizedBox(width: 15),
              buttonIsActive
                  ? IconButton(
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(2),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ShowDialogWidget(
                            dialogText: Text(
                              dialogText ?? "",
                              style: AppTextStyle.arsenal16Light,
                            ),
                          ),
                        );
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/images/info_icon.png'),
                        color: AppColors.beige,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: ScreenSize(context).width,
              margin: const EdgeInsets.only(top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: isTransparent ? Colors.transparent : AppColors.beige10,
                  border: Border.all(
                    width: 2,
                    color: AppColors.beige,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, top: 16.0, right: 20, bottom: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lock_outline_rounded),
                            gapW8,
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.toAccess,
                                style: AppTextStyle.arsenal16Light,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        gapH8,
                        TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                foregroundColor: Colors.amber[600]),
                            onPressed: () {
                              context.pushNamed(AppPage.tariffs.toName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .checkoutSubscriptionCaps,
                            )),
                      ]),
                ),
              ),
            ),
            const Positioned(
              top: 1,
              right: 15,
              child: ImageIcon(
                AssetImage("assets/images/card_icon.png"),
                color: AppColors.beige,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
