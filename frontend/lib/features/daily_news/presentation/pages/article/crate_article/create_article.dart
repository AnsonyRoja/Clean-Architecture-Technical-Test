import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/firebase/article/remote_article_fb_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/firebase/article/remote_article_fb_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/firebase/article/remote_article_fb_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/helpers/audio_players.dart';

class ArticleEditorScreen extends StatefulWidget {
  const ArticleEditorScreen({Key? key}) : super(key: key);

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  File? _selectedImage;
  bool isUploadingImage = false;
  bool isPublishingArticle = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isUploadingImage = true;
      });

      // Simula una carga de imagen (puedes reemplazar con tu lógica de subida)
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _selectedImage = File(pickedFile.path);
        isUploadingImage = false;
      });
    }
  }

  Future<void> _publishArticle() async {
    if (!_formKey.currentState!.validate()) {
      // Si alguno no es válido, no hacemos nada
      return;
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      isPublishingArticle = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulación

    setState(() {
      isPublishingArticle = false;
    });

    final article = ArticleEntity(
        title: _titleController.text,
        description: _bodyController.text,
        slImg: _selectedImage);

    context.read<ArticleBlocFB>().add(CreateArticleEvent(
          article: article,
        ));
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Ionicons.chevron_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: BlocListener<ArticleBlocFB, ArticleStateFB>(
                  listener: (context, state) {
                    if (state is ArticleLoading) {
                      setState(() => isPublishingArticle = true);
                    } else {
                      setState(() => isPublishingArticle = false);
                    }

                    if (state is ArticleCreated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      Navigator.pop(context);
                    }

                    if (state is ArticleErrorFB) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Título
                          _buildTextFormF(width, 1),

                          // Botón de imagen
                          _selectedImage == null
                              ? _buildAtachImage(theme)
                              : SizedBox(),

                          // Imagen seleccionada
                          if (_selectedImage != null) _buildImageSelected(),

                          _buildTextFormF(width, 15)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: _buildButtonPublish(theme, width),
      ),
    );
  }

  ElevatedButton _buildAtachImage(ThemeData theme) {
    return ElevatedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.camera_alt, color: Colors.white),
      label: const Text(
        'Attach Image',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  Stack _buildImageSelected() {
    return Stack(
      children: [
        Image.file(
          _selectedImage!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),

        // Botón de eliminar
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedImage = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),

        // Loader si está subiendo
        if (isUploadingImage)
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
      ],
    );
  }

  SafeArea _buildButtonPublish(ThemeData theme, double width) {
    return SafeArea(
      bottom: true,
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton.icon(
          onPressed: isPublishingArticle
              ? null
              : () {
                  _publishArticle();
                  playClickSound();
                },
          icon: isPublishingArticle
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                )
              : const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
          label: Text(
            isPublishingArticle ? 'Publishing...' : 'Publish Article',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            minimumSize: const Size(double.infinity, 70),
            shape: const RoundedRectangleBorder(),
          ),
        ),
      ),
    );
  }

  Container _buildTextFormF(double width, maxLines) {
    return Container(
      width: width * 0.9,
      margin: EdgeInsets.only(
          bottom: maxLines > 1 ? 75 : 25, top: maxLines > 1 ? 25 : 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withValues(), // menor opacidad = más transparente
              spreadRadius: 2,
              blurRadius: 5, // agrega suavizado al borde de la sombra
              offset: Offset(0, 3), // opcional: mueve la sombra hacia abajo
            ),
          ]),
      child: TextFormField(
          validator: (value) {
            if (maxLines == 1) {
              if (value == null || value.isEmpty) {
                return "Please enter a title";
              } else if (value.length > 100) {
                return "You cannot enter more than 100 characters in this field";
              } else if (value.length < 5) {
                return "The title must be more than 5 characters long";
              }
            } else {
              if (value!.length > 450) {
                return "The article cannot exceed 450 characters";
              } else if (value.length < 10) {
                return "The article must be at least 10 characters long";
              }
            }

            return null;
          },
          maxLines: maxLines,
          controller: maxLines == 1 ? _titleController : _bodyController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: maxLines == 1
                ? 'Write your title here...'
                : "Add article here...",
            border: InputBorder.none,
          )),
    );
  }
}
