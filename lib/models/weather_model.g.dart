// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  name: json['name'] as String,
  main: Main.fromJson(json['main'] as Map<String, dynamic>),
  wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
  weather: (json['weather'] as List<dynamic>)
      .map((e) => WeatherDescription.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'main': instance.main,
      'wind': instance.wind,
      'weather': instance.weather,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
  temp: (json['temp'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
  'temp': instance.temp,
  'humidity': instance.humidity,
};

Wind _$WindFromJson(Map<String, dynamic> json) =>
    Wind(speed: (json['speed'] as num).toDouble());

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
  'speed': instance.speed,
};

WeatherDescription _$WeatherDescriptionFromJson(Map<String, dynamic> json) =>
    WeatherDescription(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherDescriptionToJson(WeatherDescription instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };
