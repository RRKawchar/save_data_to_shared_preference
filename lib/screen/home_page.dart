import 'package:flutter/material.dart';
import 'package:save_data_to_shared_preferences/local_storage/preferences_services.dart';
import 'package:save_data_to_shared_preferences/models/model.dart';
import 'package:save_data_to_shared_preferences/utils/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _preferencesServices = PreferencesServices();
  final TextEditingController _userController = TextEditingController();

  var _selectedGender = Gender.FEMALE;
  var _selectedLanguage = <ProgrammingLanguage>{};
  bool _isEmployed = false;

  @override
  void initState() {
    // TODO: implement initState
    _populateFields();
    super.initState();
  }
  void _populateFields() async {
    final settings=await _preferencesServices.getSettings();
    setState(() {
      _userController.text=settings.username;
      _selectedGender=settings.gender;
      _selectedLanguage=settings.programmingLanguages;
      _isEmployed=settings.isEmployed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(text1),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: "UserName"),
            ),
          ),
          buildRadioListTile(),
          buildCheckBoxListTile(),
          SwitchListTile(
              title: const Text("Is Employed"),
              value: _isEmployed,
              onChanged: (value) {
                setState(() {
                  _isEmployed = value;
                });
              }),
          TextButton(
            onPressed: _saveSettings(),
            child: const Text("Save Settings"),
          )
        ],
      ),
    );
  }

  /// Save Data
  _saveSettings() {
    final newSettings = Settings(
        username: _userController.text,
        gender: _selectedGender,
        programmingLanguages: _selectedLanguage,
        isEmployed: _isEmployed);

    print(newSettings);

    _preferencesServices.saveSettings(newSettings);
  }

  /// Checkbox ListTile
  Column buildCheckBoxListTile() {
    return Column(
      children: [
        CheckboxListTile(
            title: const Text("Dart"),
            value: _selectedLanguage.contains(ProgrammingLanguage.DART),
            onChanged: (_) {
              setState(() {
                _selectedLanguage.contains(ProgrammingLanguage.DART)
                    ? _selectedLanguage.remove(ProgrammingLanguage.DART)
                    : _selectedLanguage.add(ProgrammingLanguage.DART);
              });
            }),
        CheckboxListTile(
            title: const Text("JavaScript"),
            value: _selectedLanguage.contains(ProgrammingLanguage.JAVASCRIPT),
            onChanged: (_) {
              setState(() {
                _selectedLanguage.contains(ProgrammingLanguage.JAVASCRIPT)
                    ? _selectedLanguage.remove(ProgrammingLanguage.JAVASCRIPT)
                    : _selectedLanguage.add(ProgrammingLanguage.JAVASCRIPT);
              });
            }),
        CheckboxListTile(
            title: const Text("Kotlin"),
            value: _selectedLanguage.contains(ProgrammingLanguage.KOTLIN),
            onChanged: (_) {
              setState(() {
                _selectedLanguage.contains(ProgrammingLanguage.KOTLIN)
                    ? _selectedLanguage.remove(ProgrammingLanguage.KOTLIN)
                    : _selectedLanguage.add(ProgrammingLanguage.KOTLIN);
              });
            }),
        CheckboxListTile(
            title: const Text("Swift"),
            value: _selectedLanguage.contains(ProgrammingLanguage.SWIFT),
            onChanged: (_) {
              setState(() {
                _selectedLanguage.contains(ProgrammingLanguage.SWIFT)
                    ? _selectedLanguage.remove(ProgrammingLanguage.SWIFT)
                    : _selectedLanguage.add(ProgrammingLanguage.SWIFT);
              });
            }),
      ],
    );
  }

  ///RadioListTile

  Column buildRadioListTile() {
    return Column(
      children: [
        RadioListTile(
          title: const Text("Female"),
          value: Gender.FEMALE,
          groupValue: _selectedGender,
          onChanged: (value) => setState(
            () {
              _selectedGender = value!;
            },
          ),
        ),
        RadioListTile(
          title: const Text("Male"),
          value: Gender.MALE,
          groupValue: _selectedGender,
          onChanged: (value) => setState(
            () {
              _selectedGender = value!;
            },
          ),
        ),
        RadioListTile(
          title: const Text("Other"),
          value: Gender.OTHER,
          groupValue: _selectedGender,
          onChanged: (value) => setState(
            () {
              _selectedGender = value!;
            },
          ),
        ),
      ],
    );
  }
}
