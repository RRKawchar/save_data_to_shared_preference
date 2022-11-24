import 'package:save_data_to_shared_preferences/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', settings.username);
    await preferences.setBool('isEmployed', settings.isEmployed);
    await preferences.setInt('gender', settings.gender.index);
    await preferences.setStringList(
      'programmingLanguage',
      settings.programmingLanguages.map((e) => e.index.toString()).toList(),
    );

    print('save settings');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];

    final programmingLanguageIndicies =
        preferences.getStringList("programmingLanguage");

    final programmingLanguages = programmingLanguageIndicies!.map(
        (stringIndex) => ProgrammingLanguage.values[int.parse(stringIndex)]).toSet();


    return Settings(
        username: username.toString(),
        gender: gender,
        programmingLanguages: programmingLanguages,
        isEmployed: isEmployed!

    );
  }
}
