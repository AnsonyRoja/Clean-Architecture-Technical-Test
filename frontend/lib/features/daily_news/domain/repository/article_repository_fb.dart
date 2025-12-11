import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepositoryFB {
  Future<void> createArticles(ArticleEntity article);
}
