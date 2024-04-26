// class Book {
//   int? bookId;
//   String title;
//   String author;
//   String genre;
//   double price;
//   bool availability;
//
//   Book({
//     this.bookId,
//     required this.title,
//     required this.author,
//     required this.genre,
//     required this.price,
//     required this.availability,
//   });
//
//   // تحويل البيانات من Map إلى كائن Book
//   factory Book.fromJson(Map<String, dynamic> json) => Book(
//     bookId: json['bookId'],
//     title: json['title'],
//     author: json['author'],
//     genre: json['genre'],
//     price: json['price'].toDouble(),
//     availability: json['availability'],
//   );
//
//   // تحويل كائن Book إلى Map
//   Map<String, dynamic> toJson() => {
//     'bookId': bookId,
//     'title': title,
//     'author': author,
//     'genre': genre,
//     'price': price,
//     'availability': availability,
//   };
// }


class Book {
  final int bookId;
  final String title;
  final String author;
  final String genre;
  final double price;
  final int availability;
  final String createdAt;
  final String updatedAt;

  Book({
    required this.bookId,
    required this.title,
    required this.author,
    required this.genre,
    required this.price,
    required this.availability,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      genre: json['genre'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      availability: json['availability'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }


}