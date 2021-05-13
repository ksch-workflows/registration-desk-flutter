/// Enables to temporarily discard dialogs and then resume the editing.
class SingletonBucket {

  static final Map<String, dynamic> _bucket = {};

  /// Returns the existing singleton instance for type <T> or creates a new one with the given creator.
  static T get<T>(T Function() creator) {
    return _bucket.putIfAbsent(T.toString(), creator);
  }
  
  static void reset<T>() {
    _bucket.remove(T.toString());
  }
}
