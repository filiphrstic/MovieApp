import 'dart:convert';
import 'dart:io';

import 'package:movie_app/classes/movie.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  FileHandler._privateConstructor();
  static final FileHandler instance = FileHandler._privateConstructor();

  static File? _file;
  static const _fileName = 'favorites.json';

// Get the data file
  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
    // if (_file!.existsSync()) {
    //   return _file!;
    // }
    // else {
    //   new File('$path/counter.txt').create(recursive: true);
    // }
  }

// Inititalize file
  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$_fileName').create(recursive: true);
  }

  static Set<Movie> movieSet = {};

  Future<void> writeMovie(Movie favoriteMovie) async {
    final File fl = await file;
    movieSet.add(favoriteMovie);

    // Now convert the set to a list as the jsonEncoder cannot encode
    // a set but a list.
    final movieListMap = movieSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(movieListMap));
  }

  Future<List<Movie>> readFavoriteMovies() async {
    final File fl = await file;
    final content = await fl.readAsString();

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

  Future<void> deleteFavoriteMovie(Movie favoriteMovie) async {
    final File fl = await file;

    movieSet.removeWhere((e) => e == favoriteMovie);
    final movieListMap = movieSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(movieListMap));
  }
}
