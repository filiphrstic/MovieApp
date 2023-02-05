import 'package:flutter/material.dart';
import 'package:movie_app/utilities/environment_variables.dart';
import 'package:movie_app/widgets/loading/loading_widgets.dart';

Widget buildImageUnavailable(double? width, double? height) {
  return SizedBox(
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.asset('lib/assets/images/image_unavailable.png'),
    ),
  );
}

Widget buildImage(double? width, double? height, String? path) {
  return SizedBox(
    width: width,
    height: height,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: FadeInImage(
        placeholder: buildLoadingGif(),
        image: NetworkImage(EnvironmentConfig.IMAGE_BASE_URL + path!),
      ),
    ),
  );
}
