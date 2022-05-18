import 'package:flutter/material.dart';
import 'size_config.dart';

const kPrimaryColor = Color(0xFF0081c2);
const kGreenColor = Color(0xFF70a843);
const kRedColor = Color(0xFFe11e1f);
const kTextBlueColor = Color(0xFF0081c2);
const kTextGreenColor = Color(0xFF70a843);
const kTextRedColor = Color(0xFFF1430E);
const kTextGoldColor = Color(0xFFc19614);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondary2Color = Color(0xFFd6d6d6);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const mainApiUrl = "https://www.edevz.com/crossCompNew/api.php";


const loginUrl = "https://www.edevz.com/cross_comp/login.php";
const postalCodeRequestUrl =
    "https://www.edevz.com/cross_comp/get_all_postalCode.php";
const registrationUrl = "https://www.edevz.com/cross_comp/profile.php";
const getScoresUrl = "https://www.edevz.com/cross_comp/score_get_data.php";
const getUserUrl = "https://www.edevz.com/cross_comp/profile_get_data.php";
const upDateUserUrl = "https://www.edevz.com/cross_comp/update_profile.php";
const setEventUrl = "https://www.edevz.com/cross_comp/addEvent.php";
const getEventUrl = "https://www.edevz.com/cross_comp/getEvents.php";
const deleteEventUrl = "https://www.edevz.com/cross_comp/deleteEvent.php";
const setFacilityUrl = "https://www.edevz.com/cross_comp/addFacility.php";
const getFacilityUrl = "https://www.edevz.com/cross_comp/getFacilities.php";
const deleteFacilityUrl = "https://www.edevz.com/cross_comp/deleteFacility.php";
const getFacilityEventUrl = "https://www.edevz.com/cross_comp/getFacilityEvents.php";


const getTeamScoresUrl = "https://www.edevz.com/cross_comp/get_Teams_score_details.php";
const getTeamStandingUrl = "https://www.edevz.com/cross_comp/get_Teams_standing.php";
const getAllTeamsUrl = "https://www.edevz.com/cross_comp/get_all_teams.php";
// const getChallengeTeamScoresUrl = "https://www.edevz.com/cross_comp/get_challenge_Teams_score_details.php";
// const servicesGetDataUrl = "https://www.edevz.com/cross_comp/services_get_data.php";
