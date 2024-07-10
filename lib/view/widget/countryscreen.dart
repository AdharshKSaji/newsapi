import 'package:flutter/material.dart';
import 'package:newsapi/controller/homescreencontroller.dart';
import 'package:newsapi/view/homescreen.dart';
import 'package:provider/provider.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    final countryprov = Provider.of<HomeScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select your country",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: countryprov.country.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              countryprov.getCOuntry(countryprov.country[index]);
              setState(() {});
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false);
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(countryprov.flag[index]),
                      fit: BoxFit.contain),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(countryprov.country[index].toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}