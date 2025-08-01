import 'package:flutter/material.dart';
import 'package:wiser_clone_app/core/app_colors.dart';

class TitleLabel extends StatelessWidget {
  final String title;
  final bool arrow;
  const TitleLabel({super.key, required this.title, this.arrow = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 24),
        arrow
            ? Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: AppColors.gray,
                  ),
                ],
              )
            : Text(
                title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
        SizedBox(height: 16),
      ],
    );
  }
}
