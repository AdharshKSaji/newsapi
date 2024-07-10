import 'package:flutter/material.dart';
import 'package:newsapi/controller/homescreencontroller.dart';
import 'package:provider/provider.dart'; 


class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter search query',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Initiate search when search icon is pressed
                    _startSearch(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Initiate search when button is pressed
                _startSearch(context);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  void _startSearch(BuildContext context) {
    final controller = Provider.of<HomeScreenController>(context, listen: false);
    String query = _searchController.text.trim();
    
    if (query.isNotEmpty) {
      controller.searchNews(query); // Call searchNews function from controller
    } else {
      // Handle empty query case (optional)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Empty Search'),
          content: Text('Please enter a search query.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
