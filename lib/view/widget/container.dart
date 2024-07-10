import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:newsapi/model/newsnodel.dart';

class ContinerWidget extends StatelessWidget {
  const ContinerWidget({Key? key, required this.articles}) : super(key: key);
  
  final Article? articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
        backgroundColor: Colors.blue, // Customize app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Adjust padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: CachedNetworkImage(
                      imageUrl: articles?.urlToImage ?? "",
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Placeholder widget while loading
                      errorWidget: (context, url, error) => Image.asset("assets/image/no-image.png"), // Error widget if image fails to load
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          articles?.title ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          articles?.description ?? "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          articles?.content ?? "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse(articles?.url ?? ""));
                          },
                          child: Text("Read more"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
