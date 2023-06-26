class FilterItem {
  final String name;
  final String assetPath;
  final String type;
  final int index;
  bool isSelected;

  FilterItem({
    required this.name,
    required this.isSelected,
    required this.assetPath,
    required this.type,
    required this.index,
  });

  @override
  String toString() {
    return '$type : $isSelected';
  }
}
