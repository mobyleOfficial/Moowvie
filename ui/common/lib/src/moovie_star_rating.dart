import 'package:flutter/material.dart';

class MoovieStarRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double>? onRatingChanged;
  final double starSize;
  final Color? activeColor;
  final Color? inactiveColor;

  static const int _starCount = 5;

  const MoovieStarRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.starSize = 32,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filledColor = activeColor ?? colorScheme.onTertiaryContainer;
    final emptyColor = inactiveColor ?? colorScheme.outlineVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_starCount, (index) {
        final starValue = index + 1;
        final isFilled = index < rating.floor();
        final isHalf = !isFilled && index < rating;

        return GestureDetector(
          onTapUp: onRatingChanged == null
              ? null
              : (details) {
                  final renderBox = context.findRenderObject() as RenderBox;
                  final localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  final starStart = index * starSize;
                  final tapInLeftHalf =
                      localPosition.dx - starStart < starSize / 2;
                  final newRating =
                      tapInLeftHalf ? starValue - 0.5 : starValue.toDouble();
                  onRatingChanged!(newRating == rating ? 0 : newRating);
                },
          child: Semantics(
            label: isHalf
                ? '${starValue - 0.5} stars'
                : isFilled
                    ? '$starValue stars'
                    : '$starValue stars empty',
            child: Icon(
              isHalf
                  ? Icons.star_half
                  : (isFilled ? Icons.star : Icons.star_border),
              size: starSize,
              color: (isFilled || isHalf) ? filledColor : emptyColor,
            ),
          ),
        );
      }),
    );
  }
}
