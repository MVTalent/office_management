class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  Article(
      {this.author, this.title, this.description, this.url, this.urlToImage});

  factory Article.fromJson(Map json) {
    return Article(
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage']);
  }
}