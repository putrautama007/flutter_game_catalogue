import 'package:core/external/custom_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageButton extends StatelessWidget {
  final String text;
  final bool isIconActive;
  final double textSize;
  final Color textColor;
  final IconData icon;
  final Color iconActiveColor;
  final Color iconInactiveColor;
  final Color shadowColor;
  final double blurRadius;
  final Color buttonColor;
  final Offset offset;
  final VoidCallback onTap;

  ChangeLanguageButton(
      {@required this.text,
      this.isIconActive = true,
      @required this.textSize,
      this.textColor =  Colors.black,
      @required this.icon,
      @required this.iconActiveColor,
      @required this.iconInactiveColor,
      this.shadowColor = Colors.grey,
      this.blurRadius = 1.0,
      this.buttonColor = Colors.white,
      this.offset = Offset.zero,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    Modular.get<CustomScreenUtils>().initScreenUtils(context);
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: offset,
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 8.w, 8.w),
              child: Icon(
                icon,
                color: _checkColor(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 8.w, 16.w, 8.w),
              child: Text(
                text,
                style: TextStyle(fontSize: textSize, color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _checkColor() {
    if (isIconActive != false) {
      return iconActiveColor;
    } else {
      return iconInactiveColor;
    }
  }
}
