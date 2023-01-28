import 'package:flutter/material.dart';
import 'package:mvvm/res/app_colors.dart';

class LoadingButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  const LoadingButton({Key? key, required this.title, required this.loading, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("button build");
    return Container(
      width: 160.0,
      height: 48.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.bluePrimary, AppColors.blueSecondary]),
            borderRadius: BorderRadius.circular(25)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
            onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              side: const BorderSide(
                color: AppColors.white,
                width: 1,
                style: BorderStyle.solid
              )
            ),

          ),
          child: loading ? const SizedBox(
            height: 24.0,
            width: 24.0,
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ) : Text(title), ),
      ),
    );
  }
}
