import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/data/model/api_result_model.dart';
import 'package:bloc_pattern/data/repository/article_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({@required this.repository});

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();

      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e);
      }
    }
  }
}
