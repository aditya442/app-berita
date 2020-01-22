import 'package:bloc_pattern/bloc/article/bloc.dart';
import 'package:bloc_pattern/data/model/api_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(
      builder: (context) {
        return Material(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Berita'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    articleBloc.add(FetchArticleEvent());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {},
                )
              ],
            ),
            body: Container(
              child: BlocListener<ArticleBloc, ArticleState>(
                listener: (BuildContext context, ArticleState state) {
                  if (state is ArticleErrorState) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                    if (state is ArticleInitialState) {
                      return buildLoading();
                    } else if (state is ArticleLoadingState) {
                      return buildLoading();
                    } else if (state is ArticleLoadedState) {
                      return buildArticleList(state.articles);
                    } else if (state is ArticleErrorState) {
                      return buildErrorUi(state.message);
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(message, style: TextStyle(color: Colors.red))),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(articles[item].urlToImage),
              ),
              title: Text(articles[item].title),
              subtitle: Text(articles[item].publishedAt),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
