import 'package:flutter/widgets.dart';

/// Caches the latest [MediaQueryData] so the legacy `responsive*` helpers can
/// stay top-level functions.
///
/// All values have safe defaults so that calling a `responsive*` helper before
/// [ScreenConfig.init] (e.g. from a test) degrades gracefully instead of
/// producing `NaN`.
class ScreenConfig {
  ScreenConfig._();

  static double screenWidth = 375;
  static double screenHeight = 812;
  static double blockSizeHorizontal = 3.75;
  static double blockSizeVertical = 8.12;
  static double safeBlockHorizontal = 3.75;
  static double safeBlockVertical = 8.12;
  static double defaultSize = 9;
  static Orientation orientation = Orientation.portrait;

  /// Design-reference dimensions. The original app was laid out for a
  /// 375 × 812 pt screen; every helper scales from that baseline.
  static const double _refWidth = 375;
  static const double _refHeight = 812;

  static void init(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    if (data.size.width <= 0 || data.size.height <= 0) return;

    screenWidth = data.size.width;
    screenHeight = data.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    safeBlockHorizontal = (screenWidth - data.padding.horizontal) / 100;
    safeBlockVertical = (screenHeight - data.padding.vertical) / 100;
    orientation = data.orientation;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}

/// Scales a height from the 375 × 812 reference design.
double responsiveHeight(double height) =>
    (height / ScreenConfig._refHeight) * ScreenConfig.screenHeight;

/// Scales a width from the 375-wide reference design.
double responsiveWidth(double width) =>
    (width / ScreenConfig._refWidth) * ScreenConfig.screenWidth;

/// Alias kept for readability at call sites that deal with font sizes.
double responsiveText(double size) => responsiveWidth(size);

bool isPortrait() => ScreenConfig.orientation == Orientation.portrait;
