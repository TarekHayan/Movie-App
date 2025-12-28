import 'package:flutter/material.dart';

/// Responsive helper class for handling different screen sizes
class ResponsiveHelper {
  /// Breakpoints for different device types
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if device is desktop/web
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= tabletBreakpoint;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    } else {
      return const EdgeInsets.symmetric(horizontal: 64, vertical: 24);
    }
  }

  /// Get responsive horizontal padding
  static double getResponsiveHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 16;
    } else if (isTablet(context)) {
      return 32;
    } else {
      return 64;
    }
  }

  /// Get responsive vertical padding
  static double getResponsiveVerticalPadding(BuildContext context) {
    if (isMobile(context)) {
      return 8;
    } else if (isTablet(context)) {
      return 16;
    } else {
      return 24;
    }
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, {
    double mobile = 8,
    double tablet = 16,
    double desktop = 24,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  /// Get responsive grid cross axis count for movies
  static int getGridCrossAxisCount(BuildContext context) {
    final width = screenWidth(context);
    if (width < mobileBreakpoint) {
      return 2; // Mobile: 2 columns
    } else if (width < tabletBreakpoint) {
      return 3; // Tablet: 3 columns
    } else if (width < desktopBreakpoint) {
      return 4; // Small desktop: 4 columns
    } else {
      return 6; // Large desktop: 6 columns
    }
  }

  /// Get responsive child aspect ratio for grid items
  static double getGridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) {
      return 2 / 3; // Standard movie poster ratio
    } else if (isTablet(context)) {
      return 2 / 3;
    } else {
      return 2 / 3;
    }
  }

  /// Get responsive grid spacing
  static double getGridSpacing(BuildContext context) {
    if (isMobile(context)) {
      return 8;
    } else if (isTablet(context)) {
      return 16;
    } else {
      return 24;
    }
  }

  /// Get responsive image height for carousel/slideshow
  static double getCarouselHeight(BuildContext context) {
    if (isMobile(context)) {
      return 200;
    } else if (isTablet(context)) {
      return 300;
    } else {
      return 400;
    }
  }

  /// Get responsive viewport fraction for carousel
  static double getCarouselViewportFraction(BuildContext context) {
    if (isMobile(context)) {
      return 0.85;
    } else if (isTablet(context)) {
      return 0.7;
    } else {
      return 0.6;
    }
  }

  /// Get responsive list item height
  static double getListItemHeight(BuildContext context) {
    if (isMobile(context)) {
      return 240;
    } else if (isTablet(context)) {
      return 280;
    } else {
      return 320;
    }
  }

  /// Get responsive list item width
  static double getListItemWidth(BuildContext context) {
    if (isMobile(context)) {
      return 160;
    } else if (isTablet(context)) {
      return 180;
    } else {
      return 200;
    }
  }

  /// Get max content width for web (prevents content from being too wide)
  static double getMaxContentWidth(BuildContext context) {
    if (isDesktop(context)) {
      return 1400; // Max width for web content
    }
    return double.infinity;
  }

  /// Get responsive touch target size (minimum 48x48 for accessibility)
  static double getTouchTargetSize(BuildContext context) {
    if (isMobile(context)) {
      return 48;
    } else {
      return 56; // Larger for desktop/web
    }
  }
}

