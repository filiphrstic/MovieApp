import 'package:flutter/material.dart';

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

AssetImage buildLoadingGif() {
  return const AssetImage('lib/assets/images/loading.gif');
}
