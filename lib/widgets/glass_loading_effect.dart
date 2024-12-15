import 'package:flutter/material.dart';

class GlassLoadingEffect extends StatelessWidget {
  const GlassLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        4,
        (index) => AnimatedOpacity(
          opacity: index % 2 == 0 ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 12,
                  width: 50,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
