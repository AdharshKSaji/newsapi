import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapi/controller/homescreencontroller.dart';
import 'package:newsapi/view/widget/container.dart';
import 'package:newsapi/view/widget/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDropdown;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await context.read<HomeScreenController>().getCategoryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<HomeScreenController>(context);

    return DefaultTabController(
      length: providerObj.category.length,
      child: Scaffold(backgroundColor: Color.fromARGB(255, 27, 224, 228),
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 27, 224, 228),
          centerTitle: true,
          title: Text(
            "WORLD NEWS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {
                
                Navigator.push(context,MaterialPageRoute(builder: (context) => SearchScreen(),));
              },
              icon: Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {
              providerObj.getCategory(value);
            },
            isScrollable: true,
            tabs: List.generate(
              providerObj.category.length,
              (index) => Tab(
                text: "${providerObj.category[index].toUpperCase()}",
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Choose Language',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                title: Text('Language Option 1'),
                onTap: () {
                  // Handle language selection
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Language Option 2'),
                onTap: () {
                  // Handle language selection
                  Navigator.pop(context);
                },
              ),
              // Add more language options as needed
            ],
          ),
        ),
        body: providerObj.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContinerWidget(
                          articles:
                              providerObj.restbyCategory?.articles?[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: providerObj.restbyCategory
                                  ?.articles?[index].urlToImage ??
                              "",
                          errorWidget: (context, url, error) =>
                              Image.asset("asset/image/no-image-icon-11.png"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          providerObj.restbyCategory?.articles?[index].title ??
                              "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          providerObj.restbyCategory
                                  ?.articles?[index].description ??
                              "",
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemCount: providerObj.restbyCategory?.articles?.length ?? 0,
              ),
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate<String> {
  final HomeScreenController provider;

  NewsSearchDelegate(this.provider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results UI here
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions UI here (optional)
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}
