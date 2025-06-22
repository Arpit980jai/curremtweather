import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:curremtweather/Model/weatherDataModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static String? _apiKey = dotenv.env['WEATHERBIT_API_KEY'];

  Future<List<WeatherDataModel>> getCurrentWeather(String city) async {
    if (_apiKey == null) {
      throw Exception('API key not found in .env');
    }

    final response = await http.get(Uri.parse(
        'https://api.weatherbit.io/v2.0/current?city=$city&key=$_apiKey&include=minutely'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json['data'] == null) {
        throw Exception('No data found in API response');
      }
      final dataList = json['data'] as List<dynamic>;
      return dataList.map((item) => WeatherDataModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode} - ${response.body}');
    }
  }
}