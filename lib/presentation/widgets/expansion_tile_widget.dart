// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/navigation/app_router.dart';

class ExpansionTileCustomWidget extends StatefulWidget {
  bool? isExpanded;
  final String? header;
  final String title;
  final TextStyle titleStyle;
  final String body;
  ExpansionTileCustomWidget({
    Key? key,
    this.header,
    this.isExpanded = false,
    required this.title,
    required this.titleStyle,
    required this.body,
  }) : super(key: key);

  @override
  State<ExpansionTileCustomWidget> createState() =>
      _ExpansionTileCustomWidgetState();
}

class _ExpansionTileCustomWidgetState extends State<ExpansionTileCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.header != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.header ?? '',
                  style: AppTextStyle.arsenal22LightBold,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.beige10,
            border: Border.all(width: 2, color: AppColors.beige),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: widget.isExpanded ?? false,
                trailing: widget.isExpanded ?? false
                    ? const Icon(
                        Icons.arrow_upward,
                        color: AppColors.light,
                        size: 19,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        color: AppColors.light,
                        size: 19,
                      ),
                title: Text(
                  widget.title,
                  style: widget.titleStyle,
                ),
                children: <Widget>[
                  Container(
                    height: 1,
                    color: AppColors.beige,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 16, right: 20, bottom: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.body,
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() => widget.isExpanded = expanded);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpansionTileSubscribeCustomWidget extends StatefulWidget {
  bool? isExpanded;
  final String? header;
  final String title;
  final TextStyle titleStyle;
  // final String body;
  ExpansionTileSubscribeCustomWidget({
    Key? key,
    this.header,
    this.isExpanded = false,
    required this.title,
    required this.titleStyle,
    // required this.body,
  }) : super(key: key);

  @override
  State<ExpansionTileSubscribeCustomWidget> createState() =>
      _ExpansionTileSubscribeCustomWidgetState();
}

class _ExpansionTileSubscribeCustomWidgetState
    extends State<ExpansionTileSubscribeCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.header != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.header ?? '',
                  style: AppTextStyle.arsenal22LightBold,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.beige10,
            border: Border.all(width: 2, color: AppColors.beige),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: widget.isExpanded ?? false,
                trailing: widget.isExpanded ?? false
                    ? const Icon(
                        Icons.arrow_upward,
                        color: AppColors.light,
                        size: 19,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        color: AppColors.light,
                        size: 19,
                      ),
                title: Text(
                  widget.title,
                  style: widget.titleStyle,
                ),
                children: <Widget>[
                  Container(
                    height: 1,
                    color: AppColors.beige,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 16, right: 20, bottom: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.toAccess,
                            style: AppTextStyle.playfairDisplay19Beige,
                          ),
                          gapH16,
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  // foregroundColor: AppColors.beige,
                                  backgroundColor: Colors.transparent,
                                ),
                                onPressed: () {
                                  context.pushNamed(AppPage.tariffs.toName);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .checkoutSubscription,
                                  style: const TextStyle(fontSize: 19),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() => widget.isExpanded = expanded);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpansionTileListCustomWidget extends StatefulWidget {
  bool? isExpanded;
  final String? header;
  final String title;
  final TextStyle titleStyle;
  final List<Widget> body;
  ExpansionTileListCustomWidget({
    Key? key,
    this.isExpanded,
    this.header,
    required this.title,
    required this.titleStyle,
    required this.body,
  }) : super(key: key);

  @override
  State<ExpansionTileListCustomWidget> createState() =>
      _ExpansionTileListCustomWidgetState();
}

class _ExpansionTileListCustomWidgetState
    extends State<ExpansionTileListCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.header != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.header ?? '',
                  style: AppTextStyle.arsenal22LightBold,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.beige10,
            border: Border.all(width: 2, color: AppColors.beige),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                initiallyExpanded: widget.isExpanded ?? false,
                trailing: widget.isExpanded ?? false
                    ? const Icon(
                        Icons.arrow_upward,
                        color: AppColors.light,
                        size: 19,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        color: AppColors.light,
                        size: 19,
                      ),
                title: Text(
                  widget.title,
                  style: widget.titleStyle,
                ),
                children: <Widget>[
                  Container(
                    height: 1,
                    color: AppColors.beige,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.body,
                  )

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 24.0, top: 16, right: 20, bottom: 16),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       widget.body,
                  //       style: AppTextStyle.arsenal16Light,
                  //     ),
                  //   ),
                  // ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() => widget.isExpanded = expanded);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
