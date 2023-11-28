import 'package:flutter/material.dart';
import 'package:saturn/config/app_text_style.dart';

class StringHighlighterBold {
  RichText arsenal16pxHighlighter(String text) {
    List<TextSpan> textSpans = [];

    RegExp exp = RegExp("<b>(.*?)</b>");
    Iterable<Match> matches = exp.allMatches(text);
    int start = 0;

    for (Match match in matches) {
      if (match.start > start) {
        textSpans.add(
          TextSpan(
              text: text.substring(start, match.start),
              style: AppTextStyle.arsenal16Light),
        );
      }
      textSpans.add(TextSpan(
          text: match.group(1), style: AppTextStyle.arsenal16BeigeBold));
      start = match.end;
    }

    if (start < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(start),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}

class StringHighlighterSpan {
  RichText arsenal16pxHighlighter(String text) {
    List<TextSpan> textSpans = [];

    RegExp exp = RegExp("<span>(.*?)</span>");
    Iterable<Match> matches = exp.allMatches(text);
    int start = 0;

    for (Match match in matches) {
      if (match.start > start) {
        textSpans.add(
          TextSpan(
              text: text.substring(start, match.start),
              style: AppTextStyle.arsenal16Light),
        );
      }
      textSpans.add(TextSpan(
          text: match.group(1), style: AppTextStyle.arsenal16BeigeBold));
      start = match.end;
    }

    if (start < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(start),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
