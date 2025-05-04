import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import 'search_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> allItems = [
    MenuItem(
      name: 'Chicken Crunch Burger',
      description:
          'It is a long established fact that a reader will be distracted.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 209,
    ),
    MenuItem(
      name: 'Mighty Chicken Patty Burger',
      description:
          'It is a long established fact that a reader will be distracted.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 259,
    ),
    MenuItem(
      name: 'Donut Header Chicken',
      description:
          'It is a long established fact that a reader will be distracted.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 199,
    ),
    MenuItem(
      name: 'Chicken Slab Burger',
      description:
          'It is a long established fact that a reader will be distracted.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 259,
    ),
    MenuItem(
      name: 'Double Cheese Deluxe',
      description:
          'Double patty loaded with two layers of melted cheese and special sauce.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 299,
    ),
    MenuItem(
      name: 'Veggie Supreme',
      description:
          'Plant-based patty with fresh vegetables and homemade vegan mayo.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 229,
    ),
    MenuItem(
      name: 'BBQ Bacon Combo',
      description:
          'Juicy beef patty with crispy bacon strips and tangy BBQ sauce.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 319,
    ),
    MenuItem(
      name: 'Spicy Jalapeño Burger',
      description:
          'Hot and spicy burger with jalapeños, pepper jack cheese and spicy mayo.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 249,
    ),
    MenuItem(
      name: 'Mushroom Swiss Burger',
      description:
          'Beef patty topped with sautéed mushrooms and melted Swiss cheese.',
      imageUrl:
          'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
      price: 279,
    ),
  ];

  Map<MenuItem, int> cart = {};

  void addToCart(MenuItem item) {
    setState(() {
      cart[item] = (cart[item] ?? 0) + 1;
      item.quantity = cart[item]!;
    });
  }

  void removeFromCart(MenuItem item) {
    setState(() {
      if (cart[item] != null && cart[item]! > 0) {
        cart[item] = cart[item]! - 1;
        item.quantity = cart[item]!;
        if (cart[item] == 0) cart.remove(item);
      }
    });
  }

  int get totalItems => cart.values.fold(0, (a, b) => a + b);
  int get totalPrice =>
      cart.entries.fold(0, (a, b) => a + b.key.price * b.value);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Banner Image with overlaid buttons
            Stack(
              children: [
                // Banner Image
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://blog-content.omahasteaks.com/wp-content/uploads/2023/02/The-Mack-Burger-recipe-scaled.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Buttons overlay
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.black,
                            weight: 900, // Make the icon bold
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                                weight: 900,
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => SearchPage(
                                          allItems: allItems,
                                          cart: cart,
                                          onAdd: addToCart,
                                          onRemove: removeFromCart,
                                        ),
                                  ),
                                );
                                setState(() {}); // Refresh cart after search
                              },
                            ),
                          ),
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share_outlined,
                                size: 20,
                                color: Colors.black,
                                weight: 900,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sharing restaurant'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Restaurant Info (with white background)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Amerika Foods',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: () {},
                          constraints: const BoxConstraints(
                            minHeight: 36,
                            minWidth: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'American, Fast Food, Burgers',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text('4.5'),
                      SizedBox(width: 4),
                      Text(' | ', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.chat, color: Colors.green, size: 18),
                      SizedBox(width: 4),
                      Text('1K+ reviews'),
                      SizedBox(width: 4),
                      Text(' | ', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.access_time, color: Colors.blue, size: 18),
                      SizedBox(width: 4),
                      Text('15 mins'),
                    ],
                  ),
                ],
              ),
            ),
            // Separator between restaurant info and tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 2, color: Colors.grey[300]),
            ),
            // Tabs
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _tabWithIndicator('Recommended', true),
                        _tabWithIndicator('Combos', false),
                        _tabWithIndicator('Regular Burgers', false),
                        _tabWithIndicator('Specials', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Menu List
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
                    final item = allItems[index];
                    return menuItemTile(item);
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            totalItems > 0
                ? BottomAppBar(
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$totalItems item',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' | ', style: TextStyle(color: Colors.grey)),
                        Text(
                          '₹ $totalPrice',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'View cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : null,
      ),
    );
  }

  Widget tab(String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.green : Colors.black54,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _tabWithIndicator(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: selected ? Colors.green : Colors.grey.shade300,
            width: 2.0,
          ),
        ),
        // Shrink the indicator to be narrower than the text
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.green : Colors.black54,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget menuItemTile(MenuItem item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with proper alignment
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8), // Reduced padding here
                    Row(
                      children: [
                        Text(
                          '₹ ${item.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        // Separate containers for plus and minus buttons
                        Row(
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      item.quantity > 0
                                          ? Colors.green.shade300
                                          : Colors.grey.shade300,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color:
                                    item.quantity > 0
                                        ? Colors.green.shade100
                                        : Colors.white,
                              ),
                              child: InkWell(
                                onTap:
                                    item.quantity > 0
                                        ? () => removeFromCart(item)
                                        : null,
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color:
                                      item.quantity > 0
                                          ? Colors.green
                                          : Colors.grey.shade300,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              height: 24,
                              alignment: Alignment.center,
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color: Colors.green.shade100,
                              ),
                              child: InkWell(
                                onTap: () => addToCart(item),
                                child: const Icon(
                                  Icons.add,
                                  size: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 1, color: Colors.grey[300]),
        ),
      ],
    );
  }
}
