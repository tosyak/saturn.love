// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restart_app/restart_app.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/data/repository/image_cache_manager.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/my_account_group/about_us_screen.dart';
import 'package:saturn/presentation/my_account_group/support_screen.dart';
import 'package:saturn/presentation/my_account_group/tariffs_screen.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/reports_list_screen_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.myAccount;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);

    void restartApp(BuildContext context) {
      if (Platform.isAndroid) {
        Restart.restartApp();
      } else {
        Phoenix.rebirth(context);
      }
    }

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/auth_background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  bool networkIsConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!networkIsConnected) {
                    showSnackBarWidget(
                        AppLocalizations.of(context)!.checkNetwork, context);
                  } else {
                    context.pushNamed(AppPage.getReportForm.toName);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.getReport,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              TextButton(
                onPressed: () async {
                  BlocProvider.of<ReportsListBloc>(context)
                      .add(GetReportsList());
                  context.pushNamed(AppPage.reportsList.toName);
                },
                child: Text(
                  AppLocalizations.of(context)!.myReports,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TariffsScreen()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.subscription,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     AppLocalizations.of(context)!.consultation,
              //     style: AppTextStyle.arsenal22Light,
              //   ),
              // ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     AppLocalizations.of(context)!.blog,
              //     style: AppTextStyle.arsenal22Light,
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAccountAboutUsScreen(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.aboutUs,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyAccountSupportScreen(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.support,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await UserSharedPreferences().removeUserId();
                  await UserSharedPreferences().removeUserData();
                  await SvgImageCacheManager().clearCache();
                  await deleteHiveBoxes();
                  restartApp(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.signOut,
                  style: AppTextStyle.arsenal22Light,
                ),
              ),
              gapH12,
              const AccountInfoWidget(),

              gapH16,

              // TextButton(
              //   onPressed: () async {
              //     LoginLinkLauncher()
              //         .fetchResourcesListApi(LinkType.cancelSubscription);
              //     // Model().fetchResourcesListApi();
              //   },
              //   child: const Text(
              //     'Go to Saturn',
              //     style: AppTextStyle.arsenal22Light,
              //   ),
              // ),
              // const _MyAccountSocialLinks(),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  String userName = '';
  String userEmail = '';
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  getUserData() async {
    final userSharedPrefs = UserSharedPreferences();
    final userData = await userSharedPrefs.getUserData();

    setState(() {
      userName = userData?[0] ?? '';
      userEmail = userData?[1] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedCardListWidget(
      cardTitle: AppLocalizations.of(context)!.yourAccount,
      stringsList: [
        '${AppLocalizations.of(context)!.login}: $userName',
        'Email: $userEmail'
      ],
    );
  }
}

// class _MyAccountSocialLinks extends StatelessWidget {
//   const _MyAccountSocialLinks();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () {},
//           icon: const ImageIcon(
//             AssetImage('assets/images/vk_link_icon.png'),
//             color: AppColors.beige,
//             size: 45,
//           ),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: const ImageIcon(
//             AssetImage('assets/images/tg_link_icon.png'),
//             color: AppColors.beige,
//             size: 27,
//           ),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: const ImageIcon(
//             AssetImage('assets/images/you_tube_link_icon.png'),
//             color: AppColors.beige,
//             size: 45,
//           ),
//         )
//       ],
//     );
//   }
// }

// class SiteLoginRepository {
//   BaseApiServices apiServices = NetworkApiService();
//   Future<Map<String, dynamic>> moonListApi() async {
//     final int? userId = await UserSharedPrefs().getUserId();
//     final moonRequestMap = {
//       "user_id": userId,
//       "count": 999,
//       "period": "P10DT3H"
//     };
//     dynamic response = await apiServices.getApiResponse(
//         'https://saturn.love/telegram.html?act=get_token', moonRequestMap);
//     try {
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// class MyAccountViewModel extends ChangeNotifier {
//   String userName = '';
//   String userEmail = '';

//   // void getUserData() async {
//   //   var userSharedPrefs = UserSharedPrefs();
//   //   var userData = await userSharedPrefs.getUserData();
//   //   userName = userData?[0] ?? '';
//   //   userEmail = userData?[1] ?? '';
//   // }

//   bool _previousRouteReport = false;
//   bool get previousRouteReport => _previousRouteReport;
//   void setPreviousRouteReport(bool previousRouteReport) {
//     _previousRouteReport = previousRouteReport;
//     notifyListeners();
//   }

//   bool _previousRouteMoon = false;
//   bool get previousRouteMoon => _previousRouteMoon;
//   void setPreviousRouteMoon(bool previousRouteMoon) {
//     _previousRouteMoon = previousRouteMoon;
//     notifyListeners();
//   }

//   bool _previousRouteTransite = false;
//   bool get previousRouteTransite => _previousRouteTransite;
//   void setPreviousRouteTransite(bool previousRouteTransite) {
//     _previousRouteTransite = previousRouteTransite;
//     notifyListeners();
//   }

//   bool _previousRouteSadi = false;
//   bool get previousRouteSadi => _previousRouteSadi;
//   void setPreviousRouteSadi(bool previousRouteSadi) {
//     _previousRouteSadi = previousRouteSadi;
//     notifyListeners();
//   }

//   // void resetRoute() {
//   //   setPreviousRouteMoon(false);
//   //   setPreviousRouteReport(false);
//   //   setPreviousRouteSadi(false);
//   //   setPreviousRouteTransite(false);
//   // }
// }

// class Model extends ChangeNotifier {
//   final repository = SiteLoginRepository();
//   ApiResponse<Map<String, dynamic>> listResponse = ApiResponse.loading();

//   bool _previousRoute = false;
//   bool get previousRoute => _previousRoute;
//   void setPreviousRoute(bool previousRoute) {
//     print(previousRoute);
//     _previousRoute = previousRoute;
//     notifyListeners();
//   }

//   makeMoonReport(
//     ApiResponse<Map<String, dynamic>> response,
//   ) async {
//     listResponse = response;
//     print(listResponse);
//     if (listResponse.data != null) {}
//   }

//   Future<void> fetchResourcesListApi() async {
//     await makeMoonReport(ApiResponse.loading());
//     await repository.moonListApi().then((value) {
//       makeMoonReport(
//         ApiResponse.completed(value),
//       );
//     }).onError((error, stackTrace) {
//       if (kDebugMode) {
//         makeMoonReport(ApiResponse.error(error.toString()));
//         print(error);
//       }
//     });
//   }
// }
