

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';

static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
}

static Future<bool> saveUserNameSharedPreference(String username) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(sharedPreferenceUserNameKey, username);
}

static Future<bool> saveUserEmailSharedPreference(String email) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(sharedPreferenceUserEmailKey, email);
}

static Future<bool?> getUserLoggedInSharedPreference() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return  preferences.getBool(sharedPreferenceUserLoggedInKey);
} 
static Future<String?> getUserNameSharedPreference() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return  preferences.getString(sharedPreferenceUserNameKey);
} 

static Future<String?> getEmailLoggedInSharedPreference() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return  preferences.getString(sharedPreferenceUserEmailKey);
} 
}