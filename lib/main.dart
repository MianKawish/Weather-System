import 'package:flutter/material.dart';
import 'location.dart';
import 'networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'a25da8722d46dd1217e87146d0284676';
const kTextStyle = TextStyle(fontWeight: FontWeight.w900, fontSize: 40);

void main() => runApp(Locator());

class Locator extends StatefulWidget {
  const Locator({super.key});

  @override
  State<Locator> createState() => _LocatorState();
}

double latitude = 0;
double longitude = 0;

class _LocatorState extends State<Locator> {
  @override
  void initState() {
    getLocationData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentPosition();
    latitude = location.latitude;
    longitude = location.longitude;
    print(latitude);
    print(longitude);
    Networking network = Networking();
    var weatherData = await network.networkingData();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoadingScreen();
                }));
              },
              child: Text('123')),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        '32',
                        style: kTextStyle,
                      ),
                    ),
                    Icon(
                      Icons.sunny,
                      color: Color.fromARGB(255, 3, 233, 103),
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
                      padding: const EdgeInsets.all(8.0),
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
