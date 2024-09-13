String getCustomWeatherIcon(String condition) {
  switch (condition) {
    case "Blowing snow":
    case "Blizzard":
    case "Patchy light snow with thunder":
    case "Moderate or heavy snow with thunder":
      return "lib/assets/images/icons/windy.json";

    case "Thundery outbreaks possible":
    case "Patchy light rain with thunder":
    case "Moderate or heavy rain with thunder":
    case "Patchy light snow with thunder":
    case "Moderate or heavy snow with thunder":
      return "lib/assets/images/icons/thunder.json";

    case "Sunny":
      return "lib/assets/images/icons/sunny.json";

    case "Heavy rain at times":
    case "Heavy rain":
    case "Torrential rain shower":
    case "Moderate or heavy rain shower":
      return "lib/assets/images/icons/storm.json";

    case "Patchy light snow":
    case "Light snow":
    case "Patchy moderate snow":
    case "Moderate snow":
    case "Patchy heavy snow":
    case "Heavy snow":
      return "lib/assets/images/icons/snowy.json";

    case "Moderate rain":
    case "Patchy light rain":
    case "Light rain":
    case "Light rain shower":
      return "lib/assets/images/icons/rainy-sunny.json";

    case "Partly cloudy":
      return "lib/assets/images/icons/party-cloudy.json";

    case "Cloudy":
      return "lib/assets/images/icons/cloudy.json";

    case "Mist":
    case "Fog":
    case "Freezing fog":
      return "lib/assets/images/icons/misty.json";

    case "Patchy snow possible":
    case "Patchy sleet possible":
    case "Light sleet":
    case "Moderate or heavy sleet":
    case "Ice pellets":
    case "Moderate or heavy showers of ice pellets":
      return "lib/assets/images/icons/snowy.json";

    case "Heavy freezing drizzle":
    case "Moderate or heavy freezing rain":
    case "Patchy light rain with thunder":
    case "Moderate or heavy rain with thunder":
      return "lib/assets/images/icons/storm-rainning.json";

    case "Overcast":
      return "lib/assets/images/icons/foggy.json";

    default:
      return "lib/assets/images/icons/sunny.json";
  }
}
