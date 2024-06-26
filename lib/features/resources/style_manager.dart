import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

// regular style
TextStyle getRegularTextStyle(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(
      fontSize, FontConsts.fontFamily, FontWeightManager.regular, color);
}

// light style
TextStyle getLightTextStyle(
    {double fontSize = FontSize.s16, required Color color}) {
  return _getTextStyle(
      fontSize, FontConsts.fontFamily, FontWeightManager.light, color);
}

// medium style
TextStyle getMediumTextStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConsts.fontFamily, FontWeightManager.medium, color);
}

// large style
TextStyle getLargeTextStyle(
    {double fontSize = FontSize.s22, required Color color}) {
  return _getTextStyle(
      fontSize, FontConsts.fontFamily, FontWeightManager.bold, color);
}

// bold style
TextStyle getBoldTextStyle(
    {double fontSize = FontSize.s24, required Color color}) {
  return _getTextStyle(
      fontSize, FontConsts.fontFamily, FontWeightManager.bold, color);
}
