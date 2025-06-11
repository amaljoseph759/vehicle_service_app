import 'package:flutter/material.dart';

class BuildTile extends StatelessWidget {
  const BuildTile({super.key, this.icon, this.title, this.onTap});

  final IconData? icon;
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue.shade700),
            SizedBox(height: 10),
            Text(title ?? "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
    ;
  }
}
