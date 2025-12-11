import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleEventFB extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateArticleEvent extends ArticleEventFB {
  final ArticleEntity article;

  CreateArticleEvent({
    required this.article,
  });

  @override
  List<Object?> get props => [article];
}
