// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/presentation/my_account_group/reports_list_screen.dart';
import 'package:saturn/utils/logger.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _timeController = TextEditingController();

bool _timeVisibility = true;

void _timeVisibilityToggle() {
  _timeVisibility = !_timeVisibility;
}

class MyAccountReportFormScreen extends StatelessWidget {
  const MyAccountReportFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.personalMapCalc;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(title, maxLines: 4),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.fieldsRequired,
                style: AppTextStyle.arsenal24LightBold,
              ),
              gapH16,
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.listOfCalcs,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.listOfCalcsLink,
                      style: AppTextStyle.arsenal22Light
                          .copyWith(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ReportsListScreen(),
                              ),
                            ),
                    ),
                  ],
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              const SizedBox(height: 26),
              const _ReportFormName(),
              const SizedBox(height: 26),
              const _ReportFormDateAndTime(),
              const _ReportFormPlace(),
              const SizedBox(height: 31),
              const _ReportFormSubmitButton(),
              const SizedBox(height: 31),
              const _ReportFormInstruction(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportFormName extends StatelessWidget {
  const _ReportFormName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.name,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _nameController.text = value,
            // controller: emailController,
          ),
        ),
      ],
    );
  }
}

class _ReportFormDateAndTime extends StatefulWidget {
  const _ReportFormDateAndTime();

  @override
  State<_ReportFormDateAndTime> createState() => _ReportFormDateAndTimeState();
}

class _ReportFormDateAndTimeState extends State<_ReportFormDateAndTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dateOfBirth,
                    style: AppTextStyle.arsenal16Light,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: ConstantSize.textFieldHeight,
                    child: TextFormField(
                        decoration: _timeVisibility
                            ? const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColors.beige),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: AppColors.beige),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                              )
                            : InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: AppColors.beige),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: AppColors.beige),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    dialogBackgroundColor: AppColors.dark,
                                    dialogTheme: DialogTheme(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                              width: 2,
                                              color: AppColors.beige)),
                                    ),
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.beige,
                                      onPrimary: AppColors.light,
                                      onSurface: AppColors.light,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1872),
                              lastDate: DateTime(2072));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          } else {
                            logger.i("Date is not selected");
                          }
                        }),
                  ),
                ],
              ),
            ),
            _timeVisibility ? const _ReportFormTime() : const SizedBox.shrink(),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () {
              _timeVisibilityToggle();
              setState(() {});
            },
            child: !_timeVisibility
                ? Text(
                    AppLocalizations.of(context)!.know,
                    style: AppTextStyle.arsenal12Light
                        .copyWith(decoration: TextDecoration.underline),
                  )
                : Text(
                    AppLocalizations.of(context)!.dontKnow,
                    style: AppTextStyle.arsenal12Light
                        .copyWith(decoration: TextDecoration.underline),
                  ),
          ),
        ),
      ],
    );
  }
}

class _ReportFormTime extends StatefulWidget {
  const _ReportFormTime();

  @override
  State<_ReportFormTime> createState() => _ReportFormTimeState();
}

class _ReportFormTimeState extends State<_ReportFormTime> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.timeOfBirth,
            style: AppTextStyle.arsenal16Light,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: ConstantSize.textFieldHeight,
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.beige),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColors.beige),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
              ),
              controller: _timeController,
              readOnly: true,
              onTap: () async {
                final TimeOfDay? pickTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 12, minute: 12),
                  initialEntryMode: TimePickerEntryMode.input,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child ?? Container(),
                    );
                  },
                );
                if (pickTime != null) {
                  final pickTimeFormated = pickTime.format(context);
                  setState(() {
                    _timeController.text = pickTimeFormated;
                  });
                } else {
                  logger.i("Date is not selected");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportFormPlace extends StatelessWidget {
  const _ReportFormPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.placeOfBirth,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _nameController.text = value,
          ),
        ),
      ],
    );
  }
}

class _ReportFormSubmitButton extends StatelessWidget {
  const _ReportFormSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {},
      child: Text(
        AppLocalizations.of(context)!.calculate,
        style: AppTextStyle.arsenal16LightBold,
      ),
    );
  }
}

class _ReportFormInstruction extends StatelessWidget {
  const _ReportFormInstruction();

  @override
  Widget build(BuildContext context) {
    List learnThesisList = [
      AppLocalizations.of(context)!.fillInstruction0,
      AppLocalizations.of(context)!.fillInstruction1,
      AppLocalizations.of(context)!.fillInstruction2,
      AppLocalizations.of(context)!.fillInstruction3,
      AppLocalizations.of(context)!.fillInstruction4,
      AppLocalizations.of(context)!.contactsQuestionsSuggestions,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.fillInstruction,
          style: AppTextStyle.arsenal22Light,
        ),
        gapH16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: learnThesisList
              .map(
                (learnThesisListElement) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    learnThesisListElement,
                    style: AppTextStyle.arsenal14Light,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
