import 'dart:io';

import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/fb_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository_fb.dart';

class ArticleRepositoryImplFB implements ArticleRepositoryFB {
  final ArticleRemoteDataSourceFB remoteDataSource;
  final File? image;

  ArticleRepositoryImplFB({
    required this.remoteDataSource,
    this.image,
  });

  @override
  Future<void> createArticles(ArticleEntity article) {
    return remoteDataSource.createArticle(article);
  }
}
