import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService{
  static Future<WeatherModel> fetchWeather(double latitude, double longitude) async{
    String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
    String apiKey = '6cb33182472798e53c946f8e49cb980b'; //Error 401 Lỗi API
    String url = "$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric";

    //Gửi yêu cầu HTTP
    final response = await http.get(Uri.parse(url));
    print("Weather response: ${response.body}");
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      //Xử lý lỗi
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  }
}
