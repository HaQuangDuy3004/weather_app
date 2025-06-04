import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart'; // được tạo tự động

@JsonSerializable()
class WeatherModel{
  final String name;
  final Main main;
  final Wind wind;
  final List<WeatherDescription> weather;

  WeatherModel({
    required this.name,
    required this.main,
    required this.wind,
    required this.weather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String,dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class Main{
  final double temp;
  final int humidity;

  Main({
    required this.temp,
    required this.humidity,
  });
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String,dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind{
  double speed;
  Wind({
    required this.speed
  });
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String,dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class WeatherDescription{
  final String description;
  final String icon;
  WeatherDescription({
    required this.description,
    required this.icon,
  });
  factory WeatherDescription.fromJson(Map<String, dynamic> json) => _$WeatherDescriptionFromJson(json);

  Map<String,dynamic> toJson() => _$WeatherDescriptionToJson(this);
}