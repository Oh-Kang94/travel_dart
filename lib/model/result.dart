class Result {
  final String? name;
  final String? si;
  final String? gu;
  final String? dong;

  Result({
    required this.name,
    required this.si,
    required this.gu,
    required this.dong,
  });

  Result copyWith({String? name, String? si, String? gu, String? dong}) {
    return Result(
      name: name ?? this.name,
      si: si ?? this.si,
      gu: gu ?? this.gu,
      dong: dong ?? this.dong,
    );
  }

  @override
  String toString() {
    return '$si $gu $dong';
  }
}
