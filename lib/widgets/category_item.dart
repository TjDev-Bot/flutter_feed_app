import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  final String imageUrl;
  final bool isSelected;
  final Function(String) onSelect;

  const CategoryItem({
    super.key,
    required this.category,
    required this.imageUrl,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(category),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color.fromARGB(255, 79, 188, 199)
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  size: 70,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category[0].toUpperCase() + category.substring(1),
            style: const TextStyle(
              fontSize: 12,
              height: 2.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
