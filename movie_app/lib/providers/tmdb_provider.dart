import 'package:dio/dio.dart';
import 'package:movie_app/classes/cast_members_response.dart';
import 'package:movie_app/classes/popular_movies_response.dart';
import 'package:movie_app/utilities/environment_variables.dart';

class TmdbProvider {
  final Dio dio = Dio();
  final String urlPopularMovies =
      '${EnvironmentConfig.BASE_URL}movie/popular?api_key=${EnvironmentConfig.API_KEY}';

  Future<PopularMoviesResponse> fetchPopularMovies(int page) async {
    try {
      Response response = await dio.get('$urlPopularMovies&page=$page');
      return PopularMoviesResponse.fromJson(response.data);
    } catch (error) {
      return PopularMoviesResponse.withError(
          "Data not found / Connection issue");
    }
  }

  Future<CastMembersResponse> fetchCastMembers(int movieID) async {
    final String urlCastMembers =
        '${EnvironmentConfig.BASE_URL}movie/$movieID/credits?api_key=${EnvironmentConfig.API_KEY}';
    try {
      Response response = await dio.get(urlCastMembers);
      return CastMembersResponse.fromJson(response.data);
    } catch (error) {
      return CastMembersResponse.withError("Data not found / Connection issue");
    }
  }

  Future<PopularMoviesResponse> fetchSearchResults(String query) async {
    final String urlSearch =
        '${EnvironmentConfig.BASE_URL}search/movie?api_key=${EnvironmentConfig.API_KEY}&query=$query';
    try {
      Response response = await dio.get(urlSearch);
      // print(response.data.toString());
      return PopularMoviesResponse.fromJson(response.data);
    } catch (error) {
      // print("Exception occured: $error stackTrace: $stacktrace");
      return PopularMoviesResponse.withError(
          "Data not found / Connection issue");
    }
  }
}

class NetworkError extends Error {}
