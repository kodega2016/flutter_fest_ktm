import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/constants/app_colors.dart';

class PElevatedButton extends StatelessWidget {
  const PElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    thiseight = 50.0,
    this.iconOnLeading = false,
    this.disable = false,
    this.iconSpacing = 15,
    this.isBusy = false,
    this.disableColor = AppColors.baseGrey,
    this.height = 35,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Widget? icon;
  final double height;
  final bool iconOnLeading;
  final bool disable;
  final double iconSpacing;
  final bool isBusy;
  final Color disableColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: disable ? () {} : onPressed,
        style: ButtonStyle(
          backgroundColor:
              disable ? MaterialStateProperty.all(disableColor) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && iconOnLeading)
              Padding(
                padding: EdgeInsets.only(right: iconSpacing),
                child: icon,
              ),
            Text(
              label,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: disable ? AppColors.baseBlack : AppColors.baseWhite,
                  ),
            ),
            if (icon != null && !iconOnLeading)
              Padding(
                padding: EdgeInsets.only(left: iconSpacing),
                child: icon,
              ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              child: AnimatedSwitcher(
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                reverseDuration: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                child: isBusy
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: disable
                                ? AppColors.baseGrey
                                : AppColors.baseWhite,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
