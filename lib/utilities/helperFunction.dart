import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //////////////////////////////////////////////////////////////////////////////
  static String sharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencesUserNameKey = "USERNAMEKEY";
  static String sharedPreferencesUserIdKey = "USERIDKEY";
  static String sharedPreferencesUserEmailKey = "USEREMAILKEY";
  static String sharedPreferencesUserPassKey = "USERPASSKEY";
  static String sharedPreferencesUserTypeKey = "USERTYPEKEY";
  //////////////////////////////////////////////////////////////////////////////
  static String sharedPreferencesPQ1Key = "PQ_1";
  static String sharedPreferencesPQ2Key = "PQ_2";
  static String sharedPreferencesPQ3Key = "PQ_3";
  //////////////////////////////////////////////////////////////////////////////
  static String sharedPreferencesReservationKey = "reservation";
  static String sharedPreferencesHQ1Key = "HQ_1";
  static String sharedPreferencesHQ2Key = "HQ_2";
  static String sharedPreferencesHQ3Key = "HQ_3";
  static String sharedPreferencesInitKey = "INIT";
  static String sharedPreferencesMStatusKey = "MSTATUS";
  static String sharedPreferencesConsentKey = "Consent";
  static String sharedPreferencesWHEREKey = "WHERE";
  static String sharedPreferencesWHERETYPEKey = "WHERETYPE";
  static String sharedPreferencesWHENKey = "WHEN";
  static String sharedPreferencesUserTokenKey = "TOKENKEY";
  static String sharedPreferencesUserTopicKey = "TOPICKEY";
////////////////////////////////////////////////////////////////////////////////
  static String sharedPreferencesProfKey = "ProfKEY";
  static String sharedPreferencesProfShuttleKey = "ProfShuttleKEY";
  static String sharedPreferencesProfSquartKey = "ProfSquartKEY";
  static String sharedPreferencesProfLegRaiseKey = "ProfLegRaiseKEY";
  static String sharedPreferencesProfPushUpsKey = "ProfPushUpsKEY";
////////////////////////////////////////////////////////////////////////////////
  static String sharedPreferencesVolKey = "VolKEY";
  static String sharedPreferencesVolShuttleKey = "VolShuttleKEY";
  static String sharedPreferencesVolSquartKey = "VolSquartKEY";
  static String sharedPreferencesVolLegRaiseKey = "VolLegRaiseKEY";
  static String sharedPreferencesVolPushUpsKey = "VolPushUpsKEY";
  //////////////////////////////////////////////////////////////////////////////

  //saving data to shared preference

  static Future<bool> saveUserLoggedInSharedPreference(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesUserLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUserIdSharedPreference(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserIdKey, uid);
  }
  static Future<bool> saveReservationSharedPreference(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesReservationKey, uid);
  }

  static Future<bool> saveUserMStatusSharedPreference(bool isStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesMStatusKey, isStatus);
  }

  static Future<bool> saveConsentSharedPreference(bool isConsent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesConsentKey, isConsent);
  }

  static Future<bool> saveWhereSharedPreference(String isWhere) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesWHEREKey, isWhere);
  }
  static Future<bool> saveWhereTypeSharedPreference(String isWhereType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesWHERETYPEKey, isWhereType);
  }

  static Future<bool> saveWhenSharedPreference(bool isWhen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesWHENKey, isWhen);
  }

  static Future<bool> saveProfSharedPreference(bool isProf) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesProfKey, isProf);
  }

  static Future<bool> saveVolSharedPreference(bool isVol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesVolKey, isVol);
  }

  static Future<bool> savePQ1SharedPreference(String pQ1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesPQ1Key, pQ1);
  }
  static Future<bool> savePQ2SharedPreference(String pQ2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesPQ2Key, pQ2);
  }
  static Future<bool> savePQ3SharedPreference(String pQ3) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesPQ3Key, pQ3);
  }

  static Future<bool> saveHQ1SharedPreference(bool hQ1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesHQ1Key, hQ1);
  }

  static Future<bool> saveInitSharedPreference(bool init) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesInitKey, init);
  }

  static Future<bool> saveHQ2SharedPreference(bool hQ2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesHQ2Key, hQ2);
  }

  static Future<bool> saveHQ3SharedPreference(bool hQ3) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesHQ3Key, hQ3);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String isEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserEmailKey, isEmail);
  }

  static Future<bool> saveUserPassSharedPreference(String isPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserPassKey, isPass);
  }

  static Future<bool> saveUserTypeSharedPreference(String isType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserTypeKey, isType);
  }

  static Future<bool> saveTokenSharedPreference(String isToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserTokenKey, isToken);
  }

  static Future<bool> saveTopicSharedPreference(bool isTopic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesUserTopicKey, isTopic);
  }

  static Future<bool> saveProfShuttleSharedPreference(bool profShuttle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesProfShuttleKey, profShuttle);
  }

  static Future<bool> saveProfSquartSharedPreference(bool profSquart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesProfSquartKey, profSquart);
  }

  static Future<bool> saveProfLegRaiseSharedPreference(
      bool profLegRaise) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesProfLegRaiseKey, profLegRaise);
  }

  static Future<bool> saveProfPushUpsSharedPreference(bool profPushUps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesProfPushUpsKey, profPushUps);
  }

  static Future<bool> saveVolShuttleSharedPreference(bool volShuttle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesVolShuttleKey, volShuttle);
  }

  static Future<bool> saveVolSquartSharedPreference(bool volSquart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesVolSquartKey, volSquart);
  }

  static Future<bool> saveVolLegRaiseSharedPreference(bool volLegRaise) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesVolLegRaiseKey, volLegRaise);
  }

  static Future<bool> saveVolPushUpsSharedPreference(bool volPushUps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesVolPushUpsKey, volPushUps);
  }
  // getting data from shared preferences

  static Future<bool?> getInitSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesInitKey);
  }

  static Future<bool?> getMStatusSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesMStatusKey);
  }

  static Future<bool?> getConsentSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesConsentKey);
  }

  static Future<String?> getUserIdSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserIdKey);
  }
  static Future<String?> getReservationSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesReservationKey);
  }

  static Future<String?> getWhereSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesWHEREKey);
  }

  static Future<String?> getWhereTypeSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesWHERETYPEKey);
  }

  static Future<bool?> getWhenSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesWHENKey);
  }

  static Future<bool?> getProfSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesProfKey);
  }

  static Future<bool?> getVolSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesVolKey);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesUserLoggedInKey);
  }

  static Future<String?> getPQ1SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesPQ1Key);
  }
  static Future<String?> getPQ2SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesPQ2Key);
  }
  static Future<String?> getPQ3SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesPQ3Key);
  }
  static Future<bool?> getHQ1SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesHQ1Key);
  }

  static Future<bool?> getHQ2SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesHQ2Key);
  }

  static Future<bool?> getHQ3SharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesHQ3Key);
  }

  static Future<String?> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserEmailKey);
  }

  static Future<String?> getUserPassSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserPassKey);
  }

  static Future<String?> getUserTypeSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserTypeKey);
  }

  static Future<String?> getTokenSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserTokenKey);
  }

  static Future<String?> getTopicSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUserTopicKey);
  }

  static Future<bool?> getProfShuttleSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesProfShuttleKey);
  }

  static Future<bool?> getProfSquartSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesProfSquartKey);
  }

  static Future<bool?> getProfLegRaiseSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesProfLegRaiseKey);
  }

  static Future<bool?> getProfPushUpsSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesProfPushUpsKey);
  }

  static Future<bool?> getVolShuttleSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesVolShuttleKey);
  }

  static Future<bool?> getVolSquartSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesVolSquartKey);
  }

  static Future<bool?> getVolLegRaiseSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesVolLegRaiseKey);
  }

  static Future<bool?> getVolPushUpsSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencesVolPushUpsKey);
  }
}
