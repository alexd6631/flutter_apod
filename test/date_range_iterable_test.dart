import 'package:flutter_apod/repositories/picture_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test date range iterable", () {
    final from = DateTime(2020, 3, 5);
    final to = DateTime(2020, 3, 1);

    expect(dateRangeIterable(from, to).toList(), [
      DateTime(2020, 3, 5),
      DateTime(2020, 3, 4),
      DateTime(2020, 3, 3),
      DateTime(2020, 3, 2),
    ]);
  });
}
