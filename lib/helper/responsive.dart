import 'package:flutter/material.dart';

int responsiveNumGridTiles(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 1;
  } else if (deviceWidth < 1200) {
    return 2;
  } else if (deviceWidth < 1650) {
    return 3;
  }
  return 4;
}

double responsiveImageHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 250.0;
  } else if (deviceWidth < 1200) {
    return mediaQuery.size.width * 0.25;
  } else if (deviceWidth < 1650) {
    return mediaQuery.size.width * 0.2;
  }
  return mediaQuery.size.width * 0.15;
}

double responsiveTitleHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 120.0;
  } else if (deviceWidth < 1200) {
    return mediaQuery.size.width * 0.1;
  } else if (deviceWidth < 1650) {
    return mediaQuery.size.width * 0.07;
  }
  return mediaQuery.size.width * 0.05;
}

double responsiveContentHeight(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;
  if (deviceWidth < 700) {
    return 180.0;
  } else if (deviceWidth < 1200) {
    return mediaQuery.size.width * 0.2;
  } else if (deviceWidth < 1650) {
    return mediaQuery.size.width * 0.1;
  }
  return mediaQuery.size.width * 0.08;
}
