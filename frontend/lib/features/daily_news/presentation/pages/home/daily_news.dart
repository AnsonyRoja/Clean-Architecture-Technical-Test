import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/article/article_detail/article_detail.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/new_icons_sparkle.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return _buildPage(theme);
  }

  AppBar _buildAppbar(BuildContext context, ThemeData theme) {
    return AppBar(
      title: Text(
        'Daily News',
        style: TextStyle(color: theme.colorScheme.surface),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: NewsIconWithSparkles(
              color: theme.colorScheme.surface,
              maxDx: 20,
              maxDy: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage(ThemeData theme) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return Scaffold(
              backgroundColor: theme.primaryColor,
              appBar: _buildAppbar(context, theme),
              body: const Center(child: CupertinoActivityIndicator()));
        }
        if (state is RemoteArticlesError) {
          return Scaffold(
              appBar: _buildAppbar(context, theme),
              body: const Center(child: Icon(Icons.refresh)));
        }
        if (state is RemoteArticlesDone) {
          return _buildArticlesPage(context, state.articles!, theme);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticlesPage(
      BuildContext context, List<ArticleEntity> articles, ThemeData theme) {
    List<Widget> articleWidgets = [];
    for (var article in articles) {
      articleWidgets.add(ArticleWidget(
        article: article,
        onArticlePressed: (article) => _onArticlePressed(context, article),
      ));
    }

    return Scaffold(
      appBar: _buildAppbar(context, theme),
      body: ListView(
        children: articleWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/CreateArticles',
          );
        },
        child: Icon(Icons.add, color: theme.colorScheme.surface),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ArticleDetailsView(article: article, isSaved: false),
      ),
    );
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
