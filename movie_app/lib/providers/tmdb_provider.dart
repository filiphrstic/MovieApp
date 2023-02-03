import 'package:dio/dio.dart';
import 'package:movie_app/classes/cast_members_response.dart';
import 'package:movie_app/classes/movie_response.dart';
import 'package:movie_app/utilities/environment_variables.dart';

class TmdbProvider {
  final Dio dio = Dio();

  Future<MovieResponse> fetchPopularMovies(int page) async {
    final String urlPopularMovies =
        '${EnvironmentConfig.BASE_URL}movie/popular?api_key=${EnvironmentConfig.API_KEY}&page=$page';
    try {
      Response response = await dio.get(urlPopularMovies);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      return MovieResponse.withError("Data not found / Connection issue");
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

  Future<MovieResponse> fetchSearchResults(String query) async {
    final String urlSearch =
        '${EnvironmentConfig.BASE_URL}search/movie?api_key=${EnvironmentConfig.API_KEY}&query=$query';
    try {
      Response response = await dio.get(urlSearch);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      return MovieResponse.withError("Data not found / Connection issue");
    }
  }
}

class NetworkError extends Error {}
