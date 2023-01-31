import 'package:dio/dio.dart';
import 'package:movie_app/classes/cast_members_response.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/utilities/environment_variables.dart';

class TmdbProvider {
  final Dio dio = Dio();
  final String urlPopularMovies =
      '${EnvironmentConfig.BASE_URL}movie/popular?api_key=${EnvironmentConfig.API_KEY}';

  Future<PopularMoviesResponse> fetchPopularMovies() async {
    try {
      Response response = await dio.get(urlPopularMovies);
      print(response.data.toString());
      return PopularMoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PopularMoviesResponse.withError(
          "Data not found / Connection issue");
    }
  }

  Future<CastMembersResponse> fetchCastMembers(int movieID) async {
    final String urlCastMembers =
        '${EnvironmentConfig.BASE_URL}movie/$movieID/credits?api_key=${EnvironmentConfig.API_KEY}';
    try {
      Response response = await dio.get(urlCastMembers);
      print(response.data.toString());
      return CastMembersResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastMembersResponse.withError("Data not found / Connection issue");
    }
  }
}

class NetworkError extends Error {}
