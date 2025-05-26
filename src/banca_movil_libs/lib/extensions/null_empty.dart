extension NullOrEmptyCheck<T> on T {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }

    if (this is String) {
      return (this as String).isEmpty;
    }

    if (this is Iterable) {
      return (this as Iterable).isEmpty;
    }

    if (this is Map) {
      return (this as Map).isEmpty;
    }

    return false;
  }
}
