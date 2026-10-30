import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearch extends StatefulWidget {
  const RecentSearch({super.key});

  @override
  State<RecentSearch> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  List<String> recentSearches = [];
  final String _storageKey = 'recent_searches_key';

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList(_storageKey) ?? [];
    });
  }

  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, recentSearches);
  }

  void addSearchQuery(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      setState(() {
        recentSearches.insert(0, query);
      });
      _saveRecentSearches();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    recentSearches.clear();
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove(_storageKey);
                },
                child: const Text(
                  "Clear all",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.history, color: Colors.grey, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          recentSearches[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          recentSearches.removeAt(index);
                        });
                        _saveRecentSearches();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
