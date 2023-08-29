import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_test/screen/popular_list_screen.dart';
import 'package:movie_test/services/popular_list.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopular();
  }

  void getPopular() async {
    PopularListModel popularListModel = PopularListModel();
    var weatherData = await popularListModel.getPopular();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PopularListScreen(),
      ),
    );
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Loading!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Spartan MB',
                ),
              ),
            ),
            spinkit,
          ],
        ),
      ),
    );
  }
}
