import 'package:meta/meta.dart';

Object any() => _AnyRequestBody();

@immutable
class _AnyRequestBody {
  bool operator ==(_) => true;

  int get hashCode => 1;
}
