// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/utils/url_launcher.dart';
import 'package:saturn/bloc/edit_user_data_bloc.dart';
import 'package:saturn/presentation/widgets/dialog_widget.dart';
import 'package:http/http.dart' as http;
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/utils/logger.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _timeController = TextEditingController();
TextEditingController _localityController = TextEditingController();

bool _timeVisibility = true;
Map<String, dynamic> _localityMap = {};
String _name = '';
String _dateOfBirth = '';
String _timeOfBirth = '';

void _timeVisibilityToggle() {
  _timeVisibility = !_timeVisibility;
}

class UserInputDataScreen extends StatelessWidget {
  const UserInputDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.editData;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        title: Text(title, maxLines: 4),
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              _UserInputDataName(),
              SizedBox(height: 26),
              _UserInputDataDateAndTime(),
              _UserInputDataPlace(),
              SizedBox(height: 31),
              _UserInputDataSubmitButton(),
              SizedBox(height: 16),
              _UserInputDataEmailLink(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInputDataName extends StatelessWidget {
  const _UserInputDataName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        if (state is EditUserModelLoaded) {
          _nameController.text = state.reportItem.source?.title ?? '';
          _name = state.reportItem.source?.title ?? '';
          _timeVisibility =
              state.reportItem.source?.timelite == '1' ? true : false;
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
                  controller: _nameController,
                  onChanged: (value) {
                    _name = value;
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _UserInputDataDateAndTime extends StatefulWidget {
  const _UserInputDataDateAndTime();

  @override
  State<_UserInputDataDateAndTime> createState() =>
      _UserInputDataDateAndTimeState();
}

class _UserInputDataDateAndTimeState extends State<_UserInputDataDateAndTime> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        if (state is EditUserModelLoaded) {
          _dateController.text = DateFormat('dd-MM-yyyy')
              .format(state.reportItem.source?.datar ?? DateTime(0000, 00, 00));
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dateOfBirth,
                          style: AppTextStyle.arsenal16Light,
                        ),
                        const SizedBox(height: 12),
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
                                  ),
                            controller: _dateController,
                            readOnly: true,
                            onTap: () async {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  _timeVisibility
                      ? const _UserInputDataTime()
                      : const SizedBox.shrink(),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      left: 0,
                      top: 8,
                      right: 25,
                      bottom: 8,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
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
        return Container();
      },
    );
  }
}

class _UserInputDataTime extends StatefulWidget {
  const _UserInputDataTime();

  @override
  State<_UserInputDataTime> createState() => _UserInputDataTimeState();
}

class _UserInputDataTimeState extends State<_UserInputDataTime> {
  String getTimeString(TimeOfDay time) {
    final format = DateFormat('HH:mm');
    final dateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, time.hour, time.minute);
    return format.format(dateTime);
  }

  final time = '';

  @override
  void initState() {
    final model = context.read<EditUserBloc>();
    _timeController.text = model.reportItem.source?.timer ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(builder: (context, state) {
      if (state is EditUserModelLoaded) {
        return Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.timeOfBirth,
                      style: AppTextStyle.arsenal16Light,
                    ),
                  ),
                  gapW16,
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => ShowDialogWidget(
                          dialogText: Text(
                            AppLocalizations.of(context)!.dontKnowTime,
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
                ],
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
                      initialTime: const TimeOfDay(hour: 12, minute: 00),
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
                      logger.i("Time is not selected");
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class _UserInputDataPlace extends StatefulWidget {
  const _UserInputDataPlace({Key? key}) : super(key: key);

  @override
  State<_UserInputDataPlace> createState() => _UserInputDataPlaceState();
}

class _UserInputDataPlaceState extends State<_UserInputDataPlace> {
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
    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        if (state is EditUserModelLoaded) {
          _localityController.text = state.reportItem.source?.city ?? '';
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
                  onTap: () => _localityController.clear(),
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
        return Container();
      },
    );
  }
}

class _UserInputDataSubmitButton extends StatelessWidget {
  const _UserInputDataSubmitButton({
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

    late String reportId;

    return BlocListener<EditUserBloc, EditUserState>(
      listener: (context, state) {
        if (state is EditUserApiStatusOk) {
          BlocProvider.of<CacheManagerCubit>(context).cacheReportsList();
          BlocProvider.of<CacheManagerCubit>(context)
              .cacheSingleReport(int.parse(reportId));
          context.goNamed(AppPage.loader.toName);
        }
      },
      child: BlocBuilder<EditUserBloc, EditUserState>(
        builder: (context, state) {
          if (state is EditUserModelLoaded) {
            reportId = state.reportItem.source!.id ?? '';
            return ElevatedButton(
              onPressed: () async {
                final String time =
                    _timeOfBirth == '' ? '00:00:00' : '$_timeOfBirth:00';
                final dynamic city = _localityMap['locality_name'] == null
                    ? null
                    : '${_localityMap['locality_name']}, ${_localityMap['region']}, ${_localityMap['country']}';
                final dynamic date = _dateOfBirth == '' ? null : _dateOfBirth;

                if (checkFormNotEmpty()) {
                  BlocProvider.of<EditUserBloc>(context).add(EditUserData(
                    title: _name,
                    datar: date,
                    timer: time,
                    city: city,
                    dl: _localityMap['longitude'],
                    sh: _localityMap['latitude'],
                    p: _localityMap['timezone'],
                    timelite: _timeVisibility == true ? 1 : 0,
                  ));
                }
              },
              child: Text(
                AppLocalizations.of(context)!.save,
                style: AppTextStyle.arsenal16LightBold,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _UserInputDataEmailLink extends StatelessWidget {
  const _UserInputDataEmailLink();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.contactsQuestionsSuggestions,
        children: [
          TextSpan(
            text: ' support@saturn.love',
            style: AppTextStyle.arsenal16Light
                .copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => UrlLauncher().sendEmail('support@saturn.love'),
          ),
        ],
        style: AppTextStyle.arsenal16Light,
      ),
    );
  }
}
