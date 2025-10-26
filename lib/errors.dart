class ErrType extends Error {
  final String message;

  ErrType(this.message);

  @override
  String toString() {
    return "Error: $message";
  }
}

typedef Err = ErrType?;
typedef FutErr = Future<Err>;
