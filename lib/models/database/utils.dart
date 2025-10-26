extension MapExtension<T, E> on Map<T, E> {
  void set_if_not_null(T key, E? value) {
    if (value != null) this[key] = value;
  }
}
