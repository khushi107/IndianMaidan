import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/gradiants.dart'; // We'll use the gradients we defined

enum ButtonType { primary, outlined }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final IconData? icon; // Make the icon optional

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.primary,
    this.icon, // Add icon to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        decoration: _buildDecoration(),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Only show the icon if it's provided
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: _getTextColor(), size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    if (buttonType == ButtonType.primary) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: AppGradients.orangeGradient, // Using the theme gradient
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      );
    } else {
      // This is for the outlined button style
      return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
        border: Border.all(color: AppColors.green, width: 1.5),
      );
    }
  }

  Color _getTextColor() {
    return buttonType == ButtonType.primary ? AppColors.white : AppColors.green;
  }
}