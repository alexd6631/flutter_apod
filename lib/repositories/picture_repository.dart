import 'package:flutter_apod/models/picture.dart';
import 'package:flutter_apod/viewmodels/list_pictures_viewmodel.dart';

class PictureRepositoryImpl implements PictureRepository {
  final String baseUrl;

  PictureRepositoryImpl(this.baseUrl);

  @override
  Future<List<Picture>> getPictures(DateTime from, DateTime to) async =>
      dateRangeIterable(from, to).map((d) {
        final local = d.formatLocal();
        return Picture(
          local,
          "$baseUrl/preview-256-$local.jpg",
          "$baseUrl/$local.jpg",
        );
      }).toList(growable: false);
}

extension on DateTime {
  String formatLocal() => "$year-${_zeroPad(month)}-${_zeroPad(day)}";
}

String _zeroPad(int n) =>
  n.toString().padLeft(2, '0');

Iterable<DateTime> dateRangeIterable(DateTime from, DateTime to) sync* {
  var current = from;
  while (current.isAfter(to)) {
    yield current;
    current = current.subtract(Duration(days: 1));
  }
}
