import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi/model/newsnodel.dart'; // Make sure to import your NewsApiRestModel or relevant model class here

class HomeScreenController with ChangeNotifier {
  List<String> flag = [
    "https://icon-library.com/images/india-flag-icon/india-flag-icon-29.jpg",
    "https://images.vexels.com/media/users/3/164646/isolated/preview/163221e39ed03d4373bdaab895c1e489-uae-flag-language-icon.png",
    "https://icons.iconarchive.com/icons/wikipedia/flags/1024/AR-Argentina-Flag-icon.png",
    "https://www.pngmart.com/files/22/Antarctica-Flag-PNG-Photo.png",
    "",
    "https://th.bing.com/th/id/R.8ad232a954228fed85862a4dd7cc9a0f?rik=Mn1IvJ7J880YRA&riu=http%3a%2f%2fwww.nationalflags.shop%2fWebRoot%2fvilkasfi01%2fShops%2f2014080403%2f53E6%2f2F62%2fE5AC%2fC1FA%2fEA34%2f0A28%2f100B%2f0455%2fPoland_flag.png&ehk=xkR0aX9zbvdZp6RERp1S26Aj5EveTVKqX5yiup3g9p8%3d&risl=&pid=ImgRaw&r=0",
    "https://www.pngmart.com/files/22/Portugal-Flag-PNG.png",
    "https://icons.iconarchive.com/icons/wikipedia/flags/1024/RO-Romania-Flag-icon.png",
    "https://icons.iconarchive.com/icons/wikipedia/flags/1024/RS-Serbia-Flag-icon.png",
    "https://th.bing.com/th/id/R.e49ace9c7cc5246d5b3ce661148e9540?rik=vwAD9k8VargyFQ&riu=http%3a%2f%2fmommymaleta.com%2fwp-content%2fuploads%2f2015%2f04%2fRussia.png&ehk=fBAeFJGjVk%2bR6SZY9CDu%2f%2bKce5vydwsVfnLbcOPBLbQ%3d&risl=&pid=ImgRaw&r=0",
    "https://th.bing.com/th/id/R.a3aa863098cadde7811d060c19a577a5?rik=WxYXOrERiWlkWg&riu=http%3a%2f%2fpngimg.com%2fuploads%2fflags%2fflags_PNG14592.png&ehk=l6uk9ukY0A9EzusdmOcFhvEVJulteQLHVeBzkvIJNwE%3d&risl=&pid=ImgRaw&r=0"
  ];
  List<String> language = [
    "ar",
    "de",
    "en",
    "es",
    "fr",
    "he",
    "it",
    "nl",
    "no",
    "pt",
    "ru",
    "sv",
    "ud",
    "zh"
  ];
  List<String> category = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<String> country = [
    "in",
    "ae",
    "ar",
    "ata",
    "ub",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "us",
  ];
  NewsApiRestModel? restmodel;
  bool isLoading = false;

  NewsApiRestModel? restbyCategory;
  int categoryIndex = 0;
  NewsApiRestModel? restbyCounty;
  String CountryIndex = "in";
  NewsApiRestModel? restbyLanguage;
  String languageIndex = "en";

  Future getLanguageData() async {
    Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?language=${languageIndex}&apiKey=76859884d96f4459b29d1c4a35da338b");
    var resp = await http.get(uri);
    if (resp.statusCode == 200) {
      var decodedData = jsonDecode(resp.body);
      restbyLanguage = NewsApiRestModel.fromJson(decodedData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  getlanguage(var value) {
    languageIndex = value;
    notifyListeners();
    getCategoryData();
    getCountyData();
  }

  Future getCountyData() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${CountryIndex}&apiKey=9cd3e337b1f041749fde5de4043474fe");

    var resp = await http.get(url);
    if (resp.statusCode == 200) {
      var decodedData = jsonDecode(resp.body);
      restbyCounty = NewsApiRestModel.fromJson(decodedData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  getCOuntry(var value) {
    CountryIndex = value;

    getCategoryData();
    notifyListeners();
  }

  Future getCategoryData() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?language=${languageIndex}&country=${CountryIndex}&category=${category[categoryIndex]}&apiKey=76859884d96f4459b29d1c4a35da338b");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodeData = jsonDecode(res.body);
      restbyCategory = NewsApiRestModel.fromJson(decodeData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  getCategory(int value) {
    categoryIndex = value;
    getCategoryData();
    notifyListeners();
  }

  // Search Function to fetch news based on a search query
  Future searchNews(String query) async {
    isLoading = true;
    notifyListeners();

    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&language=${languageIndex}&apiKey=76859884d96f4459b29d1c4a35da338b");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodeData = jsonDecode(res.body);
      restmodel = NewsApiRestModel.fromJson(decodeData);
    } else {
      print("failed");
    }

    isLoading = false;
    notifyListeners();
  }
}
