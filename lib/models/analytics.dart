// ignore_for_file: public_member_api_docs, sort_constructors_first
class Analytics {
  final String? label;
  final int? totalEarning;
  Analytics({
    required this.label,
    required this.totalEarning,
  });
}

class IndividualBar {
  final int x;
  final int y;
  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarDataModel {
  final int mobileEarnings;
  final int essentialsEarnings;
  final int appliancesEarnings;
  final int booksEarnings;
  final int fashionEarnings;
  BarDataModel({
    required this.mobileEarnings,
    required this.essentialsEarnings,
    required this.appliancesEarnings,
    required this.booksEarnings,
    required this.fashionEarnings,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: mobileEarnings),
      IndividualBar(x: 1, y: essentialsEarnings),
      IndividualBar(x: 2, y: appliancesEarnings),
      IndividualBar(x: 3, y: booksEarnings),
      IndividualBar(x: 4, y: fashionEarnings),
    ];
  }
}
