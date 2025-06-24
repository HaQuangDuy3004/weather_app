import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}


class _WeatherDisplayState extends State<WeatherDisplay> {
  WeatherModel? weatherModel;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async{
    try{
      final position = await LocationService.getCurrentLocation();
      final weatherData = await WeatherService.fetchWeather(position.latitude, position.longitude);
      setState(() {
        weatherModel = weatherData;
        isLoading = false;
      });
    }catch(e){
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Kiểm tra nếu quá trình đang load dữ liệu
    if(isLoading){
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        debugShowCheckedModeBanner: false,
      );
    }

    //Ktra nếu gặp lỗi
    if(error != null){
      return MaterialApp(
        home: Scaffold(
          body: Center(child: Text("Error: $error")),
        ),
        debugShowCheckedModeBanner: false,
      );
    }

    //Nếu không lỗi và load được dữ liệu
    return MaterialApp(
      home: WeatherScreen(weatherModel: weatherModel!), //Truyền dữ liệu qua widget WeatherScreen
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatelessWidget {

  //Lấy dữ liệu từ widget
  final WeatherModel weatherModel;
  DateTime timeNow = DateTime.now();

  

  WeatherScreen({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    // Sử dụng DateFormat để định dạng ngày tháng
  // Ví dụ: "04/06/2025"
    String formattedDate = DateFormat('dd/MM/yyyy').format(timeNow);
    
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu + Thành phố
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 28),
                  Text("${weatherModel.name}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Icon(Icons.more_vert, size: 28),
                ],
              ),

              const SizedBox(height: 20),

              // Ngày và trạng thái trời
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Chip(
                      label: Text("$timeNow", style: const TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(weatherModel.weather[0].description, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text("${weatherModel.main.temp}°", style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 10),

              // Daily Summary
              const Text(
                "Daily Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Now it feels like +35°, actually +31°.\nIt feels hot because of the direct sun. Today, the temperature is felt in the range from +31° to 27°.",
                style: TextStyle(fontSize: 14, height: 1.4),
              ),

              const SizedBox(height: 20),

              // Thông tin gió - độ ẩm - tầm nhìn
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherInfoItem(icon: Icons.waves, label: "${weatherModel.wind.speed}km/h", sub: "Wind"),
                    WeatherInfoItem(icon: Icons.opacity, label: "${weatherModel.main.humidity}%", sub: "Humidity"),
                    const WeatherInfoItem(icon: Icons.remove_red_eye, label: "1.6km", sub: "Visibility"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Weekly Forecast
              const Text(
                "Weekly forecast",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Dự báo các ngày
              Flexible(
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ForecastItem(day: "21 Jan", temp: "26°", icon: Icons.wb_sunny),
                      ForecastItem(day: "22 Jan", temp: "25°", icon: Icons.cloud),
                      ForecastItem(day: "23 Jan", temp: "27°", icon: Icons.umbrella),
                      ForecastItem(day: "24 Jan", temp: "26°", icon: Icons.bolt),
                      ForecastItem(day: "24 Jan", temp: "26°", icon: Icons.bolt),
                      ForecastItem(day: "24 Jan", temp: "26°", icon: Icons.bolt),
                      ForecastItem(day: "24 Jan", temp: "26°", icon: Icons.bolt),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget nhỏ cho phần thông tin gió, độ ẩm, tầm nhìn
class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const WeatherInfoItem({super.key, required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(sub, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

// Widget nhỏ cho phần dự báo ngày tiếp theo
class ForecastItem extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const ForecastItem({super.key, required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(temp, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(day, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}