import 'package:http/http.dart';
import 'dart:convert';

class Networking {
  Future networkingData() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=31.5204&lon=74.3587&appid=a25da8722d46dd1217e87146d0284676'));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);

      // double temp = jsonDecode(data)['main']['temp'];
      // int path = jsonDecode(data)['sys']['id'];
      // String cityName = jsonDecode(data)['name'];
    } else {
      print(response.statusCode);
    }
  }
}
