// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:saturn/config/app_colors.dart';

class ShowDialogWidget extends StatefulWidget {
  Text dialogText;
  RichText? richText;
  bool? redColor;
  ShowDialogWidget({
    Key? key,
    this.redColor,
    this.richText,
    required this.dialogText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShowDialogWidgetState();
}

class ShowDialogWidgetState extends State<ShowDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: widget.redColor == null ? AppColors.beige : Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(
              //   color: AppColors.beige,
              //   width: 3,
              // ),
            ),
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 27, bottom: 16),
                    child: SingleChildScrollView(
                      child: widget.richText ?? widget.dialogText,
                    )),
                Positioned(
                  top: -2,
                  right: -2,
                  child: IconButton(
                    splashRadius: 8,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    // padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
