import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const   DefaultButton({
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
      height: getProportionateScreenHeight(45),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: SelectedBorder(),
          backgroundColor: MaterialStateProperty.all(clr),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
class DefaultButtonBold extends StatelessWidget {
  const   DefaultButtonBold({
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
      height: getProportionateScreenHeight(45),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: SelectedBorder(),
          backgroundColor: MaterialStateProperty.all(clr),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(15),
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
      borderRadius: BorderRadius.circular(10),
    );
  }
}
