import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../Model/WeatherForecast.dart';

class HomeScreenController extends GetxController {
  var permission = Permission.location;
  late Position currentPosition;
  late Future<Position?> currentPositionFuture;
  late final String _apiKey = 'aef721754e232c693d92f12559c0dcfb';
  RxList weatherForecastList = <WeatherForecast>[].obs;
  var isLoading = false.obs;

  checkPermission() async {
    isLoading(true);
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await permission.request();
      _getCurrentLocation();
    }
    if (status.isGranted) {
      _getCurrentLocation();
    }
    if(status.isDenied){
      print("denied");
      isLoading(false);
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      print(position.latitude);
      print(position.longitude);
      getWeatherForecast(position.latitude, position.longitude);
  }

  Future<void> getWeatherForecast(double lat, double lon) async {
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
        weatherForecastList = RxList<WeatherForecast>.from(jsonData['list'].map((data) {
          return WeatherForecast.fromJson(data);
        }));
        print(weatherForecastList.length);
      isLoading(false);
    } else {
      throw Exception('Failed to load weather forecast');
    }
  }
}
