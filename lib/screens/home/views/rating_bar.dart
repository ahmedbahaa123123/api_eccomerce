import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedRatingBar extends StatefulWidget {
  /// [AnimatedRatingBar] can be used for rating which enhances User Experience
  ///
  /// by displaying beautiful animation like glows and sparks.
  ///
  /// Example:
  /// ```dart
  /// return AnimatedRatingBar(
  ///          activeFillColor: Theme.of(context).colorScheme.inversePrimary,
  ///          strokeColor: Theme.of(context).colorScheme.inversePrimary,
  ///          initialRating: 0,
  ///          height: 60,
  ///          width: MediaQuery.of(context).size.width,
  ///          animationColor: Theme.of(context).colorScheme.inversePrimary,
  ///          onRatingUpdate: (rating) {
  ///            debugPrint(rating.toString());
  ///          },
  ///        );
  /// ```
  const AnimatedRatingBar({
    Key? key,
    this.initialRating = 0.0,
    this.height,
    this.width,
    this.activeFillColor,
    this.strokeColor,
    required this.onRatingUpdate,
    this.animationColor,
  }) : super(key: key);

  /// This sets the initial rating of the Animated Rating Bar
  ///
  /// If not provided, by default it will start from 0.0
  final double initialRating;

  /// Holds the height of the widget. You can customize it
  ///
  /// according to your requirements.
  final double? height;

  /// Holds the width of the widget. You can customize it
  ///
  /// according to your requirements.
  final double? width;

  /// Fills color on the inner layer of the icon except for the stroke.
  final Color? activeFillColor;

  /// You can even modify stroke color using this property.
  final Color? strokeColor;

  /// Animation color holds both glow and sparks color
  ///
  /// Use it accordingly.
  final Color? animationColor;

  /// This holds the double value on the update of the rating.
  final ValueChanged<double> onRatingUpdate;

  @override
  State<AnimatedRatingBar> createState() => _AnimatedRatingBarState();
}

class _AnimatedRatingBarState extends State<AnimatedRatingBar> {
  StateMachineController? stateMachineController;
  SMIInput<double>? ratingInput;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 40,
      width: widget.width ?? 140,
      child: RiveAnimation.asset(
        "packages/animated_rating_bar/assets/new_rating_animation.riv",
        onInit: (artboard) {
          stateMachineController = StateMachineController.fromArtboard(
            artboard,
            "State Machine 1",
            onStateChange: (stateMachineName, stateName) {
              // Handle state changes if necessary
            },
          );
          if (stateMachineController != null) {
            artboard.addController(stateMachineController!);
            ratingInput = stateMachineController!.findInput("Rating");
            ratingInput?.value = widget.initialRating;

            // Set the initial rating
            widget.onRatingUpdate(widget.initialRating);
          }

          /// Customization of each component from Rive.
          artboard.forEachComponent(
            (child) {
              if (child is Shape) {
                final Shape shape = child;
                if (widget.activeFillColor != null) {
                  if (shape.name.startsWith("Star_")) {
                    (shape.fills.first.children[0] as SolidColor).colorValue =
                        widget.activeFillColor!.value;
                  } else if (shape.name.startsWith("Star_base_")) {
                    (shape.strokes.first.children[0] as SolidColor).colorValue =
                        widget.strokeColor?.value ?? widget.activeFillColor!.value;
                  } else if (shape.name.contains("glow") || shape.name.contains("sparks")) {
                    (shape.strokes.first.children[0] as SolidColor).colorValue =
                        widget.animationColor?.value ?? widget.activeFillColor!.value;
                  }
                } else {
                  var brightness = MediaQuery.of(context).platformBrightness;
                  bool isDarkMode = brightness == Brightness.dark;
                  Color color = isDarkMode
                      ? ThemeData.light().primaryColor
                      : ThemeData.dark().primaryColor;

                  if (shape.name.startsWith("Star_")) {
                    (shape.fills.first.children[0] as SolidColor).colorValue = color.value;
                  } else if (shape.name.contains("glow") || shape.name.contains("sparks")) {
                    (shape.strokes.first.children[0] as SolidColor).colorValue = color.value;
                  }
                }
              }
            },
          );
        },
      ),
    );
  }
}
