import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticleEvent extends Equatable{}

class FetchArticleEvent extends ArticleEvent {
  @override
  List<Object> get props => [];

}
