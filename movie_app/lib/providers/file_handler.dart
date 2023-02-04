import 'dart:convert';
import 'dart:io';

import 'package:movie_app/models/movies/movie.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  FileHandler._privateConstructor();
  static final FileHandler instance = FileHandler._privateConstructor();

  static File? _file;
  static const _fileName = 'favorites.json';
  static Set<Movie> movieSet = {};

  // Gets the "favorites.json" file from local storage
  // If the file doesn't exist, it creates it first
  Future<File> get file async {
    if (_file != null) {
      return _file!;
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      if (File('$path/$_fileName').existsSync()) {
        _file = File('$path/$_fileName');
        return _file!;
      } else {
        _file = await _initFile();
        return _file!;
      }
    }
  }

  // Creates "favorites.json" file
  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$_fileName').create(recursive: true);
  }

  // This method reads favorite movies from JSON file
  // and then appends new movie to the end of the list
  // After that it writes that updated list back to the file
  Future<void> writeMovie(Movie favoriteMovie) async {
    final File fl = await file;
    List<Movie> oldFavoriteMovies = [];
    oldFavoriteMovies =
        await readFavoriteMovies().then((value) => oldFavoriteMovies = value);
    movieSet = oldFavoriteMovies.toSet();
    movieSet.add(favoriteMovie);
    final movieListMap = movieSet.map((e) => e.toJson()).toList();
    await fl.writeAsString(jsonEncode(movieListMap));
  }

  // Reads and returns list of movies from JSON file
  Future<List<Movie>> readFavoriteMovies() async {
    final File fl = await file;
    String content = "";
    content = await fl.readAsString();
    if (content.isEmpty) {
      return [];
    } else {
      final List<dynamic> jsonData = jsonDecode(content);
      final List<Movie> favoriteMovies = jsonData
          .map(
            (e) => Movie.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return favoriteMovies;
    }
  }

  // Deletes a movie from JSON file
  Future<void> deleteFavoriteMovie(Movie favoriteMovie) async {
    final File fl = await file;
    List<Movie> oldFavoriteMovies = [];
    oldFavoriteMovies =
        await readFavoriteMovies().then((value) => oldFavoriteMovies = value);
    movieSet = oldFavoriteMovies.toSet();
    movieSet.removeWhere((e) => e == favoriteMovie);
    final movieListMap = movieSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(movieListMap));
  }
}
