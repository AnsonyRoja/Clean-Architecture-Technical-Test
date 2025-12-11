import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository_fb.dart';

class CreateArticle {
  final ArticleRepositoryFB repository;

  CreateArticle(this.repository);

  Future<void> call(
    ArticleEntity article,
  ) async {
    return await repository.createArticles(article);
  }
}
