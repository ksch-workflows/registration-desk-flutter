import 'package:registration_desk/utils/singleton_bucket.dart';
import 'package:registration_desk/widgets/form_stepper/form_stepper.dart';
import 'package:test/test.dart';

void main() {
  test('Should register dialog model', () {
    var firstRetrieval = SingletonBucket.get(() => ExampleDialogModel())!;
    expect(firstRetrieval, isNotNull);
    firstRetrieval.selectedShoeSize.value = 42;
    var secondRetrieval = SingletonBucket.get(() => ExampleDialogModel())!;
    expect(secondRetrieval.selectedShoeSize.value, equals(42));
  });

  test('Should reset dialog model', () {
    var firstRetrieval = SingletonBucket.get(() => ExampleDialogModel())!;
    firstRetrieval.selectedShoeSize.value = 42;
    var secondRetrieval = SingletonBucket.get(() => ExampleDialogModel())!;
    expect(secondRetrieval.selectedShoeSize.value, isNotNull);

    SingletonBucket.reset<ExampleDialogModel>();

    var thirdRetrieval = SingletonBucket.get(() => ExampleDialogModel())!;
    expect(thirdRetrieval.selectedShoeSize.value, isNull);
  });
}

class ExampleDialogModel {
  final selectedShoeSize = FormValue<int>();

  ExampleDialogModel() {
    print('[INFO] Constructor called');
  }
}
