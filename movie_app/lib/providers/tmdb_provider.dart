import 'package:dio/dio.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/utilities/environment_variables.dart';

class TmdbProvider {
  final Dio dio = Dio();
  final String url =
      '${EnvironmentConfig.BASE_URL}movie/popular?api_key=${EnvironmentConfig.API_KEY}';

  Future<PopularMoviesResponse> fetchPopularMovies() async {
    print('test');
    try {
      Response response = await dio.get(url);
      print(response.data.toString());
      return PopularMoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PopularMoviesResponse.withError(
          "Data not found / Connection issue");
    }
  }
}

class NetworkError extends Error {}
