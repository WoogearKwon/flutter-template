class UiResumedAction {
  final dynamic additionalData;

  UiResumedAction({
    this.additionalData,
  });

  Map<String, dynamic> toJson() {
    return {
      'additionalData': additionalData,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
