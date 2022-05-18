import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class DefaultButtonRect extends StatelessWidget {
  const DefaultButtonRect({
    required this.text,
    required this.press,
    required this.clr,
    required this.isInfinity,
  });
  final String text;
  final Function() press;
  final Color clr;
  final bool isInfinity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isInfinity ? double.infinity : getProportionateScreenWidth(150),
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: SelectedBorder(),
          backgroundColor: MaterialStateProperty.all(clr),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    );
  }
}
