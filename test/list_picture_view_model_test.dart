import 'package:flutter_apod/models/picture.dart';
import 'package:flutter_apod/viewmodels/list_pictures_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiver/testing/async.dart';
import 'package:quiver/time.dart';

Future simpleTest(Clock clock) async {
  print("Started: ${clock.now()}");
  await Future.delayed(Duration(milliseconds: 200));
  print("Part 1: ${clock.now()}");
  await Future.delayed(Duration(milliseconds: 200));
  print("Part 2: ${clock.now()}");
}

void main() {
  test("Test", () {
    FakeAsync().run((async) {
      print("Started test");
      final clock = async.getClock(DateTime(2021));
      simpleTest(clock);
      async.elapse(Duration(milliseconds: 200));
      print("test ${clock.now()}");
      async.elapse(Duration(milliseconds: 200));
      print("test ${clock.now()}");
      print("Done test");
    });
  });

  test("Test ListPictureViewModel", () {
    FakeAsync().run((async) {
      final time = DateTime(2021, 3, 1);
      final mock = _PictureRepositoryMock();
      final viewModel = ListPictureViewModel(mock, initialTime: time);

      expect(viewModel.isLoading, true);
      expect(viewModel.pictures.length, 0);

      async.elapse(Duration(milliseconds: 500));

      expect(viewModel.isLoading, false);
      expect(viewModel.pictures.length, 3);

      viewModel.loadMore();
      expect(viewModel.isLoading, true);
      async.elapse(Duration(milliseconds: 500));
      expect(viewModel.pictures.length, 4);

      expect(
        viewModel.pictures.map((p) => p.title),
        ["1", "2", "3", "4"],
      );
    });
  });
}

class _PictureRepositoryMock implements PictureRepository {
  @override
  Future<List<Picture>> getPictures(DateTime from, DateTime to) async {
    print("$from, $to");

    await Future.delayed(Duration(milliseconds: 500));
    if (from.month == 3) {
      return [
        Picture("1", "1", "1"),
        Picture("2", "2", "2"),
        Picture("3", "3", "3"),
      ];
    } else {
      return [Picture("4", "4", "4")];
    }
  }
}
