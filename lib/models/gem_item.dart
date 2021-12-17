class GemItem {
  int? value;
  bool? isDestroying;
  bool? isCreating;

  GemItem({
    required this.value,
    this.isDestroying = false,
    this.isCreating = false,
  });
}
