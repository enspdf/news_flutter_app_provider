import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_provider/src/models/category_model.dart';
import 'package:news_app_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _NEWS_URL = "https://newsapi.org/v2";
final _API_KEY = "8ba14bf74adf4bdc9e12498addd60b6e";

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = "business";

  List<Category> categories = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "tecnology"),
  ];

  Map<String, List<Article>> categoryArticle = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticle[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);

    notifyListeners();
  }

  List<Article> get getArticlesCategorySelected =>
      this.categoryArticle[this.selectedCategory];

  getTopHeadlines() async {
    final url = "$_NEWS_URL/top-headlines?apiKey=$_API_KEY&country=co";
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticle[category].length > 0) {
      return this.categoryArticle[category];
    }

    final url =
        "$_NEWS_URL/top-headlines?apiKey=$_API_KEY&country=co&category=$category";
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticle[category].addAll(newsResponse.articles);

    notifyListeners();
  }
}
