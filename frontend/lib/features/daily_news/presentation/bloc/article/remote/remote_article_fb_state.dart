import 'package:equatable/equatable.dart';

abstract class ArticleStateFB extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleStateFB {}

class ArticleLoading extends ArticleStateFB {}

class ArticleCreated extends ArticleStateFB {
  final String message;

  ArticleCreated() : message = "Artículo creado correctamente";
}

class ArticleErrorFB extends ArticleStateFB {
  final String message;

  ArticleErrorFB(this.message);

  @override
  List<Object?> get props => [message];
}
