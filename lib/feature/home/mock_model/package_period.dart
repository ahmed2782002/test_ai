enum PackagePeriod {
  monthly('home.period.monthly'),
  weekly('home.period.weekly');

  final String translationKey;

  const PackagePeriod(this.translationKey);
}
