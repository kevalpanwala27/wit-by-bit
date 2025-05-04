import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class SearchPage extends StatefulWidget {
  final List<MenuItem> allItems;
  final Map<MenuItem, int> cart;
  final Function(MenuItem) onAdd;
  final Function(MenuItem) onRemove;

  const SearchPage({
    required this.allItems,
    required this.cart,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<MenuItem> filteredItems = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredItems = widget.allItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void updateSearch(String value) {
    setState(() {
      query = value;
      filteredItems =
          widget.allItems
              .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  int get totalItems => widget.cart.values.fold(0, (a, b) => a + b);
  int get totalPrice =>
      widget.cart.entries.fold(0, (a, b) => a + b.key.price * b.value);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            padding: const EdgeInsets.only(left: 8),
          ),
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black),
                const SizedBox(width: 8),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      scaffoldBackgroundColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        fillColor: Colors.white,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: updateSearch,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(backgroundColor: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic_none, color: Colors.black),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          actions: const [SizedBox(width: 8)],
          titleSpacing: 0,
        ),
        body:
            query.isEmpty
                ? searchSuggestions()
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${filteredItems.length} Search results...',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return menuItemTile(item);
                        },
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

  Widget menuItemTile(MenuItem item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    const SizedBox(height: 8),
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
                                        ? () {
                                          widget.onRemove(item);
                                          setState(() {});
                                        }
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
                                onTap: () {
                                  widget.onAdd(item);
                                  setState(() {});
                                },
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

  Widget searchSuggestions() {
    final suggestions = [
      'Burgers',
      'Chicken',
      'Fries',
      'Beverages',
      'Sides',
      'Desserts',
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Search recommendations', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                suggestions
                    .map(
                      (s) => GestureDetector(
                        onTap: () {
                          _searchController.text = s;
                          updateSearch(s);
                        },
                        child: Chip(
                          label: Text(s),
                          backgroundColor: Colors.green[50],
                          labelStyle: const TextStyle(color: Colors.green),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
