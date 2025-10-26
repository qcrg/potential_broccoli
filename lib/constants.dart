enum Months {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  factory Months.fromDateTime(DateTime dt) {
    return Months.fromInt(dt.month - 1);
  }

  // month: 0-11
  factory Months.fromInt(int month) {
    if (month < 0 || month >= Months.values.length) {
      throw ArgumentError("");
    }
    return Months.values[month];
  }
}

void foo() {}
