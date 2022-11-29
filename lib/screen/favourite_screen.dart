import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  static const liked_key = 'liked_key';

  late bool liked = false;

  void _getDataFromPefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var liked_ = prefs.getBool(liked_key);
    setState(() {
      liked = liked_!;
    });
  }

  void _setDataToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
        liked = !liked;
    });
    prefs.setBool(liked_key, liked);

  }

  @override
  void initState() {
    _getDataFromPefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Button"),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 10)
              ]),
          child: Card(
            child: Column(
              children: [
                Image.network(
                  "https://play-lh.googleusercontent.com/XVHP0sBKrRJYZq_dB1RalwSmx5TcYYRRfYMFO18jgNAnxHAIA1osxM55XHYTb3LpkV8",
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Favourite Button",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Favourite Button with\n Shared Preferences"),
                IconButton(
                  onPressed: (){
                    _setDataToSharedPref();
                  },
                  icon: (Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked ? Colors.red : Colors.grey,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
