import 'package:equatable/equatable.dart';

//This class containes all information needed about a movie
//Data is extracted from JSON response
//Method "toJson" is needed when saving a movie to favorites

class Movie extends Equatable {
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String voteAverage;
  final List<dynamic> genresIdList;

  const Movie({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genresIdList,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        originalTitle: (json['original_title'] != null)
            ? json['original_title']
            : "Title unavailable",
        overview: (json['overview'] != null)
            ? json['overview']
            : "Synopsis unavailable",
        posterPath: (json['poster_path'] != null) ? json['poster_path'] : "",
        releaseDate:
            (json['release_date'] != null && json['release_date'] != "")
                ? json['release_date']
                : "1900-01-01",
        voteAverage: (json['vote_average'] != null)
            ? json['vote_average'].toString()
            : "Rating unavailable",
        genresIdList: (json['genre_ids'] != null) ? json['genre_ids'] : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage
    };
  }

  @override
  List<Object?> get props => [id];
}
