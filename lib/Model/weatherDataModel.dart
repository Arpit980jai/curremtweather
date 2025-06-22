class WeatherDataModel {
  final double appTemp; // Apparent temperature
  final double aqi; // Air Quality Index (changed from int)
  final String cityName; // City name
  final double clouds; // Cloud coverage (%) (changed from int)
  final String countryCode; // Country code
  final String datetime; // Observation time cycle
  final double dewpt; // Dew point
  final double dhi; // Diffuse horizontal irradiance
  final double dni; // Direct normal irradiance
  final double elevAngle; // Solar elevation angle
  final double ghi; // Global horizontal irradiance
  final double? gust; // Wind gust speed (nullable)
  final double hAngle; // Solar hour angle (changed from int)
  final double lat; // Latitude
  final double lon; // Longitude
  final String obTime; // Observation time
  final String pod; // Part of day (d/n)
  final double precip; // Precipitation rate
  final double pres; // Pressure
  final double rh; // Relative humidity (%) (changed from int)
  final double slp; // Sea level pressure
  final double snow; // Snowfall rate
  final double solarRad; // Solar radiation
  final List<dynamic> sources; // Data sources
  final String stateCode; // State code
  final String station; // Station ID
  final String sunrise; // Sunrise time
  final String sunset; // Sunset time
  final double temp; // Temperature
  final String timezone; // Timezone
  final double ts; // Unix timestamp (changed from int)
  final double uv; // UV index (changed from int)
  final double vis; // Visibility (changed from int)
  final Weather weather; // Weather object
  final String windCdir; // Wind cardinal direction
  final String windCdirFull; // Full wind direction
  final double windDir; // Wind direction (degrees) (changed from int)
  final double windSpd; // Wind speed

  WeatherDataModel({
    required this.appTemp,
    required this.aqi,
    required this.cityName,
    required this.clouds,
    required this.countryCode,
    required this.datetime,
    required this.dewpt,
    required this.dhi,
    required this.dni,
    required this.elevAngle,
    required this.ghi,
    this.gust,
    required this.hAngle,
    required this.lat,
    required this.lon,
    required this.obTime,
    required this.pod,
    required this.precip,
    required this.pres,
    required this.rh,
    required this.slp,
    required this.snow,
    required this.solarRad,
    required this.sources,
    required this.stateCode,
    required this.station,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.timezone,
    required this.ts,
    required this.uv,
    required this.vis,
    required this.weather,
    required this.windCdir,
    required this.windCdirFull,
    required this.windDir,
    required this.windSpd,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      appTemp: (json['app_temp'] ?? 0).toDouble(),
      aqi: (json['aqi'] ?? 0).toDouble(),
      cityName: json['city_name'] ?? '',
      clouds: (json['clouds'] ?? 0).toDouble(),
      countryCode: json['country_code'] ?? '',
      datetime: json['datetime'] ?? '',
      dewpt: (json['dewpt'] ?? 0).toDouble(),
      dhi: (json['dhi'] ?? 0).toDouble(),
      dni: (json['dni'] ?? 0).toDouble(),
      elevAngle: (json['elev_angle'] ?? 0).toDouble(),
      ghi: (json['ghi'] ?? 0).toDouble(),
      gust: (json['gust'] ?? null)?.toDouble(),
      hAngle: (json['h_angle'] ?? 0).toDouble(),
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
      obTime: json['ob_time'] ?? '',
      pod: json['pod'] ?? '',
      precip: (json['precip'] ?? 0).toDouble(),
      pres: (json['pres'] ?? 0).toDouble(),
      rh: (json['rh'] ?? 0).toDouble(),
      slp: (json['slp'] ?? 0).toDouble(),
      snow: (json['snow'] ?? 0).toDouble(),
      solarRad: (json['solar_rad'] ?? 0).toDouble(),
      sources: json['sources'] ?? [],
      stateCode: json['state_code'] ?? '',
      station: json['station'] ?? '',
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? '',
      temp: (json['temp'] ?? 0).toDouble(),
      timezone: json['timezone'] ?? '',
      ts: (json['ts'] ?? 0).toDouble(),
      uv: (json['uv'] ?? 0).toDouble(),
      vis: (json['vis'] ?? 0).toDouble(),
      weather: Weather.fromJson(json['weather']),
      windCdir: json['wind_cdir'] ?? '',
      windCdirFull: json['wind_cdir_full'] ?? '',
      windDir: (json['wind_dir'] ?? 0).toDouble(),
      windSpd: (json['wind_spd'] ?? 0).toDouble(),
    );
  }
}

class Weather {
  final int code;
  final String icon;
  final String description;

  Weather({
    required this.code,
    required this.icon,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      code: json['code'] ?? 0,
      icon: json['icon'] ?? '',
      description: json['description'] ?? 'Unknown',
    );
  }
}