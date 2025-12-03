import 'package:flutter/material.dart';
import '../data/blog_data.dart';
import 'blog_detail_screen.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header hijau muda
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: const Color(0xffd5f5e3),
              child: Column(
                children: const [
                  Text("Blog",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Our Blog For You",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Gambar seperti mockup
            Container(
              width: 120,
              height: 120,
              color: Colors.black,
            ),

            const SizedBox(height: 20),

            // Card artikel
            ...blogPosts.map((post) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withValues(alpha: 0.1),
                    )
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(post: post),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            post.excerpt,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),

            // Footer hijau seperti desain
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xff1e7f5c),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Minchicare",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Contact",
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 8),
                  Text("📞 +62 812-3456-7890",
                      style: TextStyle(color: Colors.white)),
                  Text("✉️ minchi@care.id",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 20),
                  Text("copyright 2025 │ All rights reserved",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
