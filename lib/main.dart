import 'package:flutter/material.dart';
import 'package:save_data_to_shared_preferences/screen/favourite_screen.dart';
import 'package:save_data_to_shared_preferences/test.dart';

void main(){

  runApp(MyApp());
}

class MyApp  extends StatelessWidget{

  Widget build(BuildContext context){

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Save data to Shared preference",
      home: FavouriteScreen(),
    );
  }
}
