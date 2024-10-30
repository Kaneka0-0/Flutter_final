import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_module/final_module/theme_logic.dart';
import 'package:final_module/final_module/language_logic.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<String> recentSearches = ['Flutter', 'Dart', 'Programming', 'Mobile Development'];
  List<String> recommendations = ['UI Design', 'API Integration', 'State Management'];

  @override
  Widget build(BuildContext context) {
    // Access theme and language from the providers
    final themeLogic = Provider.of<ThemeLogic>(context);
    final languageLogic = Provider.of<LanguageLogic>(context);
    final isDarkTheme = themeLogic.themeIndex == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(languageLogic.lang.appName), // Dynamic app name
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search input field
            TextField(
              decoration: InputDecoration(
                labelText: languageLogic.lang.home1, // Label in selected language
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: isDarkTheme ? Colors.blue : Colors.blue, width: 2.0),
                ),
                hintText: languageLogic.lang.search, // Hint text in selected language
                hintStyle: TextStyle(color: isDarkTheme ? Colors.grey[400] : Colors.grey[600]),
              ),
              style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
            const SizedBox(height: 20),
            // Recent searches section
            _buildSearchSection(
              languageLogic.lang.recent, 
              recentSearches, 
              isDarkTheme
            ),
            const SizedBox(height: 20),
            // Recommendations section
            _buildSearchSection(
              languageLogic.lang.recommendation, 
              recommendations, 
              isDarkTheme
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the search section
  Widget _buildSearchSection(String title, List<String> items, bool isDarkTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  backgroundColor: isDarkTheme ? Colors.blueGrey[700] : Colors.blueAccent[100],
                  label: Text(
                    items[index],
                    style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
                  ),
                  onDeleted: title == LanguageLogic().lang.recent
                      ? () {
                          setState(() {
                            recentSearches.removeAt(index);
                          });
                        }
                      : null,
                  deleteIcon: title == LanguageLogic().lang.recommendation
                      ? Icon(Icons.clear, color: isDarkTheme ? Colors.white : Colors.black)
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
