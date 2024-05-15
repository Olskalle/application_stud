import 'package:flutter/material.dart';

import '../services/apiService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

    @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  List<String> products = [
  ];

@override
  void initState() {
    super.initState();
    _populateProducts(); // Call the method to populate groups
  }

  void _populateProducts() async {
     try {
      List<String> fetchedGroups = await apiService.fetchProducts();
      setState(() {
        products = fetchedGroups;
      });
    } catch (e) {
      print('Error fetching groups: $e');
      // Handle error gracefully, e.g., show a snackbar or retry mechanism
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(46.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
          onSubmitted: (String value) {
            // Здесь логика поиска
            print('Пользователь ввёл для поиска: $value');
          },
          textInputAction: TextInputAction.search, // Устанавливаем действие клавиатуры на "поиск"
        ),
      ),
    );
  }
}
