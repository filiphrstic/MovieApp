// ignore_for_file: constant_identifier_names

class EnvironmentConfig {
  // API variables
  static const BASE_URL = String.fromEnvironment('BASE_URL',
      defaultValue: "https://api.themoviedb.org/3/");
  static const IMAGE_BASE_URL = String.fromEnvironment('IMAGE_BASE_URL',
      defaultValue: "https://image.tmdb.org/t/p/w500");
  static const API_KEY = String.fromEnvironment('API_KEY',
      defaultValue: "6cbea4db93d3f3cbf40cfa7958876cb5");
  static const NO_IMAGE_PATH = String.fromEnvironment('NO_IMAGE_PATH',
      defaultValue: "https://i.imgur.com/DiIF5t6.jpeg");
}
