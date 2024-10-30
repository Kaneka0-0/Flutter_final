
import 'package:flutter/material.dart';

import 'package:final_module/final_module/fakeapi_model.dart';
import 'package:final_module/final_module/language_constant.dart';
import 'package:final_module/final_module/language_logic.dart';
import 'package:final_module/final_module/theme_logic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'apireading_screen.dart';
import 'search_screen.dart';
import 'aboutus_screen.dart';
import 'detail_screen.dart';
import 'package:provider/provider.dart'; // Added provider for state management


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _currentIndex = 0;
  List<dynamic> newsHeadlines = [];
  int _langIndex = 0; // Language state
  Language _lang = Language();

  // Categories
  final List<String> categories = ['National', 'Business', 'Technology', 'Health'];

  final List<Widget> _children = [
    ApiReadingScreen(),
    SearchScreen(),
    AboutUsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  // Fetch news data from API
  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://api.currentsapi.services/v1/latest-news?apiKey=ssAkKH_OVOisCqPTwVern40SsatSd1I7fVwavmIp1wwWN4YC'), // Replace with your actual API key
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        newsHeadlines = data['news'] ?? [];
      });
    } else {
      print('Failed to load news');
    }
  }

  // Convert publish time to a readable format
  String _timeAgo(String timestamp) {
    DateTime publishTime = DateTime.parse(timestamp);
    Duration difference = DateTime.now().difference(publishTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    _langIndex = context.watch<LanguageLogic>().languageIndex;
    _lang = context.watch<LanguageLogic>().lang;
    // Determine the current theme
  bool isDarkTheme = context.watch<ThemeLogic>().themeIndex == 0;
      return Scaffold(
    appBar: AppBar(
      title: Text(_lang.appName),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(isDarkTheme ? Icons.light_mode : Icons.dark_mode),  // Change icons based on theme
          onPressed: () {
            // Toggle theme action
            if (isDarkTheme) {
              context.read<ThemeLogic>().changeToLight(); // Change to light theme
            } else {
              context.read<ThemeLogic>().changeToDark(); // Change to dark theme
            }
          },
        ),
      ],
    ),
      body: _currentIndex == 0 ? buildNewsBody() : _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
           BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'News'),
           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
           BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  
  // Main news body with scrollable highlights and top headlines
  Widget buildNewsBody() {
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          color: Theme.of(context).chipTheme.labelStyle?.color, // Use the theme's text color
                        ),
                      ),
                      backgroundColor: Theme.of(context).chipTheme.backgroundColor, // Use the theme's background color
                    ),
                );
              },
            ),
          ),
          Container(
            height: 200,
            color: Theme.of(context).cardColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsHeadlines.length,
              itemBuilder: (context, index) {
                final headline = newsHeadlines[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(news: News.fromJson(headline)),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(headline['image'] ?? 'https://via.placeholder.com/150'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 150,
                          child: Text(
                            headline['title'] ?? 'No title',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _timeAgo(headline['published']),
                          //style: Theme.of(context).textTheme.published,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: newsHeadlines.length,
            itemBuilder: (context, index) {
              final article = newsHeadlines[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(article['image'] ?? 'https://via.placeholder.com/100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    article['title'] ?? 'No title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['description'] ?? 'No description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _timeAgo(article['published']),
                       // style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Theme.of(context).iconTheme.color),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(news: News.fromJson(article)),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    int themeIndex = context.watch<ThemeLogic>().themeIndex;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Icon(Icons.face)),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(_lang.home),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ExpansionTile(
            title: Text(_lang.theme),
            initiallyExpanded: true,
            children: [
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(_lang.darkMode),
                trailing: themeIndex == 0 ? const Icon(Icons.check) : null,
                onTap: () {
                  context.read<ThemeLogic>().changeToDark();
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: Text(_lang.lightMode),
                trailing: themeIndex == 1 ? const Icon(Icons.check) : null,
                onTap: () {
                  context.read<ThemeLogic>().changeToLight();
                },
              ),

            ],
          ),
          ExpansionTile(
            title: Text(_lang.language),
            initiallyExpanded: true,
            children: [
              ListTile(
                leading: const Text("ខ្មែរ"),
                title: Text(_lang.toKhmer),
                trailing: _langIndex == 1 ? const Icon(Icons.check) : null,
                onTap: () {
                  context.read<LanguageLogic>().changeToKhmer();
                },
              ),
              ListTile(
                leading: const Text("EN"),
                title: Text(_lang.toEnglish),
                trailing: _langIndex == 0 ? const Icon(Icons.check) : null,
                onTap: () {
                  context.read<LanguageLogic>().changeToEnglish();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
