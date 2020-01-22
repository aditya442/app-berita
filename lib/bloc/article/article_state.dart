
import 'package:bloc_pattern/data/model/api_result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticleState extends Equatable {}
  
class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {
  final List<Articles> articles;
  
  ArticleLoadedState({@required this.articles});
  @override
  List<Object> get props => [articles];
}

class ArticleErrorState extends ArticleState {
  final String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => [message];

}

