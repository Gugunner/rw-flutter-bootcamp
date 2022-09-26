extension OptionalStringExtend on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  bool get isNull => this == null;

  bool get isNotNull => this != null;
}
