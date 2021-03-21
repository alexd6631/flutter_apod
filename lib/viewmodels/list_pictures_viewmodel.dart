import 'package:flutter/foundation.dart';
import 'package:flutter_apod/models/picture.dart';

class ListPictureViewModel extends ChangeNotifier {
  final PictureRepository repository;

  late DateTime currentTime;
  bool isLoading = false;
  var pictures = <Picture>[];

  ListPictureViewModel(this.repository, {DateTime? initialTime}) {
    currentTime = initialTime != null ? initialTime : DateTime.now();
    loadMore();
  }

  void loadMore() {
    if (isLoading) {
      return;
    }
    print("Loading more");

    isLoading = true;
    notifyListeners();

    final from = currentTime;
    final to = from.subtract(Duration(days: 30));

    repository.getPictures(from, to).asStream().listen((newPics) {
      isLoading = false;
      pictures.addAll(newPics);
      currentTime = to;
      notifyListeners();
    }, onError: (err) {
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  String toString() {
    return 'ListPictureViewModel{currentTime: $currentTime, isLoading: $isLoading, pictures: $pictures}';
  }
}

abstract class PictureRepository {
  Future<List<Picture>> getPictures(DateTime from, DateTime to);
}