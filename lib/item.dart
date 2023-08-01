class Item<T> {
  bool isSelected = false;
  T data;
  int? dataCount;
  Item(this.data, [this.dataCount]);
}
