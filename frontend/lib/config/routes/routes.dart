import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/article/crate_article/create_article.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/article/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      case '/CreateArticles':
        return _materialRoute(const ArticleEditorScreen());

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
