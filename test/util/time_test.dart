import 'package:registration_desk/utils/time.dart';
import 'package:test/test.dart';

void main() {

  test('Should format time', () async {
    var time = const Time(hour: 20, minute: 40);
    var date = const Date(year: 2021, month: 10, day: 13);

    var result = time.atDate(date).toFormattedString();

    expect(result, equals('Wednesday, 13-10-2021, 8:40p.m.'));
  });

}
