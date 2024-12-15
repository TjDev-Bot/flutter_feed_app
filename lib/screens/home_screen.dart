import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/glass_loading_effect.dart';
import '../widgets/product_card.dart';
import '../widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  String _selectedSort = 'lower';

  late Future<List<String>> _categoriesFuture;
  late Future<List<dynamic>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = ApiService.fetchCategories();
    _productsFuture = ApiService.fetchProducts();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _productsFuture = ApiService.fetchProductsByCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF7A6EAE),
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(16.0),
            ),
            Container(
              color: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose from any category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<String>>(
                    future: _categoriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const GlassLoadingEffect();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Failed to load categories.'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No categories found.'),
                        );
                      }

                      final categories = snapshot.data!;
                      final categoryImages = {
                        'electronics':
                            'https://cdn.pixabay.com/photo/2019/09/25/14/09/gadgets-4503773_1280.jpg',
                        'jewelery':
                            'https://cdn.pixabay.com/photo/2015/12/13/05/45/jewels-1090711_960_720.jpg',
                        'men\'s clothing':
                            'https://cdn.pixabay.com/photo/2018/02/08/11/54/male-3139289_1280.jpg',
                        'women\'s clothing':
                            'https://cdn.pixabay.com/photo/2024/05/08/10/05/women-8747913_1280.jpg',
                      };

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: categories.map((category) {
                          return CategoryItem(
                            category: category,
                            imageUrl: categoryImages[category] ??
                                'https://via.placeholder.com/70', // Fallback image
                            isSelected: _selectedCategory == category,
                            onSelect: _onCategorySelected,
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<dynamic>>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const GlassLoadingEffect();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Failed to load products.'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No products available.'),
                        );
                      }

                      List<dynamic> products = List.from(snapshot.data!);
                      if (_selectedSort == 'lower') {
                        products.sort((a, b) =>
                            (a['price'] as num).compareTo(b['price'] as num));
                      } else {
                        products.sort((a, b) =>
                            (b['price'] as num).compareTo(a['price'] as num));
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${products.length} products to choose from',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _buildSortButton('Lower Price First', 'lower'),
                              const SizedBox(width: 10),
                              _buildSortButton('Higher Price First', 'higher'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductCard(product: product);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton(String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
        decoration: BoxDecoration(
          color: _selectedSort == value
              ? const Color(0xFF7A6EAE)
              : const Color(0xFFCACACA),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: _selectedSort == value ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
