class RSVModel {
  final BigInt r;
  final BigInt s;
  final int v;

  RSVModel({required this.r, required this.s, required this.v});

  @override
  String toString() => 'RSVModel(r: $r, s: $s, v: $v)';
}
