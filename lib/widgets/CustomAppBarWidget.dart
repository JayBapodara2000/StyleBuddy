import 'package:flutter/material.dart';
import 'package:style_buddy/utils/ConstantsStyle.dart';

class CustomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      title: Text(
        'Salons',
        textAlign: TextAlign.center,
        style: appBarTextStyle,
      ),
    );
  }
}
