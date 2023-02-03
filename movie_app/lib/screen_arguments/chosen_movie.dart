import 'package:movie_app/classes/movie.dart';

//This class is used as a screen argument to pass a specific
//movie from one screen to another (i.e. from Homepage to Movie details)

class ChosenMovie {
  final Movie chosenMovie;

  ChosenMovie(this.chosenMovie);
}
