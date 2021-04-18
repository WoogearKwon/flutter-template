enum Qualifier {
  apiClient,
  tokenClient,
}

extension QualifierExtension on Qualifier {
  String get rawValue => toString().split('.').last;
}