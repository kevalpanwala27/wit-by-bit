class MenuItem {
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  int quantity;

  MenuItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });
}
