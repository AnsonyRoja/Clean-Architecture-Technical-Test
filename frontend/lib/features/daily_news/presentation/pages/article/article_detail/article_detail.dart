import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/helpers/cleaning_text.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/article.dart';
import '../../../bloc/article/local/local_article_bloc.dart';
import '../../../bloc/article/local/local_article_event.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity? article;
  final bool isSaved;

  const ArticleDetailsView({Key? key, this.article, this.isSaved = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: InteractiveViewer(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(context),
          floatingActionButton:
              isSaved == true ? SizedBox() : _buildFloatingActionButton(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(context),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article!.title!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                article!.publishedAt!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if ((article?.urlToImage ?? "").isNotEmpty) {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  body: Center(
                    child: Hero(
                      tag: article!.urlToImage!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          article!.urlToImage!,
                          width: width * 0.95,
                          height: height * 0.6,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: width * 0.95,
                              height: height * 0.6,
                              child: const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 14,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildMaintenance404();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Hero(
          tag: article?.urlToImage ?? "",
          child: ClipRRect(
            child: Image.network(
              article?.urlToImage ?? "",
              width: double.maxFinite,
              height: 250,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: double.maxFinite,
                  height: 250,
                  child: const Center(
                    child: CupertinoActivityIndicator(radius: 12),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return _buildMaintenance404();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenance404() {
    return Stack(
      children: [
        // Imagen de mantenimiento
        Positioned.fill(
          child: Image.asset(
            "assets/warnings/maintenance.png",
            fit: BoxFit.cover,
          ),
        ),

        // Desvanecido negro
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54, // Oscurecido final
                ],
              ),
            ),
          ),
        ),

        // Texto 404 centrado
        const Center(
          child: Text(
            "404",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black87,
                  offset: Offset(0, 3),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getFormattedArticleText() {
    String description = cleanText(article!.description);
    String content = cleanText(article!.content);

    if (description.isEmpty || content.isEmpty) {
      return content;
    }
    return '$description\n\n$content';
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        getFormattedArticleText(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.star, color: Colors.white),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }
}
