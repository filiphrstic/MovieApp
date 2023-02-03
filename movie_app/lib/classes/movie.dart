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

  const Movie({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
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
      posterPath: (json['poster_path'] != null)
          ? json['poster_path']
          : "https://i.imgur.com/DiIF5t6.jpeg",
      releaseDate: (json['release_date'] != null)
          ? json['release_date']
          : "Release date unavailable",
      voteAverage: (json['vote_average'] != null)
          ? json['vote_average'].toString()
          : "Rating unavailable",
    );
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
