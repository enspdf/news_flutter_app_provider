import 'package:flutter/material.dart';
import 'package:news_app_provider/src/models/news_models.dart';
import 'package:news_app_provider/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(
          article: this.news[index],
          index: index,
        );
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article article;
  final int index;

  const _New({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(
          article,
          index,
        ),
        _CardTitle(article),
        _CardImage(article),
        _CardBody(article),
        _CardButtons(),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article article;
  const _CardBody(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        (article.description != null) ? article.description : "",
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article article;
  const _CardImage(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          child: (article.url != null)
              ? FadeInImage(
                  placeholder: AssetImage("assets/img/giphy.gif"),
                  image: NetworkImage(article.urlToImage),
                )
              : Image(
                  image: AssetImage("assets/img/no-image.png"),
                ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article article;
  const _CardTitle(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article article;
  final int index;

  const _CardTopBar(this.article, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "${index + 1}.",
            style: TextStyle(
              color: myTheme.accentColor,
            ),
          ),
          Text("${article.source.name}.")
        ],
      ),
    );
  }
}
