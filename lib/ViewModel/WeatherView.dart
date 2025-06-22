import 'package:curremtweather/Model/weatherDataModel.dart';
import 'package:curremtweather/View/WeatherService.dart';
import 'package:flutter/material.dart';

class Weatherview extends StatefulWidget {
  const Weatherview({super.key});

  @override
  State<Weatherview> createState() => _WeatherviewState();
}

class _WeatherviewState extends State<Weatherview> {
  final WeatherService weatherService = WeatherService();
  List<WeatherDataModel> weatherData = [];
  TextEditingController cityName = TextEditingController();

  Future<void> fetchWeatherData(String city) async {
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name')),
      );
      return;
    }
    try {
      var data = await weatherService.getCurrentWeather(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      setState(() {
        weatherData = []; // Ensure weatherData is cleared on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load weather data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData("Raleigh");
  }

  String getBackgroundImage() {
    if (weatherData.isNotEmpty) {
      String weatherCondition = weatherData[0].weather.description.toLowerCase();
      if (weatherCondition.contains('thunder')) {
        return 'assets/stormy.jpg';
      } else if (weatherCondition.contains('rain')) {
        return 'assets/rainy.jpg';
      } else if (weatherCondition.contains('snow') || weatherCondition.contains('sleet')) {
        return 'assets/snowy.jpg';
      } else if (weatherCondition.contains('fog') || weatherCondition.contains('mist')) {
        return 'assets/foggy.jpg';
      } else if (weatherCondition.contains('clear') || weatherCondition.contains('sunny')) {
        return 'assets/sunny.jpg';
      } else if (weatherCondition.contains('cloud') && !weatherCondition.contains('partly')) {
        return 'assets/cloudy.jpg';
      } else {
        return 'assets/partlyCloudy.jpg';
      }
    }
    return 'assets/sunny.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[700],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getBackgroundImage()),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black38,

                    ),
                    child: TextField(
                      controller: cityName,
                      decoration: InputDecoration(
                        hintText: "Enter City Name",
                        prefixIcon: const Icon(Icons.location_city, color: Colors.white),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              cityName.clear();
                              weatherData.clear();
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          fetchWeatherData(cityName.text);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (weatherData.isNotEmpty)
                    Card(
                      color: Colors.black54,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'City: ${weatherData[0].cityName}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Temp: ${weatherData[0].temp}°C',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Condition: ${weatherData[0].weather.description}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}