import 'package:flutter/material.dart';

const Size kDefaultSize = Size.square(9.0);
const Size kDefaultFadeOutSize = Size.square(6.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  /// Inactive dot color
  ///
  /// @Default `Colors.grey`
  final Color color;

  /// List of inactive dot colors
  /// One color by dot
  ///
  /// @Default `Value of color parameter applied to each dot`
  final List<Color> colors;

  /// Active dot color
  ///
  /// @Default `Theme.of(context).primaryColor`
  final Color? activeColor;

  /// List of active dot colors
  /// One color by dot
  ///
  /// @Default `Value of activeColor parameter applied to each dot`
  final List<Color> activeColors;

  /// Inactive dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size size;

  /// List of inactive dot size
  /// One size by dot
  ///
  /// @Default `Value of size parameter applied to each dot`
  final List<Size> sizes;

  /// Fade out dot size
  ///
  /// @Default `Size.square(6.0)`
  final Size fadeOutSize;

  /// List of fade out dot size
  /// One size by dot
  ///
  /// @Default `Value of activeSize parameter applied to each dot`
  final List<Size> fadeOutSizes;

  /// Active dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size activeSize;

  /// List of active dot size
  /// One size by dot
  ///
  /// @Default `Value of activeSize parameter applied to each dot`
  final List<Size> activeSizes;

  /// Inactive dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder shape;

  /// List of inactive dot shape
  /// One shape by dot
  ///
  /// @Default `Value of shape parameter applied to each dot`
  final List<ShapeBorder> shapes;

  /// Active dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder activeShape;

  /// List of active dot shapes
  /// One shape by dot
  ///
  /// @Default `Value of activeShape parameter applied to each dot`
  final List<ShapeBorder> activeShapes;

  /// Spacing between dots
  ///
  /// @Default `EdgeInsets.all(6.0)`
  final EdgeInsets spacing;

  /// Shadows of the dots
  ///
  /// @Default `null`
  final List<BoxShadow>? shadows;

  /// Shadows of the active dots
  ///
  /// @Default `shadows` or `null`
  final List<BoxShadow>? activeShadows;

  const DotsDecorator({
    this.color = Colors.grey,
    this.colors = const [],
    this.activeColor,
    this.activeColors = const [],
    this.size = kDefaultSize,
    this.sizes = const [],
    this.fadeOutSize = kDefaultFadeOutSize,
    this.fadeOutSizes = const [],
    this.activeSize = kDefaultSize,
    this.activeSizes = const [],
    this.shape = kDefaultShape,
    this.shapes = const [],
    this.activeShape = kDefaultShape,
    this.activeShapes = const [],
    this.spacing = kDefaultSpacing,
    this.shadows,
    this.activeShadows,
  });

  Color? getActiveColor(int index) {
    return activeColors.isNotEmpty ? activeColors[index] : activeColor;
  }

  Color getColor(int index) {
    return colors.isNotEmpty ? colors[index] : color;
  }

  Size getFadeOutSize(int index) {
    return fadeOutSizes.isNotEmpty ? fadeOutSizes[index] : fadeOutSize;
  }

  Size getActiveSize(int index) {
    return activeSizes.isNotEmpty ? activeSizes[index] : activeSize;
  }

  Size getSize(int index) {
    return sizes.isNotEmpty ? sizes[index] : size;
  }

  ShapeBorder getActiveShape(int index) {
    return activeShapes.isNotEmpty ? activeShapes[index] : activeShape;
  }

  ShapeBorder getShape(int index) {
    return shapes.isNotEmpty ? shapes[index] : shape;
  }

  List<BoxShadow>? getShadows(int index) {
    return shadows;
  }

  List<BoxShadow>? getActiveShadows(int index) {
    return activeShadows ?? shadows;
  }
}