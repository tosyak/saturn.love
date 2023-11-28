// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saturn/bloc/main_screen_bloc.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:saturn/bloc/get_report_screen_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:saturn/utils/logger.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _timeController = TextEditingController();
final TextEditingController _localityController = TextEditingController();

bool _timeVisibility = true;
Map<String, dynamic> _localityMap = {};
String _name = '';
String _dateOfBirth = '';
String _timeOfBirth = '';

resetFields() {
  _nameController.text = '';
  _dateController.text = '';
  _timeController.text = '';
  _localityController.text = '';

  _timeVisibility = true;
  _localityMap = {};
  _name = '';
  _dateOfBirth = '';
  _timeOfBirth = '';
}

void _timeVisibilityToggle() {
  _timeVisibility = !_timeVisibility;
}

class GetReportFormScreen extends StatelessWidget {
  const GetReportFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.jyotishIs;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateHeight(),
        title: Text(
          title,
          maxLines: 4,
        ),
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
                AppLocalizations.of(context)!.enterDate,
                style: AppTextStyle.arsenal22Light,
              ),
              const SizedBox(height: 26),
              const _GetReportName(),
              const SizedBox(height: 26),
              const _GetReportDateAndTime(),
              const _GetReportPlace(),
              const SizedBox(height: 31),
              const _GetReportSubmitButton(),
              const SizedBox(height: 31),
              const _GetReportThesis(),
              const SizedBox(height: 24),
              const _JyotishInfoButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

class _GetReportName extends StatelessWidget {
  const _GetReportName({Key? key}) : super(key: key);

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
            onChanged: (value) {
              _nameController.text = value;
              _name = value;
            },
          ),
        ),
      ],
    );
  }
}

class _GetReportDateAndTime extends StatefulWidget {
  const _GetReportDateAndTime();

  @override
  State<_GetReportDateAndTime> createState() => _GetReportDateAndTimeState();
}

class _GetReportDateAndTimeState extends State<_GetReportDateAndTime> {
  @override
  void initState() {
    super.initState();
    resetFields();
  }

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
                            _dateOfBirth = formattedDate;
                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          } else {
                            logger.i("Date is not selected");
                          }
                          //when click we have to show the datepicker
                        }),
                  ),
                ],
              ),
            ),
            _timeVisibility ? const _GetReportTime() : const SizedBox.shrink(),
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

class _GetReportTime extends StatefulWidget {
  const _GetReportTime();

  @override
  State<_GetReportTime> createState() => _GetReportTimeState();
}

class _GetReportTimeState extends State<_GetReportTime> {
  String getTimeString(TimeOfDay time) {
    final format = DateFormat('HH:mm');
    final dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, time.hour, time.minute);
    return format.format(dateTime);
  }

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
                  final pickTimeFormatted = pickTime.format(context);

                  _timeOfBirth = getTimeString(pickTime);
                  setState(() {
                    _timeController.text = pickTimeFormatted;
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

class _GetReportPlace extends StatefulWidget {
  const _GetReportPlace({Key? key}) : super(key: key);

  @override
  State<_GetReportPlace> createState() => _GetReportPlaceState();
}

class _GetReportPlaceState extends State<_GetReportPlace> {
  Future<List<dynamic>> getLocality(String nameStartsWith) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final url = Uri.parse('https://geo.holos.house/api/get-locality');
    const key = 'gOFmRUZ2A1ceP819cCPAXZhOQ7C8kgrF';

    final data = {
      'key': key,
      'lang': languageCode,
      'city': nameStartsWith,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      body: json.encode(data),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseApi = json.decode(response.body);
      final List<dynamic> result = responseApi['data'];

      return result;
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

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
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _localityController,
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length > 2) {
              return await getLocality(pattern);
            } else {
              return [];
            }
          },
          noItemsFoundBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                AppLocalizations.of(context)!.cityNoFound,
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(
                  '${suggestion['locality_name']}, ${suggestion['region']}, ${suggestion['country']}'),
            );
          },
          onSuggestionSelected: (suggestion) {
            _localityController.text =
                '${suggestion['locality_name']}, ${suggestion['region']}, ${suggestion['country']}';
            _localityMap = suggestion;
          },
        ),
      ],
    );
  }
}

class _GetReportSubmitButton extends StatelessWidget {
  const _GetReportSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkFormNotEmpty() {
      if (_timeVisibility) {
        if (_nameController.text != '' &&
            _timeController.text != '' &&
            _dateController.text != '' &&
            _localityController.text != '') {
          return true;
        } else {
          showSnackBarWidget(
              AppLocalizations.of(context)!.fillAllFields, context);
          return false;
        }
      } else {
        if (_nameController.text != '' &&
            _dateController.text != '' &&
            _localityController.text != '') {
          return true;
        } else {
          showSnackBarWidget(
              AppLocalizations.of(context)!.fillAllFields, context);
          return false;
        }
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<GetReportBloc, GetReportState>(
          listener: (context, state) {
            if (state is GetReportLoaded) {
              final reportId = state.reportId;
              BlocProvider.of<CacheManagerCubit>(context).cacheReportsList();
              BlocProvider.of<CacheManagerCubit>(context)
                  .cacheSingleReport(reportId);
              context.goNamed(AppPage.loader.toName);
              BlocProvider.of<MainScreenBloc>(context)
                  .add(const SetTabIndex(0));
            } else if (state is GetReportAvailable) {
              final reportId = int.tryParse(state.reportId);
              BlocProvider.of<ReportScreenBloc>(context)
                  .add(GetReportItem(reportId!));
              context.goNamed(AppPage.reportScreen.toName);
              BlocProvider.of<MainScreenBloc>(context)
                  .add(const SetTabIndex(0));
            }
          },
        ),
      ],
      child: ElevatedButton(
        onPressed: () async {
          final time = _timeOfBirth == '' ? '00:00:00' : '$_timeOfBirth:00';
          if (checkFormNotEmpty()) {
            BlocProvider.of<GetReportBloc>(context).add(GetReportRequest(
                name: _name,
                datetime: '$_dateOfBirth $time',
                timelite: _timeVisibility == true ? 1 : 0,
                city: _localityMap['locality_name'],
                timezone: _localityMap['timezone'],
                offset: _localityMap['offset'],
                lat: _localityMap['latitude'],
                lng: _localityMap['longitude'],
                transite: 1,
                moon: 1));
          }
        },
        child: Text(
          AppLocalizations.of(context)!.calculate,
          style: AppTextStyle.arsenal16LightBold,
        ),
        // ),
      ),
    );
  }
}

class _GetReportThesis extends StatelessWidget {
  const _GetReportThesis();

  @override
  Widget build(BuildContext context) {
    List learnThesisList = [
      AppLocalizations.of(context)!.calculationDefinition1,
      AppLocalizations.of(context)!.calculationDefinition2,
      AppLocalizations.of(context)!.calculationDefinition3,
      AppLocalizations.of(context)!.calculationDefinition4,
      AppLocalizations.of(context)!.calculationDefinition5,
      AppLocalizations.of(context)!.calculationDefinition6,
      AppLocalizations.of(context)!.calculationDefinition7,
      AppLocalizations.of(context)!.calculationDefinition8,
      AppLocalizations.of(context)!.calculationDefinition9,
      AppLocalizations.of(context)!.calculationDefinition10,
      AppLocalizations.of(context)!.calculationDefinition11,
      AppLocalizations.of(context)!.calculationDefinition12,
      AppLocalizations.of(context)!.calculationDefinition13,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.whatYouWillLearn,
          style: AppTextStyle.arsenal22Light,
        ),
        const SizedBox(height: 16),
        Column(
          children: learnThesisList
              .map(
                (learnThesisListElement) => Padding(
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
                      Expanded(
                        child: Text(
                          learnThesisListElement,
                          style: AppTextStyle.arsenal14Light,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _JyotishInfoButton extends StatelessWidget {
  const _JyotishInfoButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        GoRouter.of(context).goNamed(AppPage.aboutJyotish.toName);
      },
      child: Text(
        AppLocalizations.of(context)!.whatIsJyotish,
        style: AppTextStyle.arsenal16LightBold,
      ),
    );
  }
}
