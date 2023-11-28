import 'package:go_router/go_router.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenSize(context).width;
    double screenHeight = ScreenSize(context).height;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/stars_patern.png"),
            fit: isLandscape ? BoxFit.fitWidth : BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding: ConstantSize.screenPadding,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: isLandscape ? screenWidth * 0.15 : screenWidth * 0.1,
                  top: isLandscape ? screenHeight * 0.1 : screenHeight * 0.18,
                  right: isLandscape ? screenWidth * 0.15 : screenWidth * 0.1,
                ),
                child: Image.asset('assets/images/saturn_logo.png'),
              ),
              SizedBox(
                  height:
                      isLandscape ? screenHeight * 0.15 : screenHeight * 0.21),
              ElevatedButton(
                onPressed: () {
                  // print(repList);
                  GoRouter.of(context).goNamed(AppPage.signIn.toName);
                },
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                ),
              ),
              SizedBox(height: isLandscape ? 30 : 40),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(AppPage.signUp.toName);
                },
                child: Text(AppLocalizations.of(context)!.signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
