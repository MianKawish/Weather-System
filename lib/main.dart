import 'dart:developer';

import 'package:flutter/material.dart';
import 'location.dart';
import 'networking.dart';

const apiKey = 'a25da8722d46dd1217e87146d0284676';
const kTextStyle = TextStyle(fontWeight: FontWeight.w900, fontSize: 40);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0;
  double longitude = 0;
  @override
  void initState() {
    getLocationData();
    _createSplash();
    super.initState();
  }

  void _createSplash() {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SampleScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentPosition();
    latitude = location.latitude;
    longitude = location.longitude;
    log(latitude.toString());
    log(longitude.toString());
    Networking network = Networking();
    var weatherData = await network.networkingData();
    log(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/1.jpg'), fit: BoxFit.cover)),
        child: const SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        '32',
                        style: kTextStyle,
                      ),
                    ),
                    Icon(
                      Icons.sunny,
                      color: Color.fromARGB(255, 0, 179, 122),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Time for ice cream.",
                        textAlign: TextAlign.right,
                        style: kTextStyle,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("I am sample screen after splash screen"),
      ),
    );
  }
}
