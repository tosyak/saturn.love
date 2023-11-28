import 'package:go_router/go_router.dart';
import 'package:saturn/presentation/about_jyotish_screen/about_jyotish_screen.dart';
import 'package:saturn/presentation/auth_screen/auth_reset_login_screen.dart';
import 'package:saturn/presentation/auth_screen/auth_reset_pass_screen.dart';
import 'package:saturn/presentation/auth_screen/auth_selection_screen.dart';
import 'package:saturn/presentation/auth_screen/auth_sign_in_screen.dart';
import 'package:saturn/presentation/auth_screen/auth_sign_up_screen.dart';
import 'package:saturn/presentation/get_report_form_screen/get_report_form_screen.dart';
import 'package:saturn/presentation/loader_screen/loader_screen.dart';
import 'package:saturn/presentation/main_screen/moon_screen/about_moon_screen.dart';
import 'package:saturn/presentation/main_screen/moon_screen/moon_screen.dart';
import 'package:saturn/presentation/main_screen/main_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/about_love_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/about_moon_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/area_of_life_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/nakshatras_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/planets_in_houses_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/report_screen.dart';
import 'package:saturn/presentation/edit_user_data_screen/edit_user_data_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/working_methods_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/yogi_screen.dart';
import 'package:saturn/presentation/main_screen/report_screen/your_ascendant_screen.dart';
import 'package:saturn/presentation/main_screen/sade_sati_screen/about_sade_sati_screen.dart';
import 'package:saturn/presentation/main_screen/sade_sati_screen/sade_satie_screen.dart';
import 'package:saturn/presentation/main_screen/transits_screen/about_transits_screen.dart';
import 'package:saturn/presentation/main_screen/transits_screen/transits_screen.dart';
import 'package:flutter/material.dart';
import 'package:saturn/presentation/my_account_group/my_account_screen.dart';
import 'package:saturn/presentation/my_account_group/reports_list_screen.dart';
import 'package:saturn/presentation/my_account_group/subscription_screen.dart';
import 'package:saturn/presentation/my_account_group/tariffs_screen.dart';
import 'package:saturn/presentation/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    //
    //Splash
    //
    routes: <RouteBase>[
      GoRoute(
        path: AppPage.splash.toPath,
        name: AppPage.splash.toName,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppPage.loader.toPath,
        name: AppPage.loader.toName,
        builder: (context, state) => const LoaderScreen(),
      ),
      //
      // Login
      //
      GoRoute(
        path: AppPage.loginSelect.toPath,
        name: AppPage.loginSelect.toName,
        builder: (context, state) => const AuthSelectionScreen(),
        routes: [
          GoRoute(
            path: AppPage.signIn.toPath,
            name: AppPage.signIn.toName,
            builder: (context, state) => const SignInScreen(),
            routes: [
              GoRoute(
                path: AppPage.resetLogin.toPath,
                name: AppPage.resetLogin.toName,
                builder: (context, state) => const ResetLoginScreen(),
              ),
              GoRoute(
                path: AppPage.resetPass.toPath,
                name: AppPage.resetPass.toName,
                builder: (context, state) => const ResetPasswordScreen(),
              ),
            ],
          ),
          GoRoute(
            path: AppPage.signUp.toPath,
            name: AppPage.signUp.toName,
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
      //
      // Get Report form
      //
      GoRoute(
        path: AppPage.getReportForm.toPath,
        name: AppPage.getReportForm.toName,
        builder: (context, state) => const GetReportFormScreen(),
        routes: [
          GoRoute(
            path: AppPage.aboutJyotish.toPath,
            name: AppPage.aboutJyotish.toName,
            builder: (context, state) => const AboutJyotishScreen(),
          ),
        ],
      ),

      //
      // Reports List
      //

      GoRoute(
        path: AppPage.reportsList.toPath,
        name: AppPage.reportsList.toName,
        builder: (context, state) => const ReportsListScreen(),
      ),

      GoRoute(
          path: AppPage.myAccount.toPath,
          name: AppPage.myAccount.toName,
          builder: (context, state) => const MyAccountScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: AppPage.myAccountReportForm.toPath,
              name: AppPage.myAccountReportForm.toName,
              builder: (context, state) => const GetReportFormScreen(),
            ),
            GoRoute(
              path: AppPage.subscription.toPath,
              name: AppPage.subscription.toName,
              builder: (context, state) => const SubscriptionScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: AppPage.tariffs.toPath,
                  name: AppPage.tariffs.toName,
                  builder: (context, state) => const TariffsScreen(),
                ),
              ],
            ),
          ]),

      //
      // Bottom Nav Bar
      //
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainScreen(child: child);
        },
        routes: <RouteBase>[
          //
          // Report Screen
          //
          GoRoute(
            path: AppPage.reportScreen.toPath,
            name: AppPage.reportScreen.toName,
            builder: (context, state) => const ReportScreen(),
            routes: <RouteBase>[
              //
              //  User Data
              //
              GoRoute(
                path: AppPage.userInputData.toPath,
                name: AppPage.userInputData.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const UserInputDataScreen();
                },
              ),
              GoRoute(
                path: AppPage.yourAscendant.toPath,
                name: AppPage.yourAscendant.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const YourAscendantScreen();
                },
              ),
              GoRoute(
                path: AppPage.aboutMoon.toPath,
                name: AppPage.aboutMoon.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutMoonScreen();
                },
              ),
              GoRoute(
                path: AppPage.workingMethods.toPath,
                name: AppPage.workingMethods.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const WorkingMethodsScreen();
                },
              ),
              GoRoute(
                path: AppPage.yogi.toPath,
                name: AppPage.yogi.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const YogiScreen();
                },
              ),
              GoRoute(
                path: AppPage.areaOfLife.toPath,
                name: AppPage.areaOfLife.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const AreaOfLifeScreen();
                },
              ),
              GoRoute(
                path: AppPage.aboutLove.toPath,
                name: AppPage.aboutLove.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutLoveScreen();
                },
              ),
              GoRoute(
                path: AppPage.planetsInHouses.toPath,
                name: AppPage.planetsInHouses.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const PlanetsInHousesScreen();
                },
              ),
              GoRoute(
                path: AppPage.nakshatras.toPath,
                name: AppPage.nakshatras.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const DegreesAndNakshatrasScreen();
                },
              ),
            ],
          ),

          //
          // Transite screen
          //

          GoRoute(
            path: AppPage.transits.toPath,
            name: AppPage.transits.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const TransitsScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.aboutTransits.toPath,
                name: AppPage.aboutTransits.toName,
                // parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutTransitsScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: AppPage.lunarCalendar.toPath,
            name: AppPage.lunarCalendar.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const MoonScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.aboutLunarCalendar.toPath,
                name: AppPage.aboutLunarCalendar.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutLunarCalendarScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: AppPage.sadeSatie.toPath,
            name: AppPage.sadeSatie.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const SadeSatieScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.aboutSadeSatie.toPath,
                name: AppPage.aboutSadeSatie.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const AboutSadeSatiScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

enum AppPage {
  splash,
  loader,
  loginSelect,
  signIn,
  resetPass,
  resetLogin,
  signUp,
  getReportForm,
  aboutJyotish,
  myAccount,
  myAccountReportForm,
  reportsList,
  subscription,
  tariffs,
  subscriptionPro,
  submitSubscription,
  aboutUs,
  support,
  cancelSubscription,
  refund,
  paymentAndRefund,
  offer,
  privacyPolicy,
  subscriptionAgreement,
  reportScreen,
  userInputData,
  yourAscendant,
  aboutMoon,
  workingMethods,
  yogi,
  areaOfLife,
  aboutLove,
  planetsInHouses,
  sadeSatiePeriods,
  nakshatras,
  transits,
  aboutTransits,
  lunarCalendar,
  aboutLunarCalendar,
  sadeSatie,
  aboutSadeSatie
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.splash:
        return "/";
      case AppPage.loader:
        return "/loader";
      case AppPage.loginSelect:
        return "/loginSelect";
      case AppPage.signIn:
        return "signIn";
      case AppPage.resetPass:
        return "forgotPass";
      case AppPage.resetLogin:
        return "forgotLogin";
      case AppPage.signUp:
        return "signUp";
      case AppPage.getReportForm:
        return "/getReportForm";
      case AppPage.aboutJyotish:
        return "aboutJyotish";
      case AppPage.myAccount:
        return "/myAccount";
      case AppPage.myAccountReportForm:
        return "myAccountReportForm";
      case AppPage.reportsList:
        return "/reportsList";
      case AppPage.subscription:
        return "subscription";
      case AppPage.tariffs:
        return "tariffs";
      case AppPage.subscriptionPro:
        return "subscriptionPro";
      case AppPage.submitSubscription:
        return "submitSubscription";
      case AppPage.aboutUs:
        return "aboutUs";
      case AppPage.support:
        return "support";
      case AppPage.cancelSubscription:
        return "cancelSubscription";
      case AppPage.refund:
        return "refund";
      case AppPage.paymentAndRefund:
        return "paymentAndRefund/";
      case AppPage.offer:
        return "/offer";
      case AppPage.privacyPolicy:
        return "/privacyPolicy";
      case AppPage.subscriptionAgreement:
        return "/subscriptionAgreement";
      case AppPage.reportScreen:
        return "/report";
      case AppPage.userInputData:
        return "editUserData";
      case AppPage.yourAscendant:
        return "yourAscendant";
      case AppPage.aboutMoon:
        return "aboutMoon";
      case AppPage.workingMethods:
        return "workingMethods";
      case AppPage.yogi:
        return "yogi";
      case AppPage.areaOfLife:
        return "areaOfLife";
      case AppPage.aboutLove:
        return "aboutLove";
      case AppPage.planetsInHouses:
        return "planetsInHousesplanetsInHouses";
      case AppPage.sadeSatiePeriods:
        return "sadeSatiePeriods";
      case AppPage.nakshatras:
        return "nakshatras";
      case AppPage.transits:
        return "/transits";
      case AppPage.aboutTransits:
        return "aboutTransits";
      case AppPage.lunarCalendar:
        return "/lunarCalendar";
      case AppPage.aboutLunarCalendar:
        return "aboutLunarCalendar";
      case AppPage.sadeSatie:
        return "/sadeSatie";
      case AppPage.aboutSadeSatie:
        return "aboutSadeSatie";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.splash:
        return "/splash";
      case AppPage.loader:
        return "/loader";
      case AppPage.signIn:
        return "signIn";
      case AppPage.resetPass:
        return "forgotPass";
      case AppPage.resetLogin:
        return "forgotLogin";
      case AppPage.signUp:
        return "signUp";
      case AppPage.getReportForm:
        return "/getReportForm";
      case AppPage.aboutJyotish:
        return "aboutJyotish";
      case AppPage.myAccount:
        return "/myAccount";
      case AppPage.myAccountReportForm:
        return "myAccountReportForm";
      case AppPage.reportsList:
        return "/reportsList";
      case AppPage.subscription:
        return "subscription";
      case AppPage.tariffs:
        return "tariffs";
      case AppPage.subscriptionPro:
        return "subscriptionPro";
      case AppPage.submitSubscription:
        return "submitSubscription";
      case AppPage.aboutUs:
        return "aboutUs";
      case AppPage.support:
        return "support";
      case AppPage.cancelSubscription:
        return "cancelSubscription";
      case AppPage.refund:
        return "refund";
      case AppPage.paymentAndRefund:
        return "paymentAndRefund/";
      case AppPage.offer:
        return "offer";
      case AppPage.privacyPolicy:
        return "privacyPolicy";
      case AppPage.subscriptionAgreement:
        return "subscriptionAgreement";
      case AppPage.reportScreen:
        return "/report";
      case AppPage.userInputData:
        return "editUserData";
      case AppPage.yourAscendant:
        return "yourAscendant";
      case AppPage.aboutMoon:
        return "aboutMoon";
      case AppPage.workingMethods:
        return "workingMethods";
      case AppPage.yogi:
        return "yogi";
      case AppPage.areaOfLife:
        return "areaOfLife";
      case AppPage.aboutLove:
        return "aboutLove";
      case AppPage.planetsInHouses:
        return "planetsInHousesplanetsInHouses";
      case AppPage.sadeSatiePeriods:
        return "sadeSatiePeriods";
      case AppPage.nakshatras:
        return "nakshatras";
      case AppPage.transits:
        return "/transits";
      case AppPage.aboutTransits:
        return "aboutTransits";
      case AppPage.lunarCalendar:
        return "/lunarCalendar";
      case AppPage.aboutLunarCalendar:
        return "aboutLunarCalendar";
      case AppPage.sadeSatie:
        return "/sadeSatie";
      case AppPage.aboutSadeSatie:
        return "aboutSadeSatie";
      default:
        return "splash";
    }
  }
}
