import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/create_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_fb_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_fb_state.dart';

class ArticleBlocFB extends Bloc<ArticleEventFB, ArticleStateFB> {
  final CreateArticle createArticleUseCase;

  ArticleBlocFB(this.createArticleUseCase) : super(ArticleInitial()) {
    on<CreateArticleEvent>((event, emit) async {
      emit(ArticleLoading());

      try {
        await createArticleUseCase(event.article);
        emit(ArticleCreated());
      } catch (e) {
        emit(ArticleErrorFB(e
            .toString())); // Se deberia agregar un mensaje, para el cliente y no para el desarrollador
      }
    });
  }
}
