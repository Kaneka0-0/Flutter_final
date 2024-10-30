import 'package:flutter/material.dart';
import 'fakeapi_model.dart';

class DetailScreen extends StatelessWidget {
  final News news;

  const DetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color; // Main text color

    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.title,
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    news.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                news.title,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person, color: theme.iconTheme.color, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'Author: ${news.author}',
                    style: theme.textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: theme.iconTheme.color, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'Published: ${news.published}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                news.description,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              Text(
                'Read more at:',
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Open URL in browser
                },
                child: Text(
                  news.url,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: news.category.map((category) => Chip(
                  label: Text(category, style: theme.textTheme.bodyMedium?.copyWith(color: textColor)),
                  backgroundColor: theme.chipTheme.backgroundColor,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
