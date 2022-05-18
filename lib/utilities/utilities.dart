import 'package:flutter/material.dart';

final redColor = Color(0xFFFD322D);
final greenColor = Color(0xFF90FD2D);
final blueColor = Color(0xFF2DF8FD);
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.grey[900],
  fontWeight: FontWeight.normal,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF003d48),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
