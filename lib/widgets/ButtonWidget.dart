import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [Color(0xff01519B), Color(0xffFC62B2)],
          ),
        ),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () => onClicked,
          child: Container(
            child: Text(
              "$title".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.23,
                fontSize: 16,
                fontFamily: 'Raleway-ExtraBold',
              ),
            ),
          ),
        ),
      );
}
