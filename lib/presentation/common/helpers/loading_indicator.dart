import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double? height;
  final double? width;

  const LoadingIndicator({this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        // color:  Colors.transparent,
        child: const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
      ),
    );
  }
}
